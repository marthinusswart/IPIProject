/* QandA.java
 * 
 * Created on 13-Jul-2005
 */
package beans;

/**
 * This class encapsulates three db entities: Question, Answer, and Wording. It represents a correctly worded
 * question as it would be displayed to the user during the test, as well as the answer that the user
 * subsequently gives.
 *
 * 
 * @author psnel
 *
 */
public class QandA {
    private int		qPKID;		// pkid of question
    private String		wording;	// wording of question (actual sentence)
    private boolean	isInverted;	// whether it's a reverse-valued question
    private int		fkC;		// f-key to Construct
    
    private int		answer=0;		// 1..5
    private int		timetaken=-127;	// time in seconds
    private int		nDoubted=-1; 	// how many times the user changed their answer
    
    private int		iSplit=0;		// split to which this answer belongs
    
    private boolean	isStored;	// flag: answer stored in db
    
    
    
    public QandA (int qpkid, String words){
        qPKID	= qpkid;
        wording	= words;
    }
    
    
    
    /**
     * @param custID
     * @param answer
     * @param timetaken
     * @param doubted
     * @param isInverted
     */
    public QandA(int constID, int answer, int timetaken, int doubted, boolean isInverted) {
        this.fkC = constID;
        this.answer = answer;
        this.timetaken = timetaken;
        this.nDoubted = doubted;
        this.isInverted = isInverted;
    }
    
    
    public int getPKID(){
        return qPKID;
    }
    
    public String getWording(){
        return wording;
    }
    
    public void setWording(String words){
        wording = words;
    }
    
    public boolean isAnswered(){
        return (answer > 0) && (timetaken > -127) && (nDoubted > -1);
    }
    
    public boolean isStored(){
        return isStored;
    }
    
    public int getSplitSet(){
        return iSplit;
    }
    
    
    /**
     * @return Returns the answer.
     */
    public int getAnswer() {
        return answer;
    }
    /**
     * @return Returns the nDoubted.
     */
    public int getNDoubted() {
        return nDoubted;
    }
    /**
     * @return Returns the timetaken.
     */
    public int getTimetaken() {
        return timetaken;
    }

    /**
     * @return Returns the fkC.
     */
    public int getFkC() {
        return fkC;
    }
    /**
     * @return Returns the isInverted.
     */
    public boolean isInverted() {
        return isInverted;
    }

    
    /**
     * @param answer The answer to set.
     */
    public void setAnswer(int answer) {
        this.answer = answer;
    }
    /**
     * @param doubted The nDoubted to set.
     */
    public void setNDoubted(int doubted) {
        nDoubted = doubted;
    }
    /**
     * @param timetaken The timetaken to set.
     */
    public void setTimetaken(int timetaken) {
        this.timetaken = timetaken;
    }

    public void setStoredFlag(boolean iss){
        isStored = iss;
    }

    public void setSplitSet(int split){
        iSplit = split;
    }
}
