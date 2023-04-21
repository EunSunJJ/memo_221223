package com.memo.post;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.memo.post.bo.PostBO;
import com.memo.post.model.Post;

import jakarta.servlet.http.HttpSession;

@RequestMapping("/post")
@Controller
public class PostController {
	
	@Autowired
	private PostBO postBO;
	
	// 글목록 화면
	// http://localhost/post/post_list_view
	@GetMapping("/post_list_view")
	public String postListView(Model model, HttpSession session) {
		
		// NULL일 수가 있으니까 Integer로 받아와야 한다
		Integer userId = (Integer)session.getAttribute("userId");
		if (userId == null) {
			// 비로그인이면 로그인 페이지로 이동
			return "redirect:/user/sign_in_view";
		}
		
		List<Post> postList = postBO.getPostList();
		model.addAttribute("postList", postList);
		model.addAttribute("view", "post/postList");
		return "template/layout";
	}
	
	
	/**
	 * 글쓰기 화면
	 * @param model
	 * @return
	 */
	
	//  http://localhost/post/post_create_view
	@GetMapping("/post_create_view")
	public String postCreatView(Model model) {
		model.addAttribute("view","post/postCreate");
		return "template/layout";
	}
}
