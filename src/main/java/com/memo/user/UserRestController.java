package com.memo.user;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.memo.common.EncryptUtils;
import com.memo.user.bo.UserBO;
import com.memo.user.model.User;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@RequestMapping("/user")
@RestController
public class UserRestController {

	@Autowired
	private UserBO userBO;
	
	/**
	 * 아이디 중복확인 API
	 * @param loginId
	 * @return
	 */
	@GetMapping("/is_duplicated_id")
	public Map<String, Object> isDuplicatedeId(
			@RequestParam("loginId") String loginId){
		
		// select 방식
		// 1. exist라는 쿼리를 만들어서 count쿼리를 boolean으로 return
		// 2. 하나의 행을 받아오고 NULL인지 아닌지 판단 -> user를 받아온다
		
		Map<String, Object> result = new HashMap<>();   
		// select -> boolean이 아니고 하나의 객체를 받아온다 = user 1개를 받아온다
		User user = userBO.getUserLoginId(loginId);
		
		if (user != null) {
			result.put("code", 1);
			result.put("result",true);
		} else {
			result.put("code", 1);
			result.put("result",false);
			
		}
		return result;
	}
	
	/**
	 * 회원가입 API
	 * @param loginId
	 * @param password
	 * @param name
	 * @param email
	 * @return
	 */
	@PostMapping("/sign_up")
	public Map<String, Object> signUp(// 파라미터들 받아오기
			@RequestParam ("loginId") String loginId,
			@RequestParam ("password") String password,
			@RequestParam ("name") String name,
			@RequestParam ("email") String email) {
		
		// 비밀번호 해싱 - md5
		// aaaa => dkssudgktpdy
		// aaaa => dkssudgktpdy
		String hashedPassword = EncryptUtils.md5(password);
		
		// DB insert
		userBO.addUser(loginId, hashedPassword, name, email);
		
		Map<String, Object> result = new HashMap<>();
		result.put("code", 1);
		result.put("result", "성공");
		
		return result;
	}
	
	/**
	 * 로그인 API
	 * @param loginId
	 * @param password
	 * @param request
	 * @return
	 */
	@PostMapping("/sign_in")
	
	public Map<String, Object> signIn(
			@RequestParam("loginId") String loginId, 
			@RequestParam("password") String password, 
			HttpServletRequest request) {
		
		// password hashing
		String hashedPassword = EncryptUtils.md5(password);
		
		// select null or 1행 
		User user = userBO.getUserByLoginIdPassword(loginId, hashedPassword);
		
		// 로그인이 되어있다는 처리
		Map<String, Object> result = new HashMap<>();
		if (user != null) {  // 로그인
			result.put("code", 1);
			result.put("result","성공");
			
			// + 세션에 유저 정보 담기 (로그인 상태 유지) - 정보 일부만 담어야 해!
			// 비밀번호 같은 것 말고, 누구님 안녕하세요 = 유저정보를 보여주는 것
			HttpSession session = request.getSession();
			session.setAttribute("userId", user.getId());
			session.setAttribute("userName", user.getName());
			session.setAttribute("userLoginId", user.getLoginId());
			
		} else {   // 로그인 불가
			result.put("code", 500);
			result.put("errorMessage", "존재하지 않는 사용자 입니다");
		}
		
		// 응답 끝
		return result;
	}
}
