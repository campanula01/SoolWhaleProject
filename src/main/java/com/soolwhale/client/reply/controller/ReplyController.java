package com.soolwhale.client.reply.controller;


import java.io.BufferedReader;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;

import com.soolwhale.client.reply.vo.ReplyVO;
import com.soolwhale.client.reply.vo.service.ReplyService;
import com.soolwhale.common.vo.PageDTO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

//데이터만 줄거니까 RestController
@RestController
@RequestMapping(value="/replies")
@Slf4j
public class ReplyController {
   
   @Setter(onMethod_=@Autowired)
   private ReplyService replyService;


   @GetMapping("/all/{bNum}")
   public List<ReplyVO> replyList(@PathVariable("bNum") int bNum, ReplyVO rvo, Model model){
	   log.info("Received bNum for replies: " + bNum);
	   rvo.setBNum(bNum);
	   
      return replyService.replyList(rvo);
   }

   @PostMapping("/replyInsert")
   public String replyInsert(HttpServletRequest request) {
	   
       StringBuilder sb = new StringBuilder();
       String payload = null;
       try (BufferedReader reader = request.getReader()) {
           String line;
           while ((line = reader.readLine()) != null) {
               sb.append(line);
           }
           payload = sb.toString();
       } catch (Exception e) {
           e.printStackTrace();
           return "FAILURE"; // 요청 본문을 읽는 중 오류 발생
       }

       ObjectMapper mapper = new ObjectMapper();
       ReplyVO rvo = null;
       try {
           rvo = mapper.readValue(payload, ReplyVO.class);
           log.info("Received userNum: " + rvo.getUserNum());
       } catch (Exception e) {
           e.printStackTrace();
           return "FAILURE"; // JSON 파싱 중 오류 발생
       }

       int result = replyService.replyInsert(rvo);

       return (result == 1) ? "SUCCESS" : "FAILURE";
   }
   

   
   /* 댓글 삭제 구현하기
    * @return 
    * 참고 : RESET 방식에서 삭제 작업은 DELETE 방식을 이용해서 처리 
    * 현재 요청 URL : 
    * */
   
   @DeleteMapping(value = "/{rNum}", produces = MediaType.TEXT_PLAIN_VALUE)
   public String replyDelete(@PathVariable("rNum") int rNum) {
	   log.info("replyDelete 호풀 성공");
	   log.info("rNum = " + rNum);;
	   
	   int result = replyService.replyDelete(rNum);
	   return (result==1) ? "SUCCESS":"FAILURE";
	   
	   
   }
   
   
   
}