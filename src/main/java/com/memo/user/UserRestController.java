package com.memo.user;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
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
	
	@GetMapping("/is_duplicated_id")
	public Map<String, Object> isDuplicatedeId(
			@RequestParam("loginId") String loginId){
		
		// select 방식
		// 1. exist라는 쿼리를 만들어서 count쿼리를 boolean으로 return
		// 2. 하나의 행을 받아오고 NULL인지 아닌지 판단 -> user를 받아온다
		
		Map<String, Object> result = new HashMap<>();   
		// select
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
}
