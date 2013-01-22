package com.yecoo.web;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import com.yecoo.dao.RoleDaoImpl;
import com.yecoo.dao.UserDaoImpl;
import com.yecoo.model.CodeTableForm;
import com.yecoo.util.Constants;
import com.yecoo.util.Md5;
import com.yecoo.util.StrUtils;
import com.yecoo.util.dwz.AjaxObject;
/**
 * 用户管理
 * @author zhoujd
 */
@Controller
@RequestMapping("/user")
public class UserAction {

	private UserDaoImpl userDaoImpl = new UserDaoImpl();
	private RoleDaoImpl roleDaoImpl = new RoleDaoImpl();

	/**
	 * 用户列表
	 * 
	 * @param form
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequiresPermissions("User:view")
	@RequestMapping(value = "/list")
	public String list(CodeTableForm form, HttpServletRequest request) {

		String act = StrUtils.nullToStr(request.getAttribute("act"));
		String sPageNum = StrUtils.nullToStr(request.getParameter("pageNum"));
		String sNumPerPage = StrUtils.nullToStr(request.getParameter("numPerPage"));
		int pageNum = 1;
		int numPerPage = Constants.NUMPERPAGE;
		if (!act.equals("excel") && !sPageNum.equals("")) {
			pageNum = Integer.parseInt(sPageNum);
		}
		if (act.equals("excel")) {
			numPerPage = Constants.NUMPERPAGE_EXCEL;
		} else if (!sNumPerPage.equals("")) {
			numPerPage = Integer.parseInt(sNumPerPage);
		}
		request.setAttribute("pageNum", pageNum); // 当前页
		request.setAttribute("numPerPage", numPerPage); // 每页数量

		int totalCount = userDaoImpl.getUserCount(form);
		request.setAttribute("totalCount", totalCount); // 列表总数量
		List<CodeTableForm> userList = userDaoImpl.getUserList(form, pageNum, numPerPage);
		request.setAttribute("userList", userList); // 用户列表

		List<CodeTableForm> roleList = roleDaoImpl.getRoleList();
		request.setAttribute("roleList", roleList); //角色列表

		request.setAttribute("form", form);
		request.setAttribute("act", act);
		return "user/list";
	}

	/**
	 * 用户列表导出
	 * 
	 * @param form
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequiresPermissions("User:view")
	@RequestMapping(value = "/list_excel")
	public String list_excel(CodeTableForm form, HttpServletRequest request) {
		
		request.setAttribute("act", "excel");
		return this.list(form, request);
	}

	@RequiresPermissions("User:add")
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String toAdd(HttpServletRequest request) {

		CodeTableForm form = new CodeTableForm();
		request.setAttribute("form", form);

		List<CodeTableForm> roleList = roleDaoImpl.getRoleList();
		request.setAttribute("roleList", roleList);
		return "user/add";
	}

	@RequiresPermissions("User:add")
	@ResponseBody
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public String doAdd(CodeTableForm form) {
		
		AjaxObject ajaxObject = null;
		if(validUserid(form).equals("false")) {
			ajaxObject = new AjaxObject("用户账号已存在");
		} else {
			int iReturn = userDaoImpl.addUser(form);
			if (iReturn >= 0) {
				ajaxObject = new AjaxObject("新增成功！", "user_list", "closeCurrent");
			} else {
				ajaxObject = new AjaxObject("新增失败");
			}
		}
		return ajaxObject.toString();
	}
	
	/**
	 * 进入修改用户
	 * Restful模式路径： 注意这里/update/{userid}和@PathVariable("userid")中userid要一致，
	 * 这样不管用debug模式还是release模式编译都没问题 也可以简写成@PathVariable int
	 * id，但这样只能以debug模式编译的时候正确，如果用release编译就不正确了，因为如果用release模式编译会把参数的名字改变的
	 * 一般IDE工具都是以debug模式编译的，javac是以release模式编译的 同样的请求路径 user/update
	 * 如果是get请求就转到增加页面去，如果是post请求就做update操作
	 * 
	 * @param userid
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequiresPermissions("User:edi")
	@RequestMapping(value = "/edi/{userid}", method = RequestMethod.GET)
	public String toEdi(@PathVariable("userid") String userid,
			HttpServletRequest request) {

		CodeTableForm form = null;
		form = userDaoImpl.getUserById(userid);
		request.setAttribute("form", form);

		List<CodeTableForm> roleList = roleDaoImpl.getRoleList();
		request.setAttribute("roleList", roleList);
		return "user/edi";
	}

	/**
	 * 修改用户
	 * 
	 * @param form
	 * @param model
	 * @return
	 * @throws Exception 
	 * @throws Exception
	 */
	@RequiresPermissions("User:edi")
	@ResponseBody
	@RequestMapping(value = "/edi", method = RequestMethod.POST)
	public String doEdi(CodeTableForm form) {
		
		AjaxObject ajaxObject = null;
		int iReturn = userDaoImpl.ediUser(form);
		if (iReturn >= 0) {
			ajaxObject = new AjaxObject("修改成功！", "user_list", "closeCurrent");
		} else {
			ajaxObject = new AjaxObject("修改失败");
		}
		return ajaxObject.toString();
	}

