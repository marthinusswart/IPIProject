/* LiveTest.java
 * 
 * Created on 12-Jul-2005
 */
package beans;

import java.sql.ResultSet;
import java.util.Iterator;
import java.util.Map;
import java.util.Vector;
import mail.MailSender;
import org.apache.log4j.*;

/**
 * Synopsis:
 * 
 * A LiveTest maintains the state of a test in the process of being completed by a user. It contains an array of 
 * QandA objects (questions and answers), which are the set of all "correctly worded" questions in the
 * associated Questionaire together with answers that will be provided during the test.
 * 
 * The user is presented with (iQsPerPg) Questions at a time, each of which is chosen randomly (on-the-fly) from
 * the entires set of (ananswered) questions.
 * 
 * Each time the next set of questions are retrieved via getNext(), the current pointer (iQPos) is incremented by
 * (iQsPerPage). Tests can only move forward, i.e. users cannot go back to questions already answered.
 * 
 * A user may answer a maximum of (iMaxQ) questions at a time; if a Questionaire has more than iMaxQ Questions,
 * the test must be split up into 2 or more sets (split sets) of approx. equal length, each of which must
 * be taken no less than (iCooldownTime) seconds apart (relates to user's ability to concentrate for
 * prolonged periods).
 * 
 * @author psnel
 *
 */
public class LiveTest
{

    private Assignment assignment;		// assignment associated with this test
    private Questionaire questionaire;	// questionaire associated with the assignment
    private QandA[] qna = null;		// set of all questions and (some of their) answers
    //private int iQPos=0;					// current question (1..iTstLen)
    //private int iTstLen=0;					// total number of questions (:assignment)
    private int iSplitSet = 1;				// the current splitset of the test (1..iNSplits+1)
    private int iMaxQ = 350;					// the maximum number of questions per splitSet
    private int iNSplits = 0;				// total number of splits (iTstLen/iMaxQ)
    private int iSplitLen = 0;				// the number of questions in this split
    private int iCooldownTime = 45;			// minimum amount of time (minutes) a user must wait
    // before continuing with the next splitset.
    private int iQsPerPg = 10;				// number of questions per page.
    private int[] indexes = null;			// set of indexes of ananswered questions (see randomUnansweredQ())
    private int[] tmpXIx = new int[iQsPerPg]; // temp array used for generating eXclusive random Indexes (see randomUnansweredQ())

    public LiveTest(Assignment assmt, Questionaire qre) throws Exception
    {
        assignment = assmt;
        questionaire = qre;

        DBProxy db = new DBProxy();
        ResultSet res;
        String SQL;

        // 1. questions & answers
        qna = new QandA[questionaire.getTestLength()];


        // 2. current split set
        SQL =
        "SELECT MAX(splitSet) AS mx "
        + "FROM _Answer "
        + "WHERE fkAssmt=" + assignment.getPKID();
        res = db.executeQuery(SQL);
        if (res.next())
        {
            iSplitSet = res.getInt("mx") + 1;
        }


        // 3. load questions
        loadQuestions(db);

        // 4. load answers
        loadAnswers(db);

        // 5. total splits & length of this split 
        int avgSplitLen, i, count = 0;
        if (qna.length > iMaxQ)
        {
            iNSplits = (int) Math.ceil((double) qna.length / (double) iMaxQ);
            iSplitLen = avgSplitLen = (int) Math.ceil((double) qna.length / (double) iNSplits);
            iNSplits--;

        }
        else
        {
            iSplitLen = avgSplitLen = qna.length;
        }


        // 6. Not the first split? ..
        if (iSplitSet > 1)
        {
            // 6.1 Was the previous split abnormally terminated..
            // ..count all answers in the previous split-set
            for (i = 0; i < qna.length; i++)
            {
                if (qna[i].getSplitSet() == iSplitSet - 1)
                {
                    count++;
                }
            }

            if (count < avgSplitLen)
            { // YES: recover..
                iSplitSet--;
            }

            // 6.2 Last split? 
            if (iNSplits > 0 && iSplitSet == iNSplits + 1)
            {	// YES: in case of non-uniform split..
                // set total = nCompleted + nRemaining
                iSplitLen = getQCompleted() + getTotQRemaining();
            }

        }

        db.close();

    }

