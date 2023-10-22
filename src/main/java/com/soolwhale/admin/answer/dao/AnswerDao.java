package com.soolwhale.admin.answer.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.soolwhale.admin.answer.vo.AnswerVO;

@Mapper
public interface AnswerDao {
	public List<AnswerVO> answerList();
	
}
