package com.pro.email_test;

import java.io.IOException;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



/**
 * Servlet implementation class MailSenderService
 */
@WebServlet("/MailSenderService")
public class MailSenderService extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");

		
		String to = request.getParameter("email_to");
		String subject = request.getParameter("email_subject");
		String body = request.getParameter("email_body");
		System.out.println(body);
		 
		boolean result = sendEmail(to, subject, body);
		
		if(result)
			System.out.println("five전송성공");
		else
			System.out.println("five전송실패");
	}
	/**
     * JNDI를 이용해 메일을 발송합니다.
     * @param to 받는 사람 이메일 주소 (예: "recipient@example.com")
     * @param subject 메일 제목
     * @param body 메일 본문 (HTML 형식으로 전송됩니다)
     */
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
            //    context.xml의 mail.user와 동일한 주소를 적어주는 것이 좋습니다.
            message.setFrom(new InternetAddress("smhrdfiveguys2025@gmail.com"));

            // 4. 수신자(Recipient) 설정
            //    메소드 파라미터로 받은 'to' 주소를 사용합니다.
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(to));

            // (선택) 참조(CC) 또는 숨은 참조(BCC) 추가
            // message.addRecipient(Message.RecipientType.CC, new InternetAddress("cc_user@example.com"));
            // message.addRecipient(Message.RecipientType.BCC, new InternetAddress("bcc_user@example.com"));

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
            System.out.println("메일 발송 성공! (To: " + to + ")");

        } catch (NamingException e){
            e.printStackTrace();
            System.err.println("naming: " + e.getMessage());
            // 실제 웹 애플리케이션에서는 사용자에게 실패를 알리는 로직이 필요할 수 있습니다.
        } catch (MessagingException e1) {
        	e1.printStackTrace();
            System.err.println("messaging: " + e1.getMessage());
        }
        return result;
    }
}