    public void start() throws Exception
    {
        // start current split..
        Logger log = Logger.getLogger(LiveTest.class);
        String fkUserId = "";
        String pkQreId = "";

        if (assignment != null)
        {
            fkUserId = assignment.getFkUser();
        }
        if (questionaire != null)
        {
            pkQreId = questionaire.getPKID();
        }

        log.info("Test is starting. FKUserID:" + fkUserId + " Questionnaire PKID:" + pkQreId);

        // set test_status
        assignment.setFkTstStatus("1");
        assignment.setTstStatusDesc("in progress");
        assignment.update();

    }

    public void end(boolean testCompleted) throws Exception
    {
        // end current split / entire test

        // set test_status and set_timestamp..
        // .. any unanswered questions left (count them)?
        int i, count = 0;
        for (i = 0; i < qna.length; i++)
        {
            if (qna[i].isAnswered())
            {
                count++;
            }
        }

        if (count == qna.length || testCompleted)
        {// NO:  status = 'completed'
            Logger log = Logger.getLogger(LiveTest.class);
            log.info("Assessment completed. Questionnaire:" + questionaire.getPKID() + " UserID:" + assignment.getFkUser());

            assignment.setFkTstStatus("2");
            assignment.setTstStatusDesc("completed");
            assignment.update();
            
            log.info("Going to notify the administrator.");

            notifyAdministrator();
        }
        else
        {// YES: status = 'in progress'
            assignment.update();
        }

    }

    public void notifyAdministrator() throws Exception
    {

        String userId = assignment.getFkUser();
        User user = User.loadById(userId);
        String customerId = user.getFKCustomer();
        Customer customer = new Customer(customerId);
        customer.loadFromDB(true);
        String msgBody = createMessageBody(user, customer, questionaire);
        String msgSubject = "Functional Intelligence Assessment Completed";

        Logger log = Logger.getLogger(LiveTest.class);
        log.info("Going to send account manager email");
        log.info("Sender: Functional Intelligence Registration <no-reply@functionalintelligence.com>");
        log.info("Subject: " + msgSubject);

        if (!(new MailSender()).doPost(
                "Functional Intelligence Assessments <no-reply@functionalintelligence.com>",
                customer.getUser().getEMail(), "", "",
                msgSubject,
                msgBody))
        {
            log.error("Failed to send account manager email");
            log.error("Sender: Functional Intelligence Registration <no-reply@functionalintelligence.com>");
            log.error("Subject: " + msgSubject);
            throw new Exception("Failed to notify administrator.");
        }

    }

    /**
     * Extracts nDoubt (d_<pkid>), timeTaken (t_<pkid>), and answer (a_<pkid>) values from the request
     * parameter map passed to the method. Thereafter, anwers are saved in the global QandA array, the 
     * db is updated, and question pointer incremented.
     * 
     * @param m map of request parameters key:value
     */
    public void processAnswers(Map m)
    {
        Iterator keys = m.keySet().iterator();	// ALL map keys (a_##, t_##, d_##, etc)
        Vector ix = new Vector(iQsPerPg);		// indexes into qna of keys in parameter-map (to commit)
        String key;
        String key_prefix;
        String key_pk;
        int val;								// value to set (see type)
        char type;								// a:answer; t:timetaken; d:ndoubted
        int i;									// index into qna of current parameter

        try
        {
            while (keys.hasNext())
            {
                // parse data and set qna fields
                key = (String) keys.next();
                key_prefix = key.substring(0, 2);

                if (key_prefix.equals("a_"))
                {
                    type = 'a';
                }
                else if (key_prefix.equals("d_"))
                {
                    type = 'd';
                }
                else if (key_prefix.equals("t_"))
                {
                    type = 't';
                }
                else
                {
                    continue;
                }

                key_pk = key.substring(2);
                i = findQuestion(Integer.parseInt(key_pk));
                ix.add(new Integer(i));

                val = Integer.parseInt(((String[]) m.get(key))[0]);

                switch (type)
                {
                    case 'a':
                        qna[i].setAnswer(val);
                        break;
                    case 'd':
                        qna[i].setNDoubted(val);
                        break;
                    case 't':
                        qna[i].setTimetaken(val);
                        break;
                }

                storeAnswers();

            }
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }

    }

