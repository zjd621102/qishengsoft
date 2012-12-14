package com.yecoo.web;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.yecoo.dao.UserDaoImpl;
import com.yecoo.model.CodeTableForm;
import com.yecoo.util.Constants;
import com.yecoo.util.DbUtils;
import com.yecoo.util.StrUtils;

@Controller
@RequestMapping("/user")
public class UserAction {

	private UserDaoImpl daoImpl = new UserDaoImpl();

	private DbUtils dbUtils = new DbUtils();

	/**
	 * 用户列表
	 * @param form
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/list")
	public String list(CodeTableForm form, HttpServletRequest request,
			Model model) throws Exception {
		
		String act = StrUtils.nullToStr(request.getAttribute("act"));
		String sPageNum = StrUtils.nullToStr(request.getParameter("pageNum"));
		String sNumPerPage = StrUtils.nullToStr(request.getParameter("numPerPage"));
		int pageNum = 1;
		int numPerPage = Constants.NUMPERPAGE;
		if (!act.equals("excel") && !sPageNum.equals("")) {
			pageNum = Integer.parseInt(sPageNum);
		}
		if(act.equals("excel")) {
			numPerPage = Constants.NUMPERPAGE_EXCEL;
		} else if (!sNumPerPage.equals("")) {
			numPerPage = Integer.parseInt(sNumPerPage);
		}
		request.setAttribute("pageNum", pageNum); // 当前页
		request.setAttribute("numPerPage", numPerPage); // 每页数量
		
		int totalCount = daoImpl.getUserCount(form);
		request.setAttribute("totalCount", totalCount); // 列表总数量
		List<CodeTableForm> userList = daoImpl.getUserList(form, pageNum, numPerPage);
		request.setAttribute("userList", userList); // 用户列表
		
		String sql = "SELECT roleid, rolename FROM srole ORDER BY disport";
		List<CodeTableForm> roleList = dbUtils.getListBySql(sql);
		request.setAttribute("roleList", roleList); // 部门列表
		
		request.setAttribute("form", form);
		request.setAttribute("act", act);
		return "user/list";
	}
	
	/**
	 * 用户列表导出
	 * @param form
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/list_excel")
	public String list_excel(CodeTableForm form, HttpServletRequest request,
			Model model) throws Exception {
		request.setAttribute("act", "excel");
		return this.list(form, request, model);
	}

	/**
	 * 进入修改用户 Restful模式路径： 注意这里/update/{id}和@PathVariable("id")中id要一致，
	 * 这样不管用debug模式还是release模式编译都没问题 也可以简写成@PathVariable int
	 * id，但这样只能以debug模式编译的时候正确，如果用release编译就不正确了，因为如果用release模式编译会把参数的名字改变的
	 * 一般IDE工具都是以debug模式编译的，javac是以release模式编译的 同样的请求路径 user/update
	 * 如果是get请求就转到增加页面去，如果是post请求就做update操作
	 * @param userid
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/edi/{userid}", method = RequestMethod.GET)
	public String toEdi(@PathVariable("userid") String userid, Model model)
			throws Exception {
		CodeTableForm form = null;
		if (userid.equals("0")) {
			form = new CodeTableForm();
		} else {
			form = daoImpl.getUserById(userid);
		}
		model.addAttribute("form", form);

		String sql = "select roleid, rolename from srole order by disport";
		List<CodeTableForm> roleList = dbUtils.getListBySql(sql);
		model.addAttribute("roleList", roleList);
		return "user/edi";
	}
	
	/**
	 * 修改用户
	 * @param form
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/edi", method = RequestMethod.POST)
	public String doEdi(CodeTableForm form, Model model) throws Exception {
		try {
			int iReturn = daoImpl.updateUser(form);
			if (iReturn >= 1) {
				model.addAttribute("statusCode", "200");
				model.addAttribute("message", "操作成功");
				model.addAttribute("navTabId", "user_list");
				model.addAttribute("callbackType", "closeCurrent");
			} else {
				model.addAttribute("statusCode", "300");
				model.addAttribute("message", "操作失败");
			}
			model.addAttribute("form", form);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "pub/jsonResult";
		// 重定向，防止重复提交，以“/”开关，相对于当前项目根路径，不以“/”开关，相对于当前路径
		// return "redirect:/user/list";
	}

	/**
	 * 验证用户账号是否可用
	 * @param form
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/validUserid")
	public String validUserid(CodeTableForm form, Model model) throws Exception {
		try {
			String userid = StrUtils.nullToStr(form.getValue("userid"));
			CodeTableForm codeTableForm = daoImpl.getUserById(userid);
			if (codeTableForm == null) {
				model.addAttribute("result", "true");
			} else {
				model.addAttribute("result", "false");
			}
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("result", "false");
		}
		return "pub/result";
	}

	/**
	 * 删除用户
	 * @param userid
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/delete/{userid}")
	public String delete(@PathVariable("userid") String userid, HttpServletRequest request)
			throws Exception {
		try {
			int iReturn = 0;
			if("0".equals(userid)) {
				String[] ids = request.getParameterValues("ids");
				userid =StrUtils.ArrayToStr(ids, "','");
			}
			iReturn = daoImpl.deleteUsers("'" + userid + "'");
			if (iReturn >= 1) {
				request.setAttribute("statusCode", "200");
				request.setAttribute("message", "删除成功");
			} else {
				request.setAttribute("statusCode", "300");
				request.setAttribute("message", "删除失败");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "pub/jsonResult";
	}

	/**
	 * 进入修改密码
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/toChangePasswd", method = RequestMethod.GET)
	public String toChangePasswd() throws Exception {
		return "user/changePasswd";
	}

	/**
	 * 验证用户密码是否正确
	 * 
	 * @param form
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/checkPasswd")
	public String checkPasswd(CodeTableForm form, HttpServletRequest request)
			throws Exception {
		try {
			String oldPasswd = StrUtils.nullToStr(form.getValue("oldPasswd"));
			String userid = StrUtils.nullToStr(((CodeTableForm) request
					.getSession().getAttribute("userSessionInfo"))
					.getValue("userid"));
			CodeTableForm codeTableForm = daoImpl.getUserById(userid);
			if (codeTableForm != null
					&& oldPasswd.equals(codeTableForm.getValue("passwd"))) {
				request.setAttribute("result", "true");
			} else {
				request.setAttribute("result", "false");
			}
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("result", "false");
		}
		return "pub/result";
	}
	
	/**
	 * 获取部门下拉框
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/queryRoleList")
	public String queryRoleList(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		try {
			String sql = "SELECT roleid selectid, rolename selectname FROM srole ORDER BY disport";
			List<CodeTableForm> roleList = dbUtils.getListBySql(sql);
			request.setAttribute("roleList", roleList); // 部门列表
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "pub/jsonSelect";
	}
}