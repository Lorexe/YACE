package net.yace.web.utils;

import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 *
 * @author ProjetJava
 */
public class EmailSender {
    public EmailSender(String emailDestinataire, String emailExpediteur, String objetMessage, String contenuMessage) {
        
        final String username = "yet.another.collection.engine@gmail.com";
        final String password = "!!y4c3!!";

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props,
            new javax.mail.Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(username, password);
                }
            });

        try {

                Message message = new MimeMessage(session);
                message.setFrom(new InternetAddress(emailDestinataire));
                InternetAddress[] internetAddresses = new InternetAddress[1];
                internetAddresses[0] = new InternetAddress(emailExpediteur); 
                message.setRecipients(Message.RecipientType.TO,internetAddresses);
                message.setSubject(objetMessage);
                message.setText(contenuMessage);
                
                Transport.send(message);


        } catch (MessagingException e) {
                throw new RuntimeException(e);
        }
    }
}