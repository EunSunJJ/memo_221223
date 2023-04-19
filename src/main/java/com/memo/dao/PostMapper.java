package com.memo.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

@Repository
public interface PostMapper {

	// input : 전체 select라 없음
	// output : List다 불러와~~
	public List<Map<String, Object>> selectPostList();

	// insert할 값만 넘기면 된다 : userLoginId,
	// file도 DB저장 된 이름으로 file -> imagePath로 바꿈 
	public int insertPost(
			@Param("userId") int userId, 
			@Param("subject") String subject, 
			@Param("content") String content, 
			@Param("imagePath") String imagePath);
}
