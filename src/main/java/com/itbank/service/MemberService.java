package com.itbank.service;


import java.util.HashMap;
import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itbank.member.MemberDAO;
import com.itbank.member.MemberDTO;

@Service
public class MemberService {

	
	@Autowired private MemberDAO dao;
	
	public boolean sendEmail(String email,String url,String auth) {
		
		// 메일을 발송하는데 사용하는 코드
		String host = "smtp.naver.com";
		final String username = "아이디";
		final String password = "비밀번호";
		int port = 587; // imap 의 포트번호
		// 메일에 보내는 서버에 대한 인증과 속성을 설정한다.
		Properties props = System.getProperties();

		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", port);
		props.put("mail.smtp.auth", "true");
//		props.put("mail.smtp.ssl.enable", "true");
//		props.put("mail.smtp.trust", host);

		Session mailSession = Session.getDefaultInstance(props, new Authenticator() {

			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(username, password);
			}
		}); // httpSession 이 아니라 javaMail 의 Session이다, // Authenticator() 는 가상메소드기 때문에 람다식으로
			// 처리
//		mailSession.setDebug(true);

		// 메일의 전반적인 내용을 설정 (보내는 사람, 받는사람, 제목, 내용)
		Message mimeMessage = new MimeMessage(mailSession);
		

		
		String body = "이메일 인증입니다 . 해당 주소로 이동하여 주세요. "+url+"?auth="+auth;

		try {
			mimeMessage.setFrom(new InternetAddress(username + "@naver.com"));
			mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(email));
			mimeMessage.setSubject("test 제목");
			mimeMessage.setText(body);
			Transport.send(mimeMessage);
		} catch (MessagingException e) {
			System.out.println("실패");
			return false;
		}

		System.out.println("성공");
		return true;
		
	}

	public int insert(MemberDTO dto) {
		return dao.insert(dto);
	}

	public MemberDTO selectOne(HashMap<String, String> param) {
		return dao.selectOne(param);
	
	}


	public MemberDTO check_email(String email) {
		return dao.check_email(email);
	}

	public MemberDTO check_nick(String nick) {
		return dao.check_nick(nick);
	}

	public String sendMail(String account,String mailAddress, String title,String textBody) {

		// 메일을 발송하는데 사용하는 코드
		String host = "smtp.naver.com";
		final String username = account.split("/")[0];
		final String password = account.split("/")[1];
		int port = 993;	//imap 의 포트번호
		// 메일에 보내는 서버에 대한 인증과 속성을 설정한다.
		Properties props = System.getProperties();
		
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", port);
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.ssl.enable", "true");
		props.put("mail.smtp.trust", host);
		
		Session	mailSession = Session.getDefaultInstance(props, new Authenticator() {
			
			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(username, password);
			}
		});			// httpSession 이 아니라 javaMail 의 Session이다,		// Authenticator() 는 가상메소드기 때문에 람다식으로 처리
		mailSession.setDebug(true);
		
		// 메일의 전반적인 내용을 설정 (보내는 사람, 받는사람, 제목, 내용)
		Message mimeMessage = new MimeMessage(mailSession);
		
		String body= "인증번호는  : "+textBody+"입니다.";
		
		try {
			mimeMessage.setFrom(new InternetAddress(username + "@naver.com"));
			mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(mailAddress));
			mimeMessage.setSubject(title);
			mimeMessage.setText(body);
			Transport.send(mimeMessage);
		} catch (MessagingException e) {
			
			return "주소가 잘못되었습니다.";
		}
		
		return "메일이 정상적으로 전송되었습니다.";
	}

	public int updateEmail(String email, String member_nick, String login_nick) {
		HashMap<String, String>param=new HashMap<String, String>();
		param.put("email", email);
		param.put("member_nick", member_nick);
		param.put("login_nick", login_nick);
		return dao.updateEmail(param);
	}

	public int updatePw(HashMap<String, String> param) {
		if(param.get("password")!=null) {
			return dao.updatePw(param);
		}
		return 0;
	}

}
