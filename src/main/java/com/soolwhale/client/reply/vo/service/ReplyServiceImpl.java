package com.soolwhale.client.reply.vo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.soolwhale.client.board.vo.BoardVO;
import com.soolwhale.client.reply.dao.ReplyDao;
import com.soolwhale.client.reply.vo.ReplyVO;
@Service
public class ReplyServiceImpl implements ReplyService {

    @Autowired
    private ReplyDao replyDao;

    @Override
    public List<ReplyVO> replyList(ReplyVO rvo) {
        return replyDao.replyList(rvo);
    }

    @Override
    @Transactional
    public int replyInsert(ReplyVO rvo) {
        try {
            return replyDao.replyInsert(rvo);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error inserting reply.", e);
        }
    }

    @Override
    public ReplyVO getReplyByRNum(int rNum) {
        return replyDao.getReplyByRNum(rNum);
    }

    @Override
    @Transactional
    public int replyDelete(int rNum) {
        try {
            return replyDao.replyDelete(rNum);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error deleting reply.", e);
        }
    }
	@Override
	public int replyCnt(ReplyVO rvo) {

		return replyDao.replyCnt(rvo);

	}

	
    
}
