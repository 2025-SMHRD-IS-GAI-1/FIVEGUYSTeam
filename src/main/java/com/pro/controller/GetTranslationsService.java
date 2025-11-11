package com.pro.controller;


import java.util.List;

import com.pro.frontcontroller.Command;

import org.json.JSONArray;
import org.json.JSONObject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.pro.menu.model.*;


public class GetTranslationsService implements Command {
    
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
        	
            String imgId = "";
            if(request.getParameter("imgId")!=null) {
            	imgId = request.getParameter("imgId");
            }
            
            
            List<TranslationVO> list = dao.getTranslations(imgId);
            
            // [ ★★★ 2. 수동으로 JSONArray 생성 (핵심 수정) ★★★ ]
            JSONArray imagesJsonArray = new JSONArray();
            
            for (TranslationVO vo : list) {
                JSONObject imageJson = new JSONObject();
                
                // 1. DTO의 모든 '일반' 필드를 JSON 객체에 복사
                imageJson.put("transId", vo.getTransId());
                imageJson.put("x1", vo.getX1());
                imageJson.put("y1", vo.getY1());
                imageJson.put("x2", vo.getX2());
                imageJson.put("y2", vo.getY2());
                imageJson.put("menuName", vo.getMenuName());
                imageJson.put("transText", vo.getTransText());
                imageJson.put("menuDesc", vo.getMenuDesc());
                imageJson.put("colorBg", vo.getColor_bg());
                imageJson.put("colorTxt", vo.getColor_txt());
                
                
                imagesJsonArray.put(imageJson); // 배열에 추가
            }
            
            jsonResponse.put("status", "success");
            jsonResponse.put("message", "데이터를 성공적으로 검색했습니다.");
            
            // [ ★★★ 3. List<ImageVO> 대신 수동 생성한 JSONArray를 전송 ★★★ ]
            jsonResponse.put("myTranslations", imagesJsonArray); 
            
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