    /**
     * Return the next 'iQsPerPg' number of questions for this test randomly.
     * If there are less than the requested number left for this test, then the remaining Questions are returned;
     * if there are none left, null is returned.<br>
     *  
     * @return an array of questions, or null
     * @throws Exception
     */
    public QandA[] getNext()
    {
        int iQCompl = getQCompleted();
        // done with this split?
        // YES: ret null
        if (iQCompl >= iSplitLen)
        {
            return null;
        }

        // NO: cont..

        // ..setup available indexes...
        // ... count unanswered q's
        int i, count = 0;

        for (i = 0; i < qna.length; i++)
        {
            if (!qna[i].isAnswered())
            {
                count++;
            }
        }
        if (count == 0)
        {
            return null;
        }
        else
        {
            indexes = new int[count];
        }

        // ... reset exclusion set
        for (i = 0; i < tmpXIx.length; i++)
        {
            tmpXIx[i] = -1;
        }

        // ... get indexes of all unanswered q's
        count = 0;
        for (i = 0; i < qna.length; i++)
        {
            if (!qna[i].isAnswered())
            {
                indexes[count++] = i;
            }
        }

        // .. get (iQsPerPg) or less random questions (that have not been answered)..
        QandA[] retVal = new QandA[iQsPerPg];
        QandA ret = null;
        for (i = 0; i < retVal.length; i++)
        {
            // don't get more than allowed by this split
            if ((i + iQCompl) >= iSplitLen)
            {
                break;
            }
            ret = randomUnansweredQ();
            if (ret == null)
            {
                break;
            }
            retVal[i] = ret;
        }
        return retVal;
    }

    public Assignment getAssmt()
    {
        return assignment;
    }

    public Questionaire getQre()
    {
        return questionaire;
    }

    /**
     * @return the number of unanswered questions left in this split-set
     */
    public int getQRemaining()
    {
        if (assignment.getFkTstStatus().equals("0") || assignment.getFkTstStatus().equals("1"))
        {
            int ret1 = iSplitLen - getQCompleted();
            int ret2 = getTotQRemaining(); // <-- abnormal split termination 
            return (ret1 < 0) ? ret2 : ret1;
        }
        else
        {
            return 0;
        }
    }

    /**
     * @return the number of anwered questions in this split-set
     */
    public int getQCompleted()
    {
        // count answers with this split-set
        int count = 0;
        if (assignment.getFkTstStatus().equals("0") || assignment.getFkTstStatus().equals("1"))
        {
            for (int i = 0; i < qna.length; i++)
            {
                if (qna[i].getSplitSet() == this.iSplitSet)
                {
                    count++;
                }
            }
        }
        return count;
    }

    public int getTotQRemaining()
    {
        return qna.length - getTotQCompleted();
    }

    public int getTotQCompleted()
    {
        // count stored answers
        int count = 0;
        for (int i = 0; i < qna.length; i++)
        {
            if (qna[i].isStored())
            {
                count++;
            }
        }

        return count;
    }

    public int getSplitSet()
    {
        return this.iSplitSet;
    }

    public int getNSplits()
    {
        return this.iNSplits;
    }

    public int getSplitLen()
    {
        if (assignment.getFkTstStatus().equals("0") || assignment.getFkTstStatus().equals("1"))
        {
            return this.iSplitLen;
        }
        else
        {
            return 0;
        }
    }

    public int getQsPerPg()
    {
        return this.iQsPerPg;
    }

    public int getCoolDownTime()
    {
        return iCooldownTime;
    }