	/**
	 * 验证用户账号是否可用
	 * 
	 * @param form
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/validUserid")
	public String validUserid(CodeTableForm form) {
		
		String result = "false";
		String userid = StrUtils.nullToStr(form.getValue("userid"));
		CodeTableForm codeTableForm = userDaoImpl.getUserById(userid);
		if (codeTableForm == null) {
			result = "true";
		}
		return result;
	}

	/**
	 * 删除用户
	 * 
	 * @param userid
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequiresPermissions("User:delete")
	@ResponseBody
	@RequestMapping(value = "/delete/{userid}")
	public String delete(@PathVariable("userid") String userid, HttpServletRequest request) {
		
		AjaxObject ajaxObject = null;
		int iReturn = 0;
		if ("0".equals(userid)) {
			String[] ids = request.getParameterValues("ids");
			userid = StrUtils.ArrayToStr(ids, "','");
		}
		iReturn = userDaoImpl.deleteUsers("'" + userid + "'");
		if (iReturn >= 0) {
			ajaxObject = new AjaxObject("删除成功！", "", "");
		} else {
			ajaxObject = new AjaxObject("删除失败");
		}
		return ajaxObject.toString();
	}

	/**
	 * 进入修改密码
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/changePasswd", method = RequestMethod.GET)
	public String toChangePasswd() {

		return "user/changePasswd";
	}
	
	@ResponseBody
	@RequestMapping(value = "/changePasswd", method = RequestMethod.POST)
	public String changePasswd(CodeTableForm form, HttpServletRequest request) {
		
		AjaxObject ajaxObject = null;
		if(checkPasswd(form, request).equals("false")) {
			ajaxObject = new AjaxObject("原密码错误");
		} else {
			int iReturn = userDaoImpl.changePassword(form);
			if (iReturn >= 0) {
				ajaxObject = new AjaxObject("修改成功！", "", "closeCurrent");
			} else {
				ajaxObject = new AjaxObject("修改失败");
			}
		}
		return ajaxObject.toString();
	}

	/**
	 * 验证用户密码是否正确
	 * 
	 * @param form
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/checkPasswd")
	public String checkPasswd(CodeTableForm form, HttpServletRequest request) {

		String result = "false";
		String oldPasswd = StrUtils.nullToStr(form.getValue("oldPasswd"));
		Md5 md5 = new Md5();
		oldPasswd = md5.md5(oldPasswd); //加密密码
		String userid = StrUtils.nullToStr(((CodeTableForm)request.getSession().getAttribute("userSessionInfo"))
			.getValue("userid"));
		CodeTableForm codeTableForm = userDaoImpl.getUserById(userid);
		if (codeTableForm != null && oldPasswd.equals(codeTableForm.getValue("passwd"))) {
			result =  "true";
		}
		return result;
	}
}