package email;

import java.util.Properties;
import java.util.StringTokenizer;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.Authenticator;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.SendFailedException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.internet.MimeUtility;
import property.*;


public class SendMail {
	
	// 파일 첨부가 없는 메일을 보내기
	public static int sendEmail(String from, String to, String subject, String contents) throws Exception, SendFailedException {
		int result = 0;
		try {
			Properties props = System.getProperties();
			props.setProperty("mail.transport.protocol", "smtp");     
			props.put("mail.smtp.starttls.enable", "true");
			props.put("mail.smtp.host", property.SiteProperty.SMTP_HOST);
			
			props.put("mail.smtp.port", "465");  //465(SSL) 587(TLS)
			//props.put("mail.smtp.ssl.trust", property.SiteProperty.SMTP_HOST);
			props.put("mail.smtp.auth", "true");
			props.put("mail.smtp.socketFactory.class","javax.net.ssl.SSLSocketFactory"); 
			props.put("mail.smtp.socketFactory.fallback", "false");  
			
			
			//props.put("mail.smtp.port", "465");  
			//props.put("mail.smtp.auth", "true");
			//props.put("mail.smtp.ssl.enable", "true");
			//props.put("mail.smtp.ssl.trust", SiteProperty.SMTP_HOST);
			
			Authenticator loAuthenticator = new MailAuthenticator(property.SiteProperty.SMTP_USER, property.SiteProperty.SMTP_PASSWORD); 
			Session session = Session.getInstance(props, loAuthenticator);
			
			session.setDebug(false);
			
			MimeMessage message = new MimeMessage(session);
			
			InternetAddress fromAddress = new InternetAddress(property.SiteProperty.COMPANY_EMAIL, property.SiteProperty.COMPANY_NAME);
			message.setFrom(fromAddress);
			message.addRecipients(Message.RecipientType.TO, to);
			
			message.setSubject(subject, "utf-8");

			message.setContent(contents,"text/html; charset=utf-8");
		
			Transport.send(message);				// 메일 발송
			result = 1;								// 정상 발송
		} catch (SendFailedException e) {			// 메일 주소 중 형식 올바르지 않는 주소가 있을 때
			result = 2;
			throw e;			
		} catch (Exception e){
			System.out.println(e.toString());
		}
		return result;
	}


	// 파일 첨부형 메일 보내기
	public static int sendEmailFile(String to, String savePath, MailVO vo, String type) throws Exception {
		try {
			Properties props = System.getProperties();
			props.put("mail.smtp.host", property.SiteProperty.SMTP_HOST);
			props.put("mail.smtp.auth", "true");
			Authenticator loAuthenticator = new MailAuthenticator(property.SiteProperty.SMTP_USER, property.SiteProperty.SMTP_PASSWORD); 
			Session session = Session.getInstance(props, loAuthenticator);
			
			session.setDebug(false);
			
			MimeMessage message = new MimeMessage(session);
			
			//message.setFrom(new InternetAddress(Function.encodeUTF8(property.SiteProperty.COMPANY_NAME) + "<" + from +">"));

			InternetAddress fromAddress = new InternetAddress(vo.getSendman(), property.SiteProperty.COMPANY_NAME);
			message.setFrom(fromAddress);
			message.addRecipients(Message.RecipientType.TO, to);
			message.setSubject(vo.getTitle(), "utf-8");
			message.setContent(vo.getContents(),"text/html; charset=utf-8");

			if ( type.equals("html")){
				BodyPart messageBodyPart = new MimeBodyPart();
				messageBodyPart.setContent(vo.getContents(),"text/html; charset=utf-8");
				MimeMultipart multipart = new MimeMultipart();
				multipart.addBodyPart(messageBodyPart);	
				
				if ( vo.getFilename() != null && !"".equals(vo.getFilename())){

					messageBodyPart = new MimeBodyPart();
					DataSource source = new FileDataSource(savePath+"/"+vo.getFilename());
					messageBodyPart.setDataHandler(new DataHandler(source));
					messageBodyPart.setFileName(MimeUtility.encodeText(vo.getFilename_org(), "UTF-8","B"));
					multipart.addBodyPart(messageBodyPart);
				}

				if ( vo.getFilename2() != null && !"".equals(vo.getFilename2())){

					messageBodyPart = new MimeBodyPart();
					DataSource source = new FileDataSource(savePath+"/"+vo.getFilename2());
					messageBodyPart.setDataHandler(new DataHandler(source));
					messageBodyPart.setFileName(MimeUtility.encodeText(vo.getFilename2_org(), "UTF-8","B"));
					multipart.addBodyPart(messageBodyPart);
				} 

				if ( vo.getFilename3() != null && !"".equals(vo.getFilename3())){

					messageBodyPart = new MimeBodyPart();
					DataSource source = new FileDataSource(savePath+"/"+vo.getFilename3());
					messageBodyPart.setDataHandler(new DataHandler(source));
					messageBodyPart.setFileName(MimeUtility.encodeText(vo.getFilename3_org(), "UTF-8","B"));
					multipart.addBodyPart(messageBodyPart);
				}

				message.setContent(multipart);
				
			} else if ( type.equals("text")){
				message.setText(vo.getContents());
			}

			//	루프를 돌면서 메일을 보내게 할때
			StringTokenizer st = new StringTokenizer(to,",");

			String emails[] = new String[st.countTokens()];

			int i = 0;

			while ( st.hasMoreElements() ){
				emails[i] = (String)st.nextElement();
//				Transport.send(message);
				i++;

			}
			sendEmailFile(emails, 0, message);

			//message.addRecipients(Message.RecipientType.BCC, to);				// BCC(숨은참조) 여러명을 보내도 받는 사람 목록에 나타나지 않는다.
			//Transport.send(message);											// 메일 발송
			
		} catch (Exception e){
			System.out.println(e.toString());
		}
		return 1;															// 정상 발송 완료
	}

	// 파일 첨부형 메일 보내기
	public static void sendEmailFile(String[] emails, int index, MimeMessage message) throws Exception, SendFailedException {

		int cnt=index;
		
		try {
			for (int i=index; i<emails.length; i++) {
				cnt++;
				message.setRecipients(Message.RecipientType.TO, emails[i]);		// TO(받는사람) 여려명을 보내면 받는사람에 같이 나타난다.
				Transport.send(message);										// 메일 발송
			}

		} catch (SendFailedException e) {										// 메일 주소 중 형식 올바르지 않는 주소가 있을 때
			sendEmailFile(emails, cnt, message);
		} catch (Exception e){
			System.out.println(e.toString());
		}
	}
}