    /**
     * @return time in milliseconds since last split
     * @throws Exception
     */
    public long getElapsedTime() throws Exception
    {

        // last submit?
        DBProxy db = new DBProxy();
        ResultSet res = db.executeQuery(
                "SELECT submitTime, timestamp 'now' as _now "
                + "FROM _Assignment "
                + "WHERE pkid=" + assignment.getPKID());

        long tElapsed = 0;

        if (res.next())
        {
            tElapsed = res.getTimestamp("_now").getTime() - res.getTimestamp("submitTime").getTime();
        }

        db.close();

        return tElapsed;
    }

    /*
     * ---- [ PRIVATE METHODS ] ---->> 
     */
    private void loadQuestions(DBProxy db) throws Exception
    {
        ResultSet res;
        String SQL_allQ, SQL;
        SQL_allQ = // all question id's
        "SELECT DISTINCT qn.pkid "
        + "FROM "
        + "questionaire q, _q_sc_entry qe, super_construct sc, Construct c, question qn "
        + "WHERE "
        + "(q.pkid=" + questionaire.getPKID() + ") AND (qe.fkQ=q.pkid) AND "
        + "(qe.fkSC=sc.pkid) AND (c.fkSC=sc.pkid) AND (qn.fkC=c.pkid) "
        + "EXCEPT ALL "
        + "SELECT DISTINCT qn.pkid "
        + "FROM "
        + "questionaire q, _q_sc_entry qe, super_construct sc, "
        + "_qsce_c_exclude qx, Construct c, question qn "
        + "WHERE "
        + "(q.pkid=" + questionaire.getPKID() + ") AND (qe.fkQ=q.pkid) AND "
        + "(qe.fkSC=sc.pkid) AND (qx.fkQ=q.pkid) AND (qx.fkSC=sc.pkid) AND "
        + "(qx.fkC=c.pkid) AND (c.fkSC=sc.pkid) AND (qn.fkC=c.pkid) ";
        SQL = // all default wordings
        "SELECT fkQn, wording "
        + "FROM Wording w "
        + "WHERE alt=0 AND fkQn IN (" + SQL_allQ + ")";
        // store it
        res = db.executeQuery(SQL);
        int i = 0;
        while (res.next())
        {
            qna[i++] = new QandA(res.getInt("fkQn"), res.getString("wording"));
        }

        // look for alternative wordings?
        if (!questionaire.getWording().equals("0"))
        {
            SQL =
            "SELECT fkQn, wording "
            + "FROM Wording w "
            + "WHERE alt=" + questionaire.getWording() + " AND fkQn IN (" + SQL_allQ + ")";

            res = db.executeQuery(SQL);

            int pkid;
            while (res.next())
            {
                pkid = res.getInt("fkQn");
                // replace wording of question with same pkid
                for (i = 0; i <= qna.length; i++)
                {
                    if (qna[i].getPKID() == pkid)
                    { // found: replace & stop!
                        qna[i].setWording(res.getString("wording"));
                        break;
                    }
                }
            }

        }// end-alt wording

        //db.close();

    }

    private void loadAnswers(DBProxy db) throws Exception
    {
        String SQL;
        // load corresponding answers, if any ..
        SQL =
        "SELECT fkQn, splitSet "
        + "FROM _Answer "
        + "WHERE "
        + "fkAssmt=" + assignment.getPKID() + " AND "
        + "fkQn IN (";
        // .. loaded question pk's
        int i;
        for (i = 0; i < qna.length - 1; i++)
        {
            SQL += qna[i].getPKID() + ",";
        }
        SQL += qna[qna.length - 1].getPKID();
        SQL += ")";


        ResultSet res = db.executeQuery(SQL);
        // set 'isStored' flag for loaded questions.
        i = 0;
        int count = 0;
        while (res.next())
        {
            i = findQuestion(res.getInt("fkQn"));
            qna[i].setStoredFlag(true);
            // dummy info.. (isAnswered()..)
            qna[i].setAnswer(999);
            qna[i].setNDoubted(999);
            qna[i].setTimetaken(999);
            // split
            qna[i].setSplitSet(res.getInt("splitSet"));

            count++;
        }

        //db.close()
    }

