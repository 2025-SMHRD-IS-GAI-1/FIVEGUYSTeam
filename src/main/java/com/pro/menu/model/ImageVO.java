package com.pro.menu.model;

import java.io.InputStream;
import java.sql.Timestamp;

import com.pro.model.MemberVO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data  // getter, setter, 모든 필드를 초기화 시키는 생성자
@NoArgsConstructor // 기본 생성자
@AllArgsConstructor // 모든 필드를 초기화 시키는 생성자
public class ImageVO {
    
    private String imgId;
    private String id;
    private String imgName;
    private InputStream imgFile; // BLOB 처리를 위해 InputStream 사용
    private String resName;
    private String addr;
    private String lat;
    private String lon;
    private String ratings;
    private String imgCheck;
    private Timestamp uploadDt;
    
}