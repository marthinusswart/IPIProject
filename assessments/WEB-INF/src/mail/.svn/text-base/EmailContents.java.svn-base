package mail;

import java.util.*;

public class EmailContents implements java.io.Serializable { 
    private String m_from;
    private Vector m_to = new Vector();
    private Vector m_cc = new Vector();
    private Vector m_bcc = new Vector();
    private String m_subject;
    private String m_body;
    
    public EmailContents (String from, Vector to, Vector cc,
            Vector bcc, String subject, String body) {
        m_from = from;
        m_to = (Vector)to.clone ();
        m_cc = (Vector)cc.clone ();
        m_bcc = (Vector)bcc.clone ();
        m_subject = subject;
        m_body = body;
    }
    
    public String getFrom () { return m_from; }
    public Vector getTo () { return m_to; }
    public Vector getCc () { return m_cc; }
    public Vector getBcc () { return m_bcc; }
    public String getSubject () { return m_subject; }
    public String getBody () { return m_body; }
    
    public void setFrom (String from) { m_from = from; }
    public void setTo (Vector to) { m_to = (Vector)to.clone (); }
    public void setCc (Vector cc) { m_cc = (Vector)cc.clone (); }
    public void setBcc (Vector bcc) { m_bcc = (Vector)bcc.clone (); }
    public void setSubject (String subject) { m_subject = subject; }
    public void setBody (String body) { m_body = body; }
    
}