    private void storeAnswers() throws Exception
    {
        Logger log = Logger.getLogger(LiveTest.class);

        // commit the unsaved answers to db..
        DBProxy db = new DBProxy();

        try
        {
            String SQL_insert =
                   "INSERT INTO _Answer (fkQn, fkAssmt, answer, timeTaken, nDoubted, splitSet) "
                   + "VALUES (";
            for (int i = 0; i < qna.length; i++)
            {
                if (qna[i].isAnswered() && !qna[i].isStored())
                {
                    // .. store
                    db.executeNonQuery(
                            SQL_insert
                            + qna[i].getPKID() + ", "
                            + assignment.getPKID() + ", "
                            + qna[i].getAnswer() + ", "
                            + qna[i].getTimetaken() + ", "
                            + qna[i].getNDoubted() + ", "
                            + iSplitSet + ")");
                    // .. set flag
                    qna[i].setStoredFlag(true);
                    // .. split (this one)
                    qna[i].setSplitSet(this.iSplitSet);
                }
            }
        }
        catch (Exception ex)
        {
            log.error("Failed to store answers. Assignment PKID: " + assignment.getPKID() + " Exception: " + ex.toString());
            throw ex;
        }
        finally
        {
            db.close();
        }
    }

    private int findQuestion(int pkid)
    {
        // look for the question and return
        for (int i = 0; i <= qna.length; i++)
        {
            if (qna[i].getPKID() == pkid)
            {
                return i;
            }
        }
        return -1;
    }

    private QandA randomUnansweredQ()
    {
        // infinite loop check (number of exclusions == number of available)
        int i, count = 0;
        for (i = 0; i < tmpXIx.length; i++)
        {
            if (tmpXIx[i] == -1)
            {
                break;
            }
            else
            {
                count++;
            }
        }
        if (count == indexes.length)
        {
            return null;
        }

        int retIndex = -1;	// index [qna] of question to return
        /*
        // count unanswered q's
        for(i=0; i< qna	.length; i++)
        if(!qna[i].isAnswered()) count++;
        if(count==0) return null;
        else indexes = new int[count];
        
        // get indexes of all unanswered q's
        count=0;
        for(i=0; i < qna.length; i++)
        if(!qna[i].isAnswered()) indexes[count++] = i;*/

        // set retIndex (reset until retIndex not in exclusion set tmpXIx[])
        boolean isExclusive = false;

        XSEARCH:
        while (!isExclusive)
        {
            retIndex = indexes[(int) Math.floor(Math.random() * indexes.length)];
            // check for exclusion
            for (i = 0; i < tmpXIx.length; i++)
            {
                if (tmpXIx[i] == retIndex)	// found: not exclusive
                {
                    continue XSEARCH;
                }
                else if (tmpXIx[i] == -1)	// no more left to search
                {
                    break;
                }
            }

            isExclusive = true;
        }

        // add retIndex to exclusion list
        for (i = tmpXIx.length - 1; i >= 0; i--)
        {
            if ((i > 0 && tmpXIx[i - 1] != -1) || (i == 0 && tmpXIx[i] == -1))
            {
                tmpXIx[i] = retIndex;
                break;
            }
        }

        // return random unanswered Q
        return qna[retIndex];
    }

    private String createMessageBody(User user, Customer customer, Questionaire questionnaire)
    {
        return "PLEASE DO NOT REPLY TO THIS MESSAGE\n"
               + "- - - - - - - - - - - - - - - - - -\n"
               + "\n"
               + "Hello " + customer.getUser().getFullName()
               + " (" + customer.getUser().getUserName() + "),\n"
               + "\n"
               + "This is an automated response to inform you that a candidate " + user.getFullName() + " completed "
               + "the " + questionnaire.getName() + " assessment.\n"
               + "\n"
               + "http://www.functionalintelligence.com/\n"
               + "\n"
               + "Thank You.\n"
               + "\n"
               + "[ FQ Global Limited. ]\n"
               + "- \"...helping you reach your true potential!\""
               + "\n\n"
               + "- - -\nvisit our website at www.functionalintelligence.com\n\n";
    }
}
