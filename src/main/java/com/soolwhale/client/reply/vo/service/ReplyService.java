package com.soolwhale.client.reply.vo.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.soolwhale.client.board.vo.BoardVO;
import com.soolwhale.client.reply.vo.ReplyVO;

@Service
public interface ReplyService {
	
	
	
	List<ReplyVO> replyList(ReplyVO rvo);

	int replyCnt(ReplyVO rvo); 
	 
	int replyInsert(ReplyVO rvo);

	int replyDelete(int rNum);

	ReplyVO getReplyByRNum(int rNum);



}
