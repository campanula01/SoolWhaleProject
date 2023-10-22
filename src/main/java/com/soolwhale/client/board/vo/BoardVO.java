package com.soolwhale.client.board.vo;



import java.sql.Timestamp;


import com.soolwhale.client.user.vo.UserVO;
import com.soolwhale.common.vo.CommonVO;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class BoardVO extends CommonVO {
    private int bNum;         // 글번호
    private String userNum; 
    private String bTitle ;   // 제목
    private String bContent; // 내용
    private Timestamp bDate;         // 작성일
    private int readcnt = 0;      // 조회수
    private int rcnt=0;


    
    UserVO user;
}
