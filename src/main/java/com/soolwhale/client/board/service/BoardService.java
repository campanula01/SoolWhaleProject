package com.soolwhale.client.board.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.soolwhale.client.board.vo.BoardVO;



@Service
public interface BoardService {
	
    // 게시글 목록 조회
	public List<BoardVO> boardList(BoardVO bvo); /* 검색 포함 리스트 */
	
    
    public int boardListCnt(BoardVO bvo); /* board 테이블의 전체 레코드 수 */
    
    // 게시글 상세 조회
    BoardVO boardDetail(int bNum, BoardVO bvo);

    // 게시글 작성
    boolean boardWrite(BoardVO bvo);

    // 게시글 수정
    boolean boardUpdate(BoardVO bvo);

    // 게시글 삭제
    boolean boardDelete(BoardVO bvo);
    
	public int replyCnt(int b_num);

}

