package com.smhrd.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data // getter, setter, 모든 필드를 초기화 시키는 생성자
@NoArgsConstructor // 기본 생성자
@AllArgsConstructor // 모든 필드를 초기화 시키는 생성자
public class MemberVO {
	// DB 테이블의 하나의 행을 표현할 수 있는 형태를 만들어보자!
	// 필드 == 테이블의 column : 필드영역에는 테이블의 이름이 온다.
	private String email;
	private String pw;
	private String tel;
	private String address;
	
	
}
