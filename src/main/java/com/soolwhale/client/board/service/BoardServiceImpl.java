package com.soolwhale.client.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.soolwhale.client.board.dao.BoardDao;
import com.soolwhale.client.board.vo.BoardVO;
import com.soolwhale.client.reply.dao.ReplyDao;

import lombok.Setter;

@Service
public class BoardServiceImpl implements BoardService {

	@Setter(onMethod_ = @Autowired)
	private BoardDao boardDao;

	@Setter(onMethod_ = @Autowired)
	private ReplyDao replyDao;

	// 게시글 목록 조회
	@Override
	public List<BoardVO> boardList(BoardVO bvo) {
		List<BoardVO> list = null;
		list = boardDao.boardList(bvo);

		return list;
	}

	// 게시글 상세 조회
	@Override
	public BoardVO boardDetail(int bNum, BoardVO bvo) {
	boardDao.readCntUpdate(bvo); // 조회수 증가 메서드 호출
		return boardDao.boardDetail(bNum);
	}
	
	public int readCntUpdate(BoardVO bvo) {
		int result = 0;
		result = boardDao.readCntUpdate(bvo);

		return result;

	}
	
	// 게시글 작성
	@Override
	@Transactional
	public boolean boardWrite(BoardVO bvo) {
		int result = boardDao.boardWrite(bvo);
		return result > 0;
	}

	// 게시글 수정
	@Override
	@Transactional
	public boolean boardUpdate(BoardVO bvo) {
		int result = boardDao.boardUpdate(bvo);
		return result > 0;
	}

	 @Override 
	 public boolean boardDelete(BoardVO bvo) {
			int result = boardDao.boardDelete(bvo);
			return result > 0;
		}
	 
	 @Override
		public int replyCnt(int bNum) {
			int result = 0;
			result = boardDao.replyCnt(bNum);
			return result;
		}
	 
	 
		@Override
		public int boardListCnt(BoardVO bvo) {

			return boardDao.boardListCnt(bvo);

		}
}

