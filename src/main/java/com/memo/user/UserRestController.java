package com.memo.user;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.memo.user.bo.UserBO;
import com.memo.user.model.User;

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
	
	
	@PostMapping("/sign_up")
	public Map<String, Object> signUp(// 파라미터들 받아오기
			@RequestParam ("loginId") String loginId,
			@RequestParam ("password") String password,
			@RequestParam ("name") String name,
			@RequestParam ("email") String email) {
		
		// 비밀번호 해싱 - md5
		// aaaa => dkssudgktpdy
		// aaaa => dkssudgktpdy
		
		
		// DB insert
		userBO.addUser(loginId, password, name, email, email);
		
		Map<String, Object> result = new HashMap<>();
		result.put("code", 1);
		result.put("result", "성공");
		
		return result;
	}
}
