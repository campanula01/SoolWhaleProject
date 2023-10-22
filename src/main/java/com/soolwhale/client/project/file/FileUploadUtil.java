package com.soolwhale.client.project.file;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.web.multipart.MultipartFile;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class FileUploadUtil {
	
	/**************************
	* 파일 업로드할 폴더 생성
	**************************/
	public static void makeDir(String docRoot) {
		File fileDir = new File(docRoot);
		if(fileDir.exists()) {
			return;
		}
		fileDir.mkdirs();
		//mkdir을 사용하면 폴더만 만들고 s를 넣으면 그밑에 하위를 계속 만들수있음.
	}
	//파일 업로드
	public static String fileUpload(MultipartFile firstImg, String firstImgFilename) throws IOException {
		log.info("fileUpload 호출 성공");
		
		String real_name= null;
		//MultipartFile 클래스의 getFile(); 메서드로 클라이언트가 업로드한 파일
		String org_name = firstImg.getOriginalFilename();
		log.info("업로드 할 파일명 : "+org_name);
		
		//파일명 변경(중복되지않게)
		if(org_name != null && (!org_name.equals(""))) {
			real_name = firstImgFilename + "_" + System.currentTimeMillis() + "_" + org_name; //저장할 파일 이름
			
			String docRoot = "C://springdeveloper/springbootcoding/SoolWhale/src/main/resources/static/img/project/uploadStorage//"+firstImgFilename;
			makeDir(docRoot);
			
			File fileAdd = new File(docRoot+"/"+real_name);
			log.info("업로드할 파일(fileAdd)"+fileAdd);
			
			firstImg.transferTo(fileAdd); //이 메서드에 의해 저장 겨올에 실질적으로 File이 생성됨.
		}
		return real_name;
	}
	
	//파일 삭제
	public static void fileDelete(String firstImgFilename) throws Exception{
		log.info("fileDelete 호출 성공");
		boolean result = false;
		String dirName = firstImgFilename.substring(0, firstImgFilename.indexOf("_"));
		String docRoot = "C://springdeveloper/springbootcoding/SoolWhale/src/main/resources/static/img/project/uploadStorage/"+dirName;
		File fileDelete = new File(docRoot+"/"+firstImgFilename);
		
		if(fileDelete.exists() && fileDelete.isFile()) {
			result = fileDelete.delete();
		}
		log.info("파일 삭제여부(true/false) : " + result);
	}
	
	//다중파일 업로드 메서드
	public static List<String> MultipleFileUpload(List<MultipartFile> imgFile, String imgFilename)throws IOException{
		log.info("MultipleFileUpload 호출 성공 ");
		
		List<String> real_name = new ArrayList<String>();
		String name = "";
		// 파일명 변경(중복되지 않게) 
		if(!imgFile.isEmpty()){
			String docRoot = "C://springdeveloper/springbootcoding/SoolWhale/src/main/resources/static/img/project/detailImageStorage/"+imgFilename;
			makeDir(docRoot);
			File fileAdd = null;
			for(MultipartFile MultiFile : imgFile) {
				name = imgFilename +"_"+ UUID.randomUUID().toString().replaceAll("-", "") +"_"+ MultiFile.getOriginalFilename(); // 저장할 파일 이름
				
				fileAdd = new File(docRoot+"/"+name);	//파일 생성후 
				log.info("업로드할 파일(fileAdd) : " + fileAdd);
			
				MultiFile.transferTo(fileAdd); // 파일 저장
				real_name.add(name);
			}
		}
		return real_name;
	}
	
	//상세이미지 파일 삭제
	public static void DetailFileDelete(String firstImgFilename) throws Exception{
		log.info("fileDelete 호출 성공");
		boolean result = false;
		String dirName = firstImgFilename.substring(0, firstImgFilename.indexOf("_"));
		String docRoot = "C://springdeveloper/springbootcoding/SoolWhale/src/main/resources/static/img/project/detailImageStorage/"+dirName;
		File fileDelete = new File(docRoot+"/"+firstImgFilename);
		
		if(fileDelete.exists() && fileDelete.isFile()) {
			result = fileDelete.delete();
		}
		log.info("파일 삭제여부(true/false) : " + result);
	}
}
