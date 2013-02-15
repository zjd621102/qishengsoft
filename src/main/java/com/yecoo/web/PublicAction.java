package com.yecoo.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import com.yecoo.dao.UserDaoImpl;
import com.yecoo.model.CodeTableForm;
import com.yecoo.util.Constants;
import com.yecoo.util.DbUtils;
import com.yecoo.util.StrUtils;
import com.yecoo.util.dwz.AjaxObject;
/**
 * 公共管理
 * @author zhoujd
 */
@Controller
public class PublicAction {

	private UserDaoImpl daoImpl = new UserDaoImpl();

	/**
	 * 进入用户登录界面
	 * 
	 * 方法都可以接受的参数（参数数量和顺序没有限制）：
	 * HttpServletRequest，HttpServletRespons，HttpSession（session必须是可用的），
	 * PrintWriter，Map,Model，@PathVariable（任意多个），@RequestParam（任意多个），
	 * @CookieValue（任意多个），@RequestHeader，Object（pojo对象），BindingResult等等
	 */
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String toLogin() {

		return "login";
	}

	/**
	 * 用户登录
	 */
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(HttpServletRequest request) {

		String username = StrUtils.nullToStr(request.getParameter("username")).toUpperCase();
		String password = StrUtils.nullToStr(request.getParameter("password")).toUpperCase();
		String msg = "";
		
		try {
			UsernamePasswordToken token = new UsernamePasswordToken(username, password);
			SecurityUtils.getSubject().login(token);
			CodeTableForm user1 = daoImpl.getUserById(username);
			request.getSession().setAttribute(Constants.USER_INFO_SESSION, user1); //用户信息
			
			String sql = "SELECT * FROM smodule a WHERE EXISTS (SELECT 1 FROM spermission b, suser_role c"
					+ " WHERE b.roleid = c.roleid and b.permission = concat(a.sn ,':view') and c.userid = '"
					+ username +"') ORDER BY a.priority, a.parentid, a.moduleid";
			DbUtils dbUtils = new DbUtils();
			List<CodeTableForm> menuList = dbUtils.getListBySql(sql); //菜单信息
			request.getSession().setAttribute(Constants.MENU_INFO_SESSION, menuList);
			return "index";
		} catch (UnknownAccountException ex) {
			msg = "（用户不存在）";
		} catch (IncorrectCredentialsException ex) {
			msg = "（密码错误）";
		}catch (AuthenticationException e) {
			e.printStackTrace();
			msg = "（其他的登录错误）";
		}
		
		request.setAttribute("msg", msg);
		return "login";
	}

	/**
	 * 退出
	 */
	@RequestMapping(value = "/logout")
	public String logout(HttpServletRequest request) {

		Subject subject = SecurityUtils.getSubject();
		subject.logout();
		request.getSession().removeAttribute(Constants.USER_INFO_SESSION);
		request.getSession().removeAttribute(Constants.MENU_INFO_SESSION);
		return "login";
	}

	/**
	 * 进入首页
	 */
	@RequestMapping(value = "/index")
	public String index() {

		return "index";
	}

	@RequestMapping(value = "/loginDialog", method = RequestMethod.GET)
	public String toLoginDialog() {

		return "loginDialog";
	}

	/**
	 * 用户登录
	 */
	@ResponseBody
	@RequestMapping(value = "/loginDialog", method = RequestMethod.POST)
	public String loginDialog(HttpServletRequest request) {

		String username = StrUtils.nullToStr(request.getParameter("username")).toUpperCase();
		String password = StrUtils.nullToStr(request.getParameter("password")).toUpperCase();
		
		try {
			UsernamePasswordToken token = new UsernamePasswordToken(username, password);
			SecurityUtils.getSubject().login(token);
			CodeTableForm user1 = daoImpl.getUserById(username);
			request.getSession().setAttribute(Constants.USER_INFO_SESSION, user1);
			AjaxObject ajaxObject = new AjaxObject("登录成功", "", "closeCurrent");
			return ajaxObject.toString();
		} catch (UnknownAccountException ex) {
			AjaxObject ajaxObject = new AjaxObject("用户不存在");
			return ajaxObject.toString();
		} catch (IncorrectCredentialsException ex) {
			AjaxObject ajaxObject = new AjaxObject("密码错误");
			return ajaxObject.toString();
		}catch (AuthenticationException e) {
			AjaxObject ajaxObject = new AjaxObject("其他的登录错误");
			return ajaxObject.toString();
		}
	}
}