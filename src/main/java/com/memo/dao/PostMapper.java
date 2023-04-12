package com.memo.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository
public interface PostMapper {

	// input : 전체 select라 없음
	// output : List다 불러와~~
	public List<Map<String, Object>> selectPostList();
}
