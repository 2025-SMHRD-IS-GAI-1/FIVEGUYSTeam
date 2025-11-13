package com.pro.controller;

import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.sql.Timestamp; // [수정됨] Timestamp 임포트

import org.json.JSONArray; // org.json 라이브러리 필요
import org.json.JSONObject; // org.json 라이브러리 필요

import com.pro.frontcontroller.Command;


import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import com.pro.menu.model.*;


public class SaveMenuDataService implements Command {
    
	@Override
    public String excute(HttpServletRequest request, HttpServletResponse response) {
		String moveurl = "fetch:/"+"{\"result\" : \"false\"}";
		JSONObject jsonResponse = new JSONObject(); // 클라이언트에 보낼 JSON
        
        try {
            // 1. FormData에서 'imgFile' (BLOB) 파트 가져오기
            Part imgFilePart = request.getPart("imgFile");
            InputStream imgFileInputStream = imgFilePart.getInputStream();

            // 2. FormData에서 'metadata' (JSON 문자열) 파트 가져오기
            Part metadataPart = request.getPart("metadata");
            String metadataString = new String(metadataPart.getInputStream().readAllBytes(), StandardCharsets.UTF_8);
            
            // 3. JSON 문자열 파싱
            JSONObject metadataJson = new JSONObject(metadataString);
            JSONObject tImageJson = metadataJson.getJSONObject("T_IMAGE");
            JSONArray tTranslationJson = metadataJson.getJSONArray("T_TRANLATION");

            // 4. ImageDTO 생성
            ImageVO imageVO = new ImageVO();
            imageVO.setImgId(tImageJson.getString("IMG_ID"));
            imageVO.setId(tImageJson.getString("ID"));
            imageVO.setImgName(tImageJson.getString("IMG_NAME"));
            imageVO.setUploadDt(new Timestamp(System.currentTimeMillis()));
            System.out.println(tImageJson.getString("IMG_ID")+":"+tImageJson.getString("ID"));
            imageVO.setImgFile(imgFileInputStream); // BLOB 스트림 설정
            MenuDataDAO dao = new MenuDataDAO();
            dao.insertImage(imageVO); // T_IMAGE 저장
            
            for (int i = 0; i < tTranslationJson.length(); i++) {
                JSONObject tJson = tTranslationJson.getJSONObject(i);
                TranslationVO tVO = new TranslationVO();
                
                tVO.setTransId("t20251104");
                tVO.setImgId(tImageJson.getString("IMG_ID")); // ImageDTO의 ID와 동일
                tVO.setX1(tJson.getInt("X1"));
                tVO.setY1(tJson.getInt("Y1"));
                tVO.setX2(tJson.getInt("X2"));
                tVO.setY2(tJson.getInt("Y2"));
                tVO.setMenuName(tJson.getString("MENU_NAME"));
                tVO.setTransText(tJson.getString("TRANS_TEXT"));
                tVO.setMenuDesc(tJson.getString("MENU_DESC"));
                tVO.setColor_bg(tJson.getString("COLOR_BG"));
                tVO.setColor_txt(tJson.getString("COLOR_TXT"));
                
                dao.insertTranslation(tVO); // T_TRANLATION (배치) 저장   
            }

            
            jsonResponse.put("status", "success");
            jsonResponse.put("message", "데이터가 성공적으로 저장되었습니다.");
            jsonResponse.put("imgId", imageVO.getImgId());
            moveurl = "fetch:/"+jsonResponse.toString();

        } catch (Exception e) {
            // 9. 오류 발생 시 롤백
            e.printStackTrace();
            
            
            // 10. 실패 응답 전송
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            jsonResponse.put("status", "error");
            jsonResponse.put("message", "DB 저장 중 오류 발생: " + e.getMessage());
            moveurl = "fetch:/"+jsonResponse.toString();
            
        }
        return moveurl;
    }
}