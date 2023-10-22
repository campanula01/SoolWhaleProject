package com.soolwhale.client.project.service;

import java.sql.Timestamp;
import java.util.List;

import com.soolwhale.client.image.vo.ImageVO;
import com.soolwhale.client.project.vo.ProjectVO;

public interface ProjectService {
	
	public List<ProjectVO> projectList();
	public List<ProjectVO> projectListAll();
	public List<ProjectVO> projectList(ProjectVO pvo);
	public List<ProjectVO> projectList(String userNum);
	public int projectInfoInsert(ProjectVO pvo) throws Exception;
	public int makerInfoUpdate(ProjectVO pvo, List<ImageVO> imageList) throws Exception;
	public int projectInfoUpdate(ProjectVO pvo) throws Exception;
	public int fundingPlanUpdate(ProjectVO pvo);

	public int successInsert(ProjectVO pvo);
	public int deleteProject(ProjectVO pvo) throws Exception;
	
	public Timestamp paymentDate(String projectNum);
	public ProjectVO projectDetail(ProjectVO pvo);
	public ProjectVO projectDetail2(ProjectVO pvo);

	
	
	public List<ProjectVO> recommendRewardList();
	List<ProjectVO> searchProjects(String keyword);
	
	public int projectAccept(ProjectVO pvo);
	public int projectRefuse(ProjectVO pvo);
	
	public List<ProjectVO> projectSellingList(ProjectVO pvo);
	public List<ProjectVO> liquorList(ProjectVO pvo);
}
