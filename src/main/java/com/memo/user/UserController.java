package com.memo.user;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/user")
@Controller
public class UserController {
	
	/**
	 * 회원가입 화면
	 * @param model
	 * @return
	 */
	
	
	// 회원가입 페이지 -> 중간에 껴들어가는 페이지만 교체해주기
	//   http://localhost/user/sign_up_view
	@GetMapping("/sign_up_view")
	public String singUpView(Model model) {
		model.addAttribute("user", "view/signUp");
		return "template/layout";
	}
}
