/* QreType.java
 * 
 * Created on 08-Sep-2005
 */
package beans;

import java.io.Serializable;

/**
 * @author psnel
 *
 */
public class QreType  implements Serializable{
    private int PKID;
    private String code;
    private String name;
    
    private static String [][] _types = {
            {"??", "??"},
            {"VA", "Values Profile Assessment"},
            {"FA", "Full Assessment"},
            {"JP", "Job Definition Profile"},
            {"SI", "Organization Screening Inventory"},
            {"PP", "Personal Profile"},
            {"HA", "Highschool Assessment"},
            {"CP", "Career Planning Inventory"}
    };
    
    public QreType(){}
    
    public QreType(int pkid) throws Exception{
        try
        {
            this.PKID	= pkid;
            this.code	= _types[(pkid>=0)?pkid:0][0];
            this.name	= _types[(pkid>=0)?pkid:0][1];
        }
        catch (Exception ex)
        {
            throw new Exception("Failed to create Type: " + pkid);
        }        
    }
    
    public QreType(int pkid, String code, String name) {
        PKID = pkid;
        this.code = code;
        this.name = name;
    }
    
    
    
    /**
     * @return Returns the code.
     */
    public String getCode() {
        return code;
    }
    /**
     * @return Returns the name.
     */
    public String getName() {
        return name;
    }
    /**
     * @return Returns the pKID.
     */
    public int getPKID() {
        return PKID;
    }
    
    
    /**
     * @param code The code to set.
     */
    public void setCode(String code) {
        this.code = code;
    }
    /**
     * @param name The name to set.
     */
    public void setName(String name) {
        this.name = name;
    }
    /**
     * @param pkid The pKID to set.
     */
    public void setPKID(int pkid) {
        PKID = pkid;
    }
}
