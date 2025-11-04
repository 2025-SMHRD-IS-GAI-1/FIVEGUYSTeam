package com.pro.model;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data  // getter, setter, 모든 필드를 초기화 시키는 생성자
@NoArgsConstructor // 기본 생성자
@AllArgsConstructor // 모든 필드를 초기화 시키는 생성자
public class MemberVO {
	
	private String id;
	private String pw;
	private String name;
	private String email;
	
	
}
