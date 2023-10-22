package com.soolwhale.client.user.vo;



import lombok.Data;

@Data
public class UserVO {
	private String userNum; // 사용자 번호
	private String identityVerification; // 본인인증(y/n)
	private String name; // 이름
	private String email; // 이메일
	private String id; // 아이디
	private String phoneNumber; // 연락처
	private String password; // 비밀번호
	private String profileImg; // 프로필 사진
	private String useYN; // 사용여부
	private String sex; // 성별
	private String point; // 포인트
	private String joinDate; // 가입일시
	private String uModifyDate; // 수정일시
	private String userNickname; // 사용자 별칭
	
    private String content;
    private String to;
    
    private String re_pwd;
}


