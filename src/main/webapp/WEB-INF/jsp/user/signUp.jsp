<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body>
	<div id="wrap">
		<div class="sign-up-logo">회원가입</div>
		<div class="sign-up-box d-flex align-items-center justify-content-center">
			<form id="signUpForm" method="post" action="/user/sign_up">
				
				<div class="form-group d-flex align-items-center">
					<span class="sign-up-subject">아이디</span>
					<input type="text" name="loginId" class="form-control col-7" placeholder="아이디를 입력해주세요">
					<input type="button" name="loginIdCheckBtn" value="중복확인" class="btn btn-success">
				</div>
			
				<%-- 아이디 체크 결과 --%>
				<div>
					<div id="idCheckLength" class="small text-danger d-none">ID를 4자 이상 입력해주세요.</div>
					<div id="idCheckDuplicated" class="small text-danger d-none">이미 사용중인 ID입니다.</div>
					<div id="idCheckOk" class="small text-success d-none">사용 가능한 ID 입니다.</div>
				</div>			
						
							
				<div class="form-group d-flex align-items-center">
					<span class="sign-up-subject">비밀번호</span>
					<input type="text" name="password" class="form-control col-8" placeholder="비밀번호를 입력해주세요">
				</div>
				
								
				<div class="form-group d-flex align-items-center">
					<span class="sign-up-subject">비밀번호 확인</span>
					<input type="text" name="password" class="form-control col-8" placeholder="비밀번호를 입력해주세요">
				</div>
		
								
				<div class="form-group d-flex align-items-center">
					<span class="sign-up-subject">이름</span>
					<input type="text" name="name" class="form-control col-7" placeholder="이름을 입력해주세요">
				</div>
								
								
				<div class="form-group d-flex align-items-center">
					<span class="sign-up-subject">이메일 주소</span>
					<input type="text" name="email" class="form-control col-9" placeholder="이메일을 입력해주세요">
				</div>
				
				<br>
				<div class="d-flex align-items-center justify-content-center">
					<button type="submit" id="signUpBtn" class="btn btn-primary">가입하기</button>
				</div>
				
			</form>
		</div>
	</div>
	
<script>
$(document).ready(function() {
		// 중복확인 버튼 클릭
	$('#loginIdCheckBtn').on('click', function() {
		alert("확인");
	});
});
</script>	
</body>
</html>