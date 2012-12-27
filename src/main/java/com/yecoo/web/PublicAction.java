package com.yecoo.web;

import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import com.yecoo.dao.UserDaoImpl;
import com.yecoo.model.CodeTableForm;
import com.yecoo.util.Constants;
import com.yecoo.util.StrUtils;
/*
 * 不需要实现任何接口，也不需要继承任何的类
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
	 * 
	 * 返回值可以是：String（视图名），void（用于直接response），ModelAndView，Map，
	 * Model，任意其它任意类型的对象（默认放入model中，名称即类型的首字母改成小写），视图名默认是请求路径
	 */
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public ModelAndView toLogin(CodeTableForm form, HttpServletRequest request, Model model) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("login");
		return mav;
	}
	/**
	 * 用户登录
	 */
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(CodeTableForm form, HttpServletRequest request, Model model) {
		CodeTableForm user1 = daoImpl.getUserById(StrUtils.nullToStr(form.getValue("userid")).toUpperCase());
		request.setAttribute("user", form);
		if (user1 == null) {
			model.addAttribute("message", "用户不存在");
			return "login";
		} else if (!StrUtils.nullToStr(form.getValue("passwd")).equals(user1.getValue("passwd"))) {
			model.addAttribute("message", "密码错误");
			return "login";
		} else {
			request.getSession().setAttribute(Constants.USER_INFO_SESSION, user1);
			return "index";
		}
	}
	/**
	 * 进入首页
	 */
	@RequestMapping(value = "/index")
	public String index(CodeTableForm form, HttpServletRequest request, Model model) {

		return "index";
	}
}
