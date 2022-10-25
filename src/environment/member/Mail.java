package environment.member;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import config.ReqUtil;
import util.Function;
  

public class Mail {
	/*public void idMailSend(HashMap<String,Object> param) throws UnsupportedEncodingException {
		
		String host = "smtp.cafe24.com";
		final String user = "sanggongdev@sanggong.co.kr";
		final String password = "tkdrhd1121!";
		
		String name = Function.parseStr(param.get("name"));
		//String strReceiver = ReqUtil.getParamu(request, "receiver", "");
		//String strSubject = ReqUtil.getParamu(request, "subject", "");
		//String strContents = ReqUtil.getParamu(request, "contents", "");
		
		Properties props = new Properties();
		props.put("mail.smtp.host", host);
		//props.put("mail.smtp.port", "465"); //tls
		props.put("mail.smtp.port", "465"); //ssl
		props.put("mail.smtp.auth", "true");
		
		//1 ssl방식
		props.put("mail.smtp.ssl.enable", "true");
		props.put("mail.smtp.ssl.trust", host);
		
		//2 SSLO방식
		//props.put("mail.smtp.starttls.enable", "true");
			
		
		Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(user, password);
			}
		});
		
		try {
			MimeMessage message = new MimeMessage(session);
			message.setFrom(new InternetAddress(user, "한국네트워크산업협회"));
			//message.addRecipient(Message.RecipientType.TO, new InternetAddress(strReceiver));

			//InternetAddress[] mailAddresses = new InternetAddress[3];
			//mailAddresses[0] = new InternetAddress("");
			//message.addRecipient(Message.RecipientType.TO, new InternetAddress(strReceiver));
			
			InternetAddress[] addArray = new InternetAddress[1]; 
			addArray[0] = new InternetAddress(Function.parseStr(info.get("email")));
			
			message.addRecipients(Message.RecipientType.TO, addArray);
						
			message.setSubject(strSubject);
			//message.setText(strContents);
			
			message.setContent(strContents, "text/html; charset=UTF-8");
			
			Transport.send(message);
			request.setAttribute("msg", "성공");
			
			
		}
		catch (MessagingException e) {
			request.setAttribute("msg", "실패");
			System.out.println("error : " + e.getMessage());
			e.printStackTrace();
		}
		
	}
	
	public void pwMailSend(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
		
		String host = "smtp.cafe24.com";
		final String user = "sanggongdev@sanggong.co.kr";
		final String password = "tkdrhd1121!";

		
		//String name = ReqUtil.getParamu(request, "name", "");
		//String strReceiver = ReqUtil.getParamu(request, "receiver", "");
		String strSubject = ReqUtil.getParamu(request, "subject", "");
		String strContents = ReqUtil.getParamu(request, "contents", "");
		
		Properties props = new Properties();
		props.put("mail.smtp.host", host);
		//props.put("mail.smtp.port", "465"); //tls
		props.put("mail.smtp.port", "465"); //sslo
		props.put("mail.smtp.auth", "true");
		
		//1 ssl방식
		props.put("mail.smtp.ssl.enable", "true");
		props.put("mail.smtp.ssl.trust", host);
		
		//2 SSLO방식
		//props.put("mail.smtp.starttls.enable", "true");
			
		
		Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(user, password);
			}
		});
		
		try {
			MimeMessage message = new MimeMessage(session);
			message.setFrom(new InternetAddress(user, "한국네트워크산업협회"));
			//message.addRecipient(Message.RecipientType.TO, new InternetAddress("sanggong0102@naver.com"));
			
			InternetAddress[] addArray = new InternetAddress[1]; 
			addArray[0] = new InternetAddress("sanggong0102@naver.com");
			
			
			message.addRecipients(Message.RecipientType.TO, addArray);

			//InternetAddress[] mailAddresses = new InternetAddress[3];
			//mailAddresses[0] = new InternetAddress("");
			//message.addRecipient(Message.RecipientType.TO, new InternetAddress("sjwy2k@naver.com"));
						
			message.setSubject(strSubject);
			//message.setText(strContents);
			
			message.setContent(strContents, "text/html; charset=UTF-8");
			
			Transport.send(message);
			request.setAttribute("msg", "성공");
			
			
		}
		catch (MessagingException e) {
			request.setAttribute("msg", "실패");
			System.out.println("error : " + e.getMessage());
			e.printStackTrace();
		}
		
	}*/
}
