package com.soolwhale.client.project.dao;

import java.sql.Timestamp;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.soolwhale.client.project.vo.ProjectVO;

@Mapper
public interface ProjectDao {

	public List<ProjectVO> projectList();
	public List<ProjectVO> projectListAll();
	public List<ProjectVO> projectList(ProjectVO pvo);
	public List<ProjectVO> projectList(String userNum);
	public int projectInfoInsert(ProjectVO pvo);
	public int makerInfoUpdate(ProjectVO pvo);
	public int projectInfoUpdate(ProjectVO pvo);
	public int fundingPlanUpdate(ProjectVO pvo);
	
	
	public int successInsert(ProjectVO pvo);
	public int deleteProject(ProjectVO pvo);
	public String insertProjectNum();
	
	public Timestamp paymentDate(String projectNum);
	public ProjectVO projectDetail(ProjectVO pvo);
	public ProjectVO projectDetail2(ProjectVO pvo);
	
	public List<ProjectVO> recommendRewardList();
	public List<ProjectVO> searchProjects(String keyword);
	
	public int projectAccept(ProjectVO pvo);
	public int projectRefuse(ProjectVO pvo);
	
	public List<ProjectVO> projectSellingList(ProjectVO pvo);
	public List<ProjectVO> liquorList(ProjectVO pvo);
	
	public void userProjectDelete(String userNum);
	
 	public Integer checkProjectStatus(String userNum);
}
