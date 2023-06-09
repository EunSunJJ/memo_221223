<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!-- 로고 -->
<div>
	<h1>MEMO 게시판</h1>
</div>

<!-- 로그인 정보 -->
	<div>
		<c:if test="${not empty userId}">
			<span>${userName}님 안녕하세요</span>
			<a href="/user/sign_out">로그아웃</a>
		</c:if> 
		<c:if test="${empty userId}">
			<div>
				<a href="/user/sign_in_view">로그인</a>
			</div>
		</c:if>
	</div>
