<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
</head>
<body>
	<div class="d-flex justify-content-center">
		<div class="login-box">
			<h1 class="mb-4">로그인</h1>

			<form id="loginForm" action="/user/sign_in" method="post">
				<div class="input-group mb-3">
					<%-- input-group-prepend: input box 앞에 ID 부분을 회색으로 붙인다. --%>
					<div class="input-group-prepend">
						<span class="input-group-text">ID</span>
					</div>
					<input type="text" class="form-control" id="loginId" name="loginId">
				</div>

				<div class="input-group mb-3">
					<div class="input-group-prepend">
						<span class="input-group-text">PW</span>
					</div>
					<input type="password" class="form-control" id="password"
						name="password">
				</div>

				<%-- btn-block: 로그인 박스 영역에 버튼을 가득 채운다. --%>
				<input type="button" id="loginBtn" class="btn btn-block btn-primary"
					value="로그인"> <a class="btn btn-block btn-dark"
					href="/user/sign_up_view">회원가입</a>
			</form>
		</div>
	</div>
	
<script>
$(document).ready(function(){
	// 로그인
	$("#loginBtn").on("click", function(){
		// alert("확인");
		
		// validation
		let loginId = $("#loginId").val().trim();
		let password = $("#password").val();
		
		if (!loginId) {
			alert("아이디를 입력하세요");
			return;
		}
		
		if (!password) {
			alert("비밀번호를 입력하세요");
			return;
		}		
		
		let url = $("#loginForm").attr("action");
		// console.log(url);
		
		// 파라미터들 보내기
		let params = $("#loginForm").serialize();
		// console.log(params);
		
		// request
		$.post(url, params)
		
		// response
		.done(function(data){
			if (data.code == 1) {
				// 로그인 성공 시 게시판 목록으로 이동
				location.href = "/post/post_list_view";
			} else {
				alert(data.errorMessage);
			}
		});
	});
});
</script>
</body>
</html>