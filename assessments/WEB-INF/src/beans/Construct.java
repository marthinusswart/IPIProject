/* Construct.java
 * 
 * Created on 03-Aug-2005
 */
package beans;


/**
 * 
 * @author psnel
 */
public class Construct
{

    private static final int MAX_ANS = 30;		// maximum number of questions/answers per construct
    private static final int ANS_RANGE = 7;		// raw answers : 0..ANS_RANGE
    private static final double ANS_INC = 16.666666;		// scaled answers are : n*ANS_INC <= 100 [0 <= n <= 6]
    private static final int EMPTY = -1;		// empty array cell
    private String name;						// Construct name
    private int PKID;						// Construct pkid
    private int fkSC;						// fk to super-construct
    private boolean isPositive;					// pos/neg  ..
    private boolean isNeutral;					// .. or neutral Construct?
    private double[] scaledAnswers = new double[MAX_ANS];            // set of computed answers for a construct

    public Construct(String name, int pkid, int fksc, boolean isPositive, boolean isNeutral)
    {
        initAnswers();
        this.name = name;
        this.PKID = pkid;
        this.isPositive = isPositive;
        this.isNeutral = isNeutral;
        this.fkSC = fksc;
    }

    public void addAnswer(QandA ans) throws Exception
    {
        if (scaledAnswers[MAX_ANS - 1] != EMPTY)
        {
            throw new Exception("Cannot add more answers to this Construct");
        }

        // save scaled answer in 1st available spot > -1
        for (int i = 0; i < MAX_ANS; i++)
        {
            if (scaledAnswers[i] == EMPTY)
            {
                // add scaled answer
                scaledAnswers[i] = (ans.isInverted())
                                   ? (ANS_RANGE - ans.getAnswer()) * ANS_INC
                                   : (ans.getAnswer() - 1) * ANS_INC;
                return;
            }
        }
    }

    public int computeTotal()
    {
        int total = 0;
        int i;
        for (i = 0; i < MAX_ANS; i++)
        {
            if (scaledAnswers[i] != EMPTY)
            {
                total += scaledAnswers[i];
            }
            else
            {
                break;
            }
        }

        // return avg of sum total
        return Math.round((float) total / (float) i);
    }

    /**
     * @return Returns the fkSC.
     */
    public int getFkSC()
    {
        return fkSC;
    }

    /**
     * @return Returns the name.
     */
    public String getName()
    {
        return name;
    }

    /**
     * @return Returns the pKID.
     */
    public int getPKID()
    {
        return PKID;
    }

    /**
     * @return Returns the isNeutral.
     */
    public boolean isNeutral()
    {
        return isNeutral;
    }

    /**
     * @return Returns the isPositive.
     */
    public boolean isPositive()
    {
        return isPositive;
    }

    /**
     * @param fkSC The fkSC to set.
     */
    public void setFkSC(int fkSC)
    {
        this.fkSC = fkSC;
    }

    private void initAnswers()
    {
        for (int i = 0; i < MAX_ANS; i++)
        {
            scaledAnswers[i] = EMPTY;
        }
    }

}
