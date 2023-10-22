package com.soolwhale.client.board.controller;



import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.soolwhale.client.board.service.BoardService;
import com.soolwhale.client.board.vo.BoardVO;
import com.soolwhale.common.vo.PageDTO;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/board")
@AllArgsConstructor
@Slf4j
public class BoardController {

    private final BoardService boardService;
/*
    @GetMapping("/list")
    public String boardList(Model model) {
    
        model.addAttribute("boardList", boardService.boardList());
        return "client/board/boardList";
    }
*/
    
    @GetMapping("/list")
    public String boardList(@ModelAttribute BoardVO bvo, Model model) {
       log.info("boardList 호출 성공");
       //전체 레코드 조회
       List<BoardVO> boardList = boardService.boardList(bvo);
       model.addAttribute("boardList",boardList);
       System.out.println(boardList);
       //전체 레코드 수 반환
       int total = boardService.boardListCnt(bvo);
       //페이징 처리
       model.addAttribute("pageMaker", new PageDTO(bvo, total));
       //new PageDTO(CommonVO 또는 CommonVO 하위 클래스의 인스턴스(BoardVO), 총레코드수)
       
       return "client/board/boardList";   //WEB-INF/views/client/board/boardList.jsp
    }
    
    @GetMapping("/write")
    public String boardWriteForm() {
    	
        return "client/board/boardWrite";
    }

    @PostMapping("/write")
    public String boardWrite(@ModelAttribute BoardVO bvo, HttpSession session) {
        // 세션에서 userNum 값을 가져옴
        String userNum = (String) session.getAttribute("userNum");

        // 가져온 userNum 값을 BoardVO에 설정
        bvo.setUserNum(userNum);

        boardService.boardWrite(bvo);
        return "redirect:/board/list";
    }

    @GetMapping("/detail")
    public String boardDetail(@RequestParam("bNum") int bNum, Model model,BoardVO bvo ) {
    	
    	log.info("Received bNum for board detail: " + bNum);
    	model.addAttribute("user", boardService.boardDetail(bNum, bvo));
        return "client/board/boardDetail";
    }

    @GetMapping("/update")
    public String updateForm(@RequestParam("bNum") int bNum, Model model,BoardVO bvo) {
        bvo = boardService.boardDetail(bNum, bvo);
        model.addAttribute("boardVO", bvo);
        return "client/board/boardUpdate";
    }

    @PostMapping("/update")
    public String boardUpdate(@ModelAttribute BoardVO bvo) {
        boardService.boardUpdate(bvo);
        return "redirect:/board/detail?bNum=" + bvo.getBNum();
    }

    @GetMapping("/delete")
    public String boardDelete(@ModelAttribute BoardVO bvo) {
        boardService.boardDelete(bvo);
        return "redirect:/board/list";
    }
    
    @ResponseBody
    @PostMapping(value="/replyCnt", produces = MediaType.TEXT_PLAIN_VALUE)
    public String replyCnt(@RequestParam("bNum") int bNum) {
       log.info("replyCnt 호출 성공");
       
       int result=0;
       result = boardService.replyCnt(bNum);
       
       //숫자를 문자로 만듦.
       return String.valueOf(result);
       
    }
}
