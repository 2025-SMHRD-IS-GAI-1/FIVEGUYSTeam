package com.pro.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.pro.frontcontroller.Command;
import com.pro.menu.model.ImageVO;
import com.pro.menu.model.MenuDataDAO;

public class UpdateImageInfoService implements Command {

	@Override
	public String excute(HttpServletRequest request, HttpServletResponse response) {
		String moveurl = "redirect:/Gomypage.do";
		
		String imgId = request.getParameter("imgId");
		String res_name = request.getParameter("storeName");
		String addr = request.getParameter("storeAddress");
		String ratings = request.getParameter("ratings");
		String lat = request.getParameter("lat");
		String lon = request.getParameter("lon");
		String imgCheck = request.getParameter("imgCheck");
		
		MenuDataDAO dao =new MenuDataDAO();
		ImageVO mvo = new ImageVO();
		System.out.println(imgId+":"+res_name+":"+addr+":"+ratings+":"+lat+":"+lon+":"+imgCheck);
		mvo.setImgId(imgId);
		mvo.setResName(res_name);
		mvo.setAddr(addr);
		mvo.setRatings(ratings);
		mvo.setLat(lat);
		mvo.setLon(lon);
		mvo.setImgCheck(imgCheck);
		
		HttpSession session = request.getSession(false);
		
		int row = dao.updateImage(mvo);
		if(row>0) {
			session.setAttribute("imageupdate", "ok");
		}
		
		return moveurl;
	}

}
