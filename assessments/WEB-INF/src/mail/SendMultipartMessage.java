package mail;

import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;


public class SendMultipartMessage implements java.io.Serializable { 
    
    private EmailContents m_contents;
    
    public SendMultipartMessage (EmailContents contents) {
        m_contents = contents;
    }
    
    public EmailContents getContents () {
        return m_contents;
    }
    
    public boolean sendMail (String hostName) {
        
        boolean result = true;
        String element = null;
        
        Properties prop = new Properties();
        prop.put("mail.smtp.host", hostName);
        Session session = Session.getDefaultInstance(prop, null);
        
        
        
        try {
            Message msg = new MimeMessage(session);
            
            InternetAddress from = new InternetAddress(m_contents.getFrom());
            msg.setFrom(from);
            
            int count = 0;
            
            Vector toList = (Vector)((Vector)m_contents.getTo()).clone ();
            InternetAddress to[] = new InternetAddress [toList.size ()];
            for (count = 0; count < toList.size (); count++) {
                element = (String)toList.elementAt (count);
                //System.out.println("mail number "+count+" to:"+ element);
                to [count] = new InternetAddress (element);
            }
            msg.setRecipients(Message.RecipientType.TO, to);
            
            Vector ccList = (Vector)((Vector)m_contents.getCc()).clone ();
            InternetAddress cc[] = new InternetAddress [ccList.size ()];
            for (count = 0; count < ccList.size (); count++) {
                element = (String)ccList.elementAt (count);
                //System.out.println("mail number "+count+" cc:"+ element);
                cc [count] = new InternetAddress (element);
            }
            msg.setRecipients(Message.RecipientType.CC, cc);
            
            Vector bccList = (Vector)((Vector)m_contents.getBcc()).clone ();
            InternetAddress bcc[] = new InternetAddress [bccList.size ()];
            for (count = 0; count < bccList.size (); count++) {
                element = (String)bccList.elementAt (count);
                //System.out.println("mail number "+count+" bcc:"+ element);
                bcc [count] = new InternetAddress (element);
            }
            msg.setRecipients (Message.RecipientType.BCC, bcc);
            
            msg.setSubject (m_contents.getSubject ());
            
            MimeBodyPart mimeBodyPart = new MimeBodyPart ();
            mimeBodyPart.setContent (m_contents.getBody (), "text/plain");
            
            Multipart multiPart = new MimeMultipart ();
            multiPart.addBodyPart (mimeBodyPart);
            
            msg.setContent (multiPart);
            
            Transport.send (msg);
        } catch(MessagingException me) {
            me.printStackTrace();
            result = false;
        }
        return result;
    }
}
