package com.pro.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pro.menu.model.MenuDataDAO;

@WebServlet("/GetImageFile.po")
public class GetImageFileService extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void service(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. 파라미터(imgId) 받기
        String imgId = request.getParameter("imgId");
        if (imgId == null || imgId.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Image ID is required.");
            return;
        }
        System.out.println(imgId);
        // 2. DAO를 통해 DB에서 byte[] 조회
        MenuDataDAO dao = new MenuDataDAO();
        
        
        try {
            // DAO에서 byte[]를 직접 받음
            byte[] imageData = dao.getImageFile(imgId); 

            if (imageData == null || imageData.length == 0) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Image not found.");
                return;
            }

            // 3. (★핵심★) MimeType을 "image/png"로 고정
            response.setContentType("image/png");
            response.setContentLength(imageData.length);

            // 4. (★핵심★) Response의 OutputStream으로 이미지 바이트 전송
            try (ServletOutputStream out = response.getOutputStream()) {
                out.write(imageData);
                out.flush();
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error processing image.");
        }
    }
}
