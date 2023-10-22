package com.soolwhale.client.reply.vo;





import java.sql.Timestamp;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.soolwhale.client.board.vo.BoardVO;
import com.soolwhale.client.user.vo.UserVO;
import com.soolwhale.common.vo.CommonVO;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class ReplyVO extends CommonVO {
	
	@JsonProperty("rNum")
	private int rNum=0;        // 댓글번호
	
	@JsonProperty("bNum")	
	private int bNum=0;        // 게시판 글번호
	
	@JsonProperty("userNum")
	private String userNum=""; // 사용자 고유 번호
	
	@JsonProperty("rContent")
	private String rContent; // 댓글 내용
	
	@JsonProperty("rDate")
	private Timestamp rDate;     // 댓글 작성일
	
	
	UserVO user;
	BoardVO board;
	
}
