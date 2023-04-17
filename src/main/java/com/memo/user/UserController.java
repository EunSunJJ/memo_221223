package com.memo.user;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpSession;

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
	public String signUpView(Model model) {
		model.addAttribute("view", "user/signUp");
		return "template/layout";
	}
	
	// 로그인 페이지
	//   http://localhost/user/sign_in_view
	@GetMapping("/sign_in_view")
	public String signInView(Model model) {
		model.addAttribute("view", "user/signIn");
		return "template/layout";
	}
	
	// 로그아웃
	@RequestMapping("/sign_out")
	public String signOut(HttpSession session) {
		// 세션에 있는 모든 것을 비운다
		session.removeAttribute("userId");
		session.removeAttribute("userName");
		session.removeAttribute("userLoginId");
		
		// 화면 이동
		return "redirect:/user/sign_in_view";
	}
	
}
