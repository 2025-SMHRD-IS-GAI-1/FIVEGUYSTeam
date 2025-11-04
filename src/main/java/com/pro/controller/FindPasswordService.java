package com.pro.controller;

<<<<<<< HEAD
import java.security.SecureRandom;

=======
import java.io.UnsupportedEncodingException;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
>>>>>>> 6bf7c093462155d5bab3f9d8e9fb79567a7e9913
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pro.frontcontroller.Command;
import com.pro.model.MemberDAO;
import com.pro.model.MemberVO;
import com.pro.utils.PasswordUtils;
<<<<<<< HEAD

// 선택: 메일 발송이 준비되어 있으면 사용
// import com.pro.email_test.MailSenderService;

public class FindPasswordService implements Command {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        String id    = trimOrNull(request.getParameter("id"));
        String email = trimOrNull(request.getParameter("email"));

        // 1) 기본 검증
        if (id == null || email == null) {
            return "redirect:/pw_find.jsp?err=1";
        }

        // 2) 아이디+이메일 일치 확인
        MemberDAO dao = new MemberDAO();
        MemberVO vo = dao.findByIdEmail(id, email);
        if (vo == null) {
            return "redirect:/pw_find.jsp?err=1";
        }

        // 3) 임시 비밀번호 생성
        String tempPw = generateTempPassword(10);

        // 4) 해시 후 DB 반영 (Salt로 ID 사용)
        String hashed = PasswordUtils.hashPassword(tempPw, id);
        int row = dao.updatePasswordById(id, hashed);
        if (row <= 0) {
            return "redirect:/pw_find.jsp?err=1";
        }

        // 5) (선택) 메일 발송 — 준비 안 되어 있으면 이 블록 주석 처리 가능
        /*
        try {
            String subject = "[FIVE GUYS] 임시 비밀번호 안내";
            String body = "<p>안녕하세요, FIVE GUYS 입니다.</p>"
                        + "<p>요청하신 임시 비밀번호는 <b>" + tempPw + "</b> 입니다.</p>"
                        + "<p>로그인 후 즉시 비밀번호를 변경해 주세요.</p>";
            MailSenderService sender = new MailSenderService();
            sender.sendEmail(email, subject, body);
        } catch (Exception ignore) {
            // 메일 실패해도 비밀번호는 이미 변경됨
        }
        */

        // 6) 로그인으로 안내
        return "redirect:/login.jsp?resetOk=1";
    }

    // ---------- helpers ----------
    private static String trimOrNull(String s) {
        if (s == null) return null;
        s = s.trim();
        return s.isEmpty() ? null : s;
    }

    private static String generateTempPassword(int len) {
        final String chars = "ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnpqrstuvwxyz23456789!@#$%^&*";
        SecureRandom r = new SecureRandom();
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < len; i++) {
            sb.append(chars.charAt(r.nextInt(chars.length())));
        }
        return sb.toString();
    }
=======
import com.pro.utils.SecureRandomString;

/**
 * Servlet implementation class FindPasswordService
 */
@WebServlet("/FindPasswordService")
public class FindPasswordService implements Command {
	
	public String excute(HttpServletRequest request, HttpServletResponse response) {
		String moveurl = "redirect:/Gologin.do";
			try {
				request.setCharacterEncoding("UTF-8");
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			response.setCharacterEncoding("UTF-8");
			response.setContentType("text/html;charset=UTF-8");
	
			// 1. id / email 받아온다
			String id = request.getParameter("id");
			String email = request.getParameter("email");
			
			// 2. PW값을 16자리의 영문대소문자, 숫자, 특수문자로 랜덤으로 생성
			SecureRandomString srs = new SecureRandomString();
			String newPassword = srs.makeString(16);
			
			// 3. 생성된 비밀번호는 SHA-512 알고리즘으로 128비트로 암호화
			String reversePW = new StringBuilder(newPassword).reverse().toString();
			String hashedPW = PasswordUtils.hashPassword(reversePW+newPassword, id);
			
			
			// 4. id / email 해당하는 유저를 T_MEMBER에서 찾아 생성한 PW로 update
			MemberDAO dao = new MemberDAO();
			MemberVO vo = new MemberVO();
			vo.setId(id);
			vo.setEmail(email);
			vo.setPw(hashedPW);
			dao.changePw(vo);
			
			// 5. email정보로 gmail 보내기, 암호화되기 전의 새로생성한 비밀번호를 발송한다.
			String subject = "[FIVEGUYS] "+id+"님! 메뉴번역기 서비스의 비밀번호가 변경되었습니다.";
			String body="<p>비밀번호 변경을 통보드립니다.</p>"
					+"<p>변경된 비밀번호는 다음과 같습니다.</p><br><br>"
					+"<h4>"+newPassword+"</h4><br><br>"
					+"<p>개인정보 수정페이지에서 원하는 암호로 다시 변경하실 수 있습니다.</p><br>"
					+"<p>감사합니다.</p>";
			boolean result = sendEmail(email, subject, body);
			
			if(result) {
				System.out.println("five전송성공");
				
			}else {
				System.out.println("five전송실패");
			}
			return moveurl;
	}
	
	public boolean sendEmail(String to, String subject, String body) {
        boolean result = false;
        try {
            // 1. JNDI를 통해 Tomcat에 설정된 세션(Session) 객체 찾기
            Context initCtx = new InitialContext();
            Context envCtx = (Context) initCtx.lookup("java:comp/env");
            Session session = (Session) envCtx.lookup("mail/myMailSession");

            // 2. 메시지 객체 생성 (MimeMessage)
            MimeMessage message = new MimeMessage(session);

            // 3. 발신자(From) 설정
            message.setFrom(new InternetAddress("smhrdfiveguys2025@gmail.com"));

            // 4. 수신자(Recipient) 설정
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(to));

            // 5. 메일 제목 설정 (한글 깨짐 방지 - "UTF-8")
            message.setSubject(subject, "UTF-8");

            // 6. 메일 내용(본문) 설정 (HTML 형식)
            //    setText의 세 번째 인자로 "html"을 주면 HTML 메일로 인식됩니다.
            message.setText(body, "UTF-8", "html");
            
            // (참고) 만약 HTML이 아닌 일반 텍스트로 보내려면:
            // message.setText(body, "UTF-8");

            // 7. 메일 발송
            Transport.send(message);
            result = true;
            //System.out.println("메일 발송 성공! (To: " + to + ")");

        } catch (NamingException e){
            e.printStackTrace();
            System.err.println("naming: " + e.getMessage());
            
        } catch (MessagingException e1) {
        	e1.printStackTrace();
            System.err.println("messaging: " + e1.getMessage());
        }
        return result;
    }
	
>>>>>>> 6bf7c093462155d5bab3f9d8e9fb79567a7e9913
}
