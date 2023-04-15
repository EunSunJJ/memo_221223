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
			<form id="signUpForm" name="signUpForm"  method="post" action="/user/sign_up">
				
				<div class="form-group d-flex align-items-center">
					<span class="sign-up-subject">아이디</span>
					<input type="text" id="loginId" name="loginId" class="form-control col-7" placeholder="아이디를 입력해주세요">
					<input type="button" id="loginIdCheckBtn" name="loginIdCheckBtn" value="중복확인" class="btn btn-success">
				</div>
			
				<%-- 아이디 체크 결과 (보이지않게) --%>
				<div>
					<div id="idCheckLength" class="small text-danger d-none">ID를 4자 이상 입력해주세요.</div>
					<div id="idCheckDuplicated" class="small text-danger d-none">이미 사용중인 ID입니다.</div>
					<div id="idCheckOk" class="small text-success d-none">사용 가능한 ID 입니다.</div>
				</div>			
						
							
				<div class="form-group d-flex align-items-center">
					<span class="sign-up-subject">비밀번호</span>
					<input type="text" id="password" name="password" class="form-control col-8" placeholder="비밀번호를 입력해주세요">
				</div>
				
								
				<div class="form-group d-flex align-items-center">
					<span class="sign-up-subject">비밀번호 확인</span>
					<input type="text" id="passwordCheck" name="passwordCheck" class="form-control col-8" placeholder="비밀번호를 입력해주세요">
				</div>
		
								
				<div class="form-group d-flex align-items-center">
					<span class="sign-up-subject">이름</span>
					<input type="text" id="name" name="name" class="form-control col-7" placeholder="이름을 입력해주세요">
				</div>
								
								
				<div class="form-group d-flex align-items-center">
					<span class="sign-up-subject">이메일 주소</span>
					<input type="text" id="email" name="email" class="form-control col-9" placeholder="이메일을 입력해주세요">
				</div>
				
				<br>
				<div class="d-flex align-items-center justify-content-center">
					<button type="submit" id="signUpBtn" class="btn btn-primary">가입하기</button>
				</div>
				
			</form>
		</div>
	</div>
	
<script>
$(document).ready(function(){
	$("#loginIdCheckBtn").on("click", function(){
		// alert("확인")
		
		// 경고 문구 초기화 -> idCheckLength를 초기화 해주는 거야
		$("idCheckLength").addClass("d-none");
		$("idCheckDuplicated").addClass("d-none");
		$("idCheckOk").addClass("d-none");
		
		let loginId = $("#loginId").val().trim();
		
		// 4자 미만이면 경고 문구 노출
		if(loginId.length < 4) {
			$("#idCheckLength").removeClass("d-none");
			return;
		}
		
		
		// AJAX 통신 - 중복확인
		$.ajax({
			// request
			type:"get" 
			, url:"/user/is_duplicated_id"
			, data:{"loginId":loginId}
		
			// response
			, success:function(data) {  // call back 함수
				if (data.result) {
					// 중복이다
					$("#idCheckDuplicated").removeClass("d-none");
				} else {
					// 사용 가능하다
					$("#idCheckOk").removeClass("d-none");
				}
			}
			
			
		});
	});
	
	// 회원가입
	$("#signUpForm").on("submit", function(e){
		e.preventDefault();  // submit기능 중단 -> 화면이동x
		// alert("submit");
	
	// validation
	let loginId = $("#loginId").val().trim();
	let password = $("#password").val();
	let passwordCheck = $("#passwordCheck").val();
	let name = $("#name").val().trim();
	let email = $("#email").val().trim();
	
	// 값이 있는지 없는지 순차적으로 체그 -> if문으로 
	if (!loginId) {
		alert("아이디를 입력하세요");
		return false;
	}
	
	if (!password || !passwordCheck) {
		alert("비밀번호를 입력하세요");
		return false;
	}
	
	// 오타체크를 위해 서버키고 alert창 뜨는지 확인하기 (중간중간 확인)
	
	// password != passwordCheck
	if (password != passwordCheck) {
		alert("비밀번호가 일치하지 않습니다");
		return false;
	}
	
	if (!name) {
		alert("이름을 입력하세요")
		return false;
	}
	
	if (!email) {
		alert("이메일을 입력하세요")
		return false;
	}
	
	// validation끝 -> 중복확인
	// 사용가능한 ID입니다 라는 문구가 나와야 가입가능
	
	// 아이디 중복확인 완료 됬는지 확인 -> passwordCheck d-none이 있으면 alert
	if ($("#passwordCheck").hasClass("d-none")) {
		alert("아이디 중복확인을 다시 해주세요");
		return false;
		}
	
	// 보낼준비 끝 -> AJAX
	let url = $(this).attr("action");
	console.log(url);
	
	let params = $(this).serialize();  // form태그에 있는 name 속성값들로 파라미터 구성
	// 내가 파라미터 다 만들기 귀찮으면 이런식으로도 할 수 있다
	console.log(params);
	
	$.post(url, params)  // request정보
	.done(function(data){  // success에 대한 callback함수 
		
		// response
		if (data.code == 1) {  // 성공
			alert("가입을 환영합니다. 로그인을 해주세요")
		
			// 화면이동 시켜주기
			location.href = "/user/sign_in_view";
		} else {  // 실패
			alert(data.errorMessage);
		}
		
	}); 
	
	});
});
</script>	
</body>
</html>