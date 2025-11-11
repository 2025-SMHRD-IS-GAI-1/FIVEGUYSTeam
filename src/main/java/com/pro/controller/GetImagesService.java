package com.pro.controller;

import java.io.InputStream;
import java.util.Base64; // [ ★★★ 1. Base64 임포트 ★★★ ]
import java.util.List;

import com.pro.frontcontroller.Command;

import org.json.JSONArray;
import org.json.JSONObject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.pro.menu.model.*;
import com.pro.model.MemberVO;


public class GetImagesService implements Command {
    
	@Override
    public String excute(HttpServletRequest request, HttpServletResponse response) {
		String moveurl = "fetch:/"+"{\"result\" : \"false\"}";
		JSONObject jsonResponse = new JSONObject(); // 클라이언트에 보낼 JSON
        
        try {
        	String userId = "anonymous";
        	if(request.getParameter("userId")!=null) {
        		userId = request.getParameter("userId");
        	}
            MenuDataDAO dao = new MenuDataDAO();
        	
        	
        	List<ImageVO> list = dao.getImages(userId);
            
            // [ ★★★ 2. 수동으로 JSONArray 생성 (핵심 수정) ★★★ ]
            JSONArray imagesJsonArray = new JSONArray();
            
            for (ImageVO vo : list) {
                JSONObject imageJson = new JSONObject();
                
                // 1. DTO의 모든 '일반' 필드를 JSON 객체에 복사
                imageJson.put("imgId", vo.getImgId());
                imageJson.put("id", vo.getId());
                imageJson.put("imgName", vo.getImgName());
                imageJson.put("resName", vo.getResName());
                imageJson.put("addr", vo.getAddr());
                imageJson.put("lat", vo.getLat());
                imageJson.put("lon", vo.getLon());
                imageJson.put("ratings", vo.getRatings());
                imageJson.put("imgCheck", vo.getImgCheck());
                imageJson.put("uploadDt", vo.getUploadDt().toString()); // Timestamp를 문자열로

                // 2. InputStream(BLOB) -> byte[] -> Base64 String 변환
//                InputStream imgFileStream = vo.getImgFile();
//                if (imgFileStream != null) {
//                    try {
//                        byte[] bytes = imgFileStream.readAllBytes(); // InputStream을 byte[]로
//                        String base64Image = Base64.getEncoder().encodeToString(bytes); // byte[]를 Base64로
//                        
//                        // JSON에는 Base64 문자열 저장 (용량이 클 수 있음)
//                        imageJson.put("imgFileBase64", base64Image); 
//                    } finally {
//                        imgFileStream.close(); // 스트림 닫기
//                    }
//                } else {
//                    imageJson.put("imgFileBase64", JSONObject.NULL); // BLOB이 NULL인 경우
//                }
                
                imagesJsonArray.put(imageJson); // 배열에 추가
            }
            
            jsonResponse.put("status", "success");
            jsonResponse.put("message", "데이터를 성공적으로 검색했습니다.");
            
            // [ ★★★ 3. List<ImageVO> 대신 수동 생성한 JSONArray를 전송 ★★★ ]
            jsonResponse.put("myImages", imagesJsonArray); 
            
            moveurl = "fetch:/"+jsonResponse.toString();

        } catch (Exception e) {
            e.printStackTrace();
            
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            jsonResponse.put("status", "error");
            jsonResponse.put("message", "DB 검색 중 오류 발생: " + e.getMessage());
            moveurl = "fetch:/"+jsonResponse.toString();
            
        }
        return moveurl;
    }
}