package com.soolwhale.client.reply.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.soolwhale.client.board.vo.BoardVO;
import com.soolwhale.client.reply.vo.ReplyVO;

@Mapper
public interface ReplyDao {


    // 댓글 목록 조회
    List<ReplyVO> replyList(ReplyVO rvo);

    // 댓글 입력
    int replyInsert(ReplyVO rvo);

    // 댓글의 사용자 확인
    int checkUserByReply(ReplyVO rvo); // ReplyVO 안의 userNum (또는 userId)를 이용하여 일치하는지 확인

  
    // 댓글 삭제
    int replyDelete(int rNum);


	ReplyVO getReplyByRNum(int rNum);
	
	 int replyCnt(ReplyVO rNum);	 //추가
    
}
