package com.memo.common;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

@Component            // 넓은 범위의 spring bean -> Autowired사용가능
public class FileManagerService {
	// 실제 업로드 된 이미지가 저장될 경로(서버 = 우리 컴퓨터)
	public static final String FILE_UPLOAD_PATH= "C:\\EunSun\\6_spring_project\\memo\\spring-tool-suite-4-4.18.0.RELEASE-e4.27.0-win32.win32.x86_64.self-extracting\\workspace\\images/";

	// 업로드 하는 메소드를 만들어 보자
	// input : MultipartFile (이미지 파일) , loginId = 이미지가 겹치지 않도록 하기 위해
	// output : imagePath (String)
	// 여러 사용자가 있다는 걸 생각해야한다 -> 사용자마다 이미지를 업로드하면 폴더를 새로 만들어 잔다
	public String saveFile(String loginId, MultipartFile file) {
		
		// 파일 디렉토리 = 폴더  
		// ex. aaaa_167894564/sun.png (사용자_생성시간/저장파일)
		String directoryName = loginId + "_" + System.currentTimeMillis() + "/";
		// "aaaa_1678694564/" 현재 만든상태
		
		String filePath =  FILE_UPLOAD_PATH + directoryName;
		// C:\\EunSun\\6_spring_project\\memo\\spring-tool-suite-4-4.18.0.RELEASE-e4.27.0-win32.win32.x86_64.self-extracting\\workspace\\images/
		
		File directory = new File(filePath);
		if (directory.mkdir() == false) {
			return null;  // 폴더 만드는데 실패 시 이미지경로 null
		}
		
		// 파일 업로드 : byte 댠위로 업로드
		try {
			byte[] bytes = file.getBytes();
			Path path = Paths.get(filePath + file.getOriginalFilename());   
			// 디렉토리명 + 파일명(파일에 대한 확장자 까지 써줘야 해) = getOriginalFilename은 사용자가 올린 파일명
			// 한글로는 업로드하면 작동 안돼! -> 개인프로젝트 할 때는 이름을 만들어서 처리하기 (getOriginalFilename 이거 사용하지말고)
			Files.write(path, bytes);  // 파일업로드
			
		} catch (IOException e) {
			e.printStackTrace();
			return null;  // 반드시 return null -> BO한테 알려준다
		}
		
		// 파일 업로드가 성공했으면 이미지 url path를 리턴한다
		//  http://localhost/images/aaaa_1678694564/sun.png
		return "/images/" + directoryName + file.getOriginalFilename();  // OriginalFileName은 사용자가 올린 파일명
	}
}
