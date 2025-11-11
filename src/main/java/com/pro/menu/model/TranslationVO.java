package com.pro.menu.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data  // getter, setter, 모든 필드를 초기화 시키는 생성자
@NoArgsConstructor // 기본 생성자
@AllArgsConstructor // 모든 필드를 초기화 시키는 생성자
public class TranslationVO {

    private String transId;
    private String imgId;
    private int x1;
    private int y1;
    private int x2;
    private int y2;
    private String menuName;
    private String transText;
    private String menuDesc;
    private String color_bg;
    private String color_txt;
    
    
    
}