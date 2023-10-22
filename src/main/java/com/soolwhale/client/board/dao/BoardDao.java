package com.soolwhale.client.board.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.data.repository.query.Param;

import com.soolwhale.client.board.vo.BoardVO;

@Mapper
public interface BoardDao {
	 // 게시글 목록 조회
	public List<BoardVO> boardList(BoardVO bvo);
	
	public int boardListCnt(BoardVO bvo);	 //추가
	
    // 게시글 상세 조회
    BoardVO boardDetail(@Param("bNum") int bNum);
    
	public int readCntUpdate(BoardVO bvo);
    
    // 게시글 작성
    int boardWrite(BoardVO bvo);

    // 게시글 수정
    int boardUpdate(BoardVO bvo);

	int boardDelete(BoardVO bvo);
	
	public int replyCnt(int bNum);
	
}
