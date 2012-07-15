package mail;

import java.util.*;

/**
 * This class (originally EmailSendServlet.java), was originally written by Gopalan Suresh Raj
 * (http://gsraj.tripod.com/jsp/), and has been modified by P�ter Nel. It has been converted from
 * a servlet into a normal class.
 * 
 * This class uses the other classes in the mail package to construct and send emails.
 * 
 * @author Gopalan Suresh Raj, psnel
 *
 */
public class MailSender
{

    private String SMTP_HOST = "localhost";

    public MailSender()
    {
    }

    public MailSender(String smtphost)
    {
        SMTP_HOST = smtphost;
    }

    public boolean doPost(
            String from, String toList, String ccList,
            String bccList, String subject, String body)
    {

        Vector to = parseList(toList);
        Vector cc = parseList(ccList);
        Vector bcc = parseList(bccList);


        Vector emailList = new Vector();
        EmailContents emailContents = new EmailContents(from, to, cc, bcc, subject, body);
        emailList.addElement(emailContents);

        SendMultipartMessage message = new SendMultipartMessage(emailContents);
        boolean result = message.sendMail(SMTP_HOST);

        return result;
    }

    private Vector parseList(String stream)
    {

        Vector holder = new Vector();
        String element = null;
        int i = 0;

        StringTokenizer tokenizer = new StringTokenizer(stream, ",;");
        while (tokenizer.hasMoreTokens())
        {
            element = tokenizer.nextToken();
            holder.addElement(element);
        }

        return holder;
    }
}
