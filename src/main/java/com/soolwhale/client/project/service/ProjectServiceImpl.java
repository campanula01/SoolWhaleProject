package com.soolwhale.client.project.service;

import java.sql.Timestamp;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.soolwhale.client.image.dao.ImageDao;
import com.soolwhale.client.image.vo.ImageVO;
import com.soolwhale.client.project.dao.ProjectDao;
import com.soolwhale.client.project.file.FileUploadUtil;
import com.soolwhale.client.project.vo.ProjectVO;

import lombok.Setter;

@Service
public class ProjectServiceImpl implements ProjectService {
	@Setter(onMethod_ = @Autowired)
	private ProjectDao projectDao;

	@Setter(onMethod_ = @Autowired)
	private ImageDao imageDao;

	@Override
	public List<ProjectVO> projectList() {
		List<ProjectVO> list = null;
		list = projectDao.projectList();
		return list;
	}
	
	@Override
	public List<ProjectVO> projectListAll() {
		List<ProjectVO> list = null;
		list = projectDao.projectListAll();
		return list;
	}

	@Override
	public List<ProjectVO> projectList(ProjectVO pvo) {
		List<ProjectVO> list = null;
		list = projectDao.projectList(pvo);
		return list;
	}

	@Override
	public int projectInfoInsert(ProjectVO pvo) throws Exception{
		int result = 0;
		String newProjectNum = projectDao.insertProjectNum();
		// 프로필이미지 받기!
		if(!pvo.getFirstImg().isEmpty()) {	//새롭게 업로드할 파일이 존재하면
			if(!pvo.getFirstImgFilename().isEmpty()) {		//기존 파일이 존재하면
				FileUploadUtil.fileDelete(pvo.getFirstImgFilename());
			}
			
			String FirstImgName = FileUploadUtil.fileUpload(pvo.getFirstImg(), "project");
			pvo.setFirstImgFilename(FirstImgName);
		}

		
		// 상세이미지 받기!
		List<String> fileName = FileUploadUtil.MultipleFileUpload(pvo.getImages().get(0).getFiles(), "multiple");
		ImageVO ivo = null;
		
		pvo.setProjectNum(newProjectNum);
		result = projectDao.projectInfoInsert(pvo);
		pvo.getImages().clear();

		for (int i = 0; i < fileName.size(); i++) {
			ivo = new ImageVO();
			ivo.setProjectNum(pvo.getProjectNum());
			ivo.setImgFilename(fileName.get(i));
			pvo.getImages().add(ivo);
		}
		imageDao.multipleImageInsert(pvo.getImages());
		

		return result;
	}

	@Override
	public int makerInfoUpdate(ProjectVO pvo,  List<ImageVO> imageList) throws Exception {
		int result = 0;
		// 프로필이미지 받기!
		if(!pvo.getFirstImg().isEmpty()) {
			if(!pvo.getFirstImgFilename().isEmpty()) {
				FileUploadUtil.fileDelete(pvo.getFirstImgFilename());
			}
			
			String FirstImgName = FileUploadUtil.fileUpload(pvo.getFirstImg(), "project");
			pvo.setFirstImgFilename(FirstImgName);
		}

		// 상세이미지 받기!
		if (pvo.getImages() != null && !pvo.getImages().isEmpty()) {
			if(!imageList.isEmpty()) {
				for(ImageVO image:imageList) {
					FileUploadUtil.DetailFileDelete(image.getImgFilename());
				}
			}
		    // 이미지가 비어있지 않은 경우에만 아래 코드를 실행
		    List<String> fileName = FileUploadUtil.MultipleFileUpload(pvo.getImages().get(0).getFiles(), "multiple");
		    ImageVO ivo = null;

		    pvo.getImages().clear();

		    for (int i = 0; i < fileName.size(); i++) {
		        ivo = new ImageVO();
		        ivo.setProjectNum(pvo.getProjectNum());
		        ivo.setImgFilename(fileName.get(i));
		        pvo.getImages().add(ivo);
		    }
		    imageDao.multipleImageInsert(pvo.getImages());
		}
		result = projectDao.makerInfoUpdate(pvo);
		return result;
	}

	@Override
	public int projectInfoUpdate(ProjectVO pvo) throws Exception {
		int result = 0;
		if(!pvo.getProfilImg().isEmpty()) {	//새롭게 업로드할 파일이 존재하면
			if(!pvo.getProfilImgFilename().isEmpty()) {		//기존 파일이 존재하면
				FileUploadUtil.fileDelete(pvo.getProfilImgFilename());
			}
			
			String profilImgFilename = FileUploadUtil.fileUpload(pvo.getProfilImg(), "project");
			pvo.setProfilImgFilename(profilImgFilename);
		}
		
		result = projectDao.projectInfoUpdate(pvo);
		return result;
	}

	@Override
	public int fundingPlanUpdate(ProjectVO pvo) {
		int result = 0;
		result = projectDao.fundingPlanUpdate(pvo);
		return result;
	}

	@Override
	public List<ProjectVO> recommendRewardList() {
		List<ProjectVO> list = null;
		list = projectDao.recommendRewardList();
		return list;
	}

	@Override
	public ProjectVO projectDetail(ProjectVO pvo) {
		ProjectVO vo = null;
		vo = projectDao.projectDetail(pvo);
		return vo;
	}
	
	@Override
	public ProjectVO projectDetail2(ProjectVO pvo) {
		ProjectVO vo = null;
		vo = projectDao.projectDetail2(pvo);
		return vo;
	}

	@Override
	public List<ProjectVO> searchProjects(String keyword) {

		return projectDao.searchProjects(keyword);
	}
	
	@Override
	public int successInsert(ProjectVO pvo) {
		int result = 0;
		result = projectDao.successInsert(pvo);
		return result;
	}
	
	@Override
	public int deleteProject(ProjectVO pvo) throws Exception {
		int result = 0;
		if(!pvo.getProfilImgFilename().isEmpty()) {
			FileUploadUtil.fileDelete(pvo.getProfilImgFilename());
		}
		if(!pvo.getFirstImgFilename().isEmpty()) {
			FileUploadUtil.fileDelete(pvo.getFirstImgFilename());
		}
		result = projectDao.deleteProject(pvo);
		return result;
	}

	@Override
	public List<ProjectVO> projectList(String userNum) {
		List<ProjectVO> list = null;
		list = projectDao.projectList(userNum);
		return list;
	}

	@Override
	public int projectAccept(ProjectVO pvo) {
		int result=0;
		result = projectDao.projectAccept(pvo);
		return result;
	}

	@Override
	public int projectRefuse(ProjectVO pvo) {
		int result=0;
		result = projectDao.projectRefuse(pvo);
		return result;
	}
	
	@Override
	public List<ProjectVO> projectSellingList(ProjectVO pvo) {
		List<ProjectVO> list = null;
		list = projectDao.projectSellingList(pvo);
		return list;
	}
	
	
	@Override
	public List<ProjectVO> liquorList(ProjectVO pvo) {
		
		List<ProjectVO> list = null;
		list = projectDao.liquorList(pvo);
		return list;
		
	}

	@Override
	public Timestamp paymentDate(String projectNum) {
		
		Timestamp timestamp =projectDao.paymentDate(projectNum);
		return timestamp;
	}

	@Override
	public Integer checkProjectStatus(String userNum) {
		
		return projectDao.checkProjectStatus(userNum);
	}

}
