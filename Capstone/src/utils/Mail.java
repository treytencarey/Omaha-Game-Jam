package utils;

import java.util.Properties;
import javax.mail.PasswordAuthentication;
import javax.mail.Address;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.sun.istack.internal.logging.Logger;

public class Mail {
	
	String email;
	String password;
	Message message;
	String subject;
	String body;
	Session session;
	Properties properties = new Properties();
	
	{	
		properties.put("mail.smtp.auth", "true");
		properties.put("mail.smtp.starttls.enable", "true");
		properties.put("mail.smtp.host", "smtp.gmail.com");
		properties.put("mail.smtp.port", "587");
		
		session = Session.getInstance(properties, new Authenticator() {
			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(email,password);
			}
		});
	}
	
	public Mail(String e, String p, String s, String b) {
		email = e;
		password = p;
		subject = s;
		body = b;
	}
	
	public void sendMail() throws Exception {
		
		
		Transport.send(message);
		System.out.println("Sent successfully");
	}
	
	public void prepareMessage() {
		try {
			message = new MimeMessage(session);
			message.setFrom(new InternetAddress(email));
			message.setSubject(subject);
			message.setContent(body,"text/html");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public void addRecipients(String[] r) {

			if(r.length < 2) {
				try {
					message.setRecipient(Message.RecipientType.TO, new InternetAddress(r[0]));
				} catch (MessagingException e) {
					e.printStackTrace();
				}
			} else {
				String addresses = r[0];
				for(int i = 1; i < r.length; i++) {
					addresses += ","+r[i];
				}
				System.out.println(addresses);
				try {
					message.addRecipients(Message.RecipientType.CC,InternetAddress.parse(addresses));
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
	}
}
