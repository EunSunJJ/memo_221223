<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="d-flex justify-content-center">
	<div class="w-50">
		<h1>글쓰기</h1>
		<!-- 권한 검사 필요한데 생략할거야 (일괄로 처리) -->
		<input type="text" id="subject" class="form-control" placeholder="제목을 입력하세요">
		<textarea row="10" class="form-control" id="content" placeholder="글 내용을 입력하세요"></textarea>
		
		<div class="d-flex justify-content-end my-4">
			<input type="file" id="file" accept=".jpg, .jpeg, .png, .gif">
		</div>
		
		<div class="d-flex justify-content-between">
			<!-- <a></a>앵커태그 걸어주면 된다 -->
			<button type="button" id="postListBtn" class="btn btn-dark">목록</button>
			
			<div>
				<button type="button" id="clearBtn" class="btn btn-secondary">모두 지우기</button>
				<button type="button" id="saveBtn" class="btn btn-primary">저장</button>
			</div>
		</div>
	</div>
</div>

<script>
$(document).ready(function(){
	// 목록 버튼 클릭 -> 글 목록으로 이동!
	$("#postListBtn").on("click", function(){
		// alert("확인");
		location.href="/post/post_list_view";
	});	
	
	// 모두 지우기 버튼 클릭 -> 전체 내용 삭제
	$("#clearBtn").on("click", function(){
		// alert("확인");
		$("#subject").val("");
		$("#content").val("");
	});
	
	// 글 저장 버튼 클릭
	$("#saveBtn").on("click", function(){
		// alert("확인");
		let subject = $("#subject").val().trim();	
		let content = $("#content").val();	
		let file = $("#file").val();
		// 이미지 경로 = C:\fakepath\chipmunk-3959206__340.jpg
		
		// validation -> 제목만 필수이기 떄문에 
		if (!subject) {
			alert("제목을 입력하세요");
			return;
		}
		// alert(file); -> 창에 이미지 경로가 뜬다
		
		// 파일이 업로드 된 경우에만 확장제 체크 (validation)
		if (file != "") {
			// 확장자만 뽑아서 소문자로 변경한다.
			let ext = file.split(".").pop().toLowerCase();
			// pop() : 배열에 마지막 칸에 있는 값을 돌려준다
			// 대문자로 되어있는 확장자도 있으니 일괄적으로 전부 소문자로 바꿔준다 = toLowerCase()
			
			// alert(ext); -> jpg뜨는지 확인
			
			if ($.inArray(ext, ['jpg', 'jpeg', 'png', 'gif']) == -1) {
				// (확인할 글자, 내가 허용할 값이 들어있는 배열) -> ext가 저 배열안에 있는지 물어보는거야
				alert("이미지 파일만 업로드 할 수 있습니다.")
				$("#file").val("");  // 파일을 비운다
				return;
			}
			
		}
		
		// 서버 AJAX
		// 이미지를 업로드 할 때는 form태그가 반드시 있어야 한다.
		// append 함수는 form태그의 name 속성과 같다
		let formData = new FormData();
		formData.append("subject", subject);   // 비어있는 form태그에 name파라미터 추가 
		formData.append("content", content);   
		formData.append("file", $("#file")[0].files[0]); 
		// $("#file")[0] = 첫번째 input파일에 있는 , files[0] = 그 파일들 중에 첫번째 것 하나
		// ↑ 데이터만 담은 것
		
		$.ajax({
			// request
			type: "post"  // 커다란 내용을 보낼 때 = 무조건 post
			, url: "/post/create"
			, data: formData
			
			// (이미지)파일 업로드를 위한 필수 설정 3가지
			, enctype: "multipart/form-data"
			, processData: false
			, contentType: false
			
			// response
			, success: function(data) {
				if (data.code == 1) {
					// 성공
					alert("메모가 저장되었습니다")
					location.href = "/post/post_list_view";
				} else {
					// 실패
					alert(data.errorMessage);
				}
			}
			, error: function(request, status, error) {
				alert("글을 저장하는데 실패했습니다");
			}
		});
			
	});
	
});
</script>