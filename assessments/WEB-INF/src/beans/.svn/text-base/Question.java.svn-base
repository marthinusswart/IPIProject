/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package beans;

import java.sql.ResultSet;
import java.util.Vector;

/**
 *
 * @author mswart
 */
public class Question
{

    private String _pkid;
    private String _fkc;
    private String _order;
    private boolean _isInverted;
    private String _wording;
    private String _altWording;
    private boolean _wasLoaded = false;
    private boolean _hasAltWording = false;

    public String getAltWording()
    {
        return _altWording;
    }

    public String getAltWordingFormatted()
    {
        if (_altWording != null)
        {
            return _altWording.replaceAll("'", "''");
        }
        else
        {
            return null;
        }
    }

    public void setAltWording(String altWording)
    {
        if (altWording != null && altWording.equals(""))
        {
            _altWording = null;
        }
        else
        {
            if (altWording != null)
            {
                _altWording = altWording.replaceAll("\\n", "");
                _altWording = _altWording.replaceAll("\\r", "");
            }
            else
            {
                _altWording = altWording;
            }
        }
    }

    public String getFKC()
    {
        return _fkc;
    }

    public void setFKC(String fkc)
    {
        this._fkc = fkc;
    }

    public boolean isInverted()
    {
        return _isInverted;
    }

    public void setIsInverted(boolean isInverted)
    {
        this._isInverted = isInverted;
    }

    public String getOrder()
    {
        return _order;
    }

    public void setOrder(String order)
    {
        this._order = order;
    }

    public String getPKID()
    {
        return _pkid;
    }

    public void setPKID(String pkid)
    {
        this._pkid = pkid;
    }

    public boolean wasLoaded()
    {
        return _wasLoaded;
    }

    public void setWasLoaded(boolean wasLoaded)
    {
        this._wasLoaded = wasLoaded;
    }

    public boolean hasAltWording()
    {
        return _hasAltWording;
    }

    public void setHasAltWording(boolean value)
    {
        _hasAltWording = value;
    }

    public String getWording()
    {
        return _wording;
    }

    public String getWordingFormatted()
    {
        if (_wording != null)
        {
            return _wording.replaceAll("'", "''");
        }
        else
        {
            return null;
        }
    }

    public void setWording(String wording)
    {
        if (wording != null)
        {
            this._wording = wording.replaceAll("\\n", "");
            this._wording = _wording.replaceAll("\\r", "");
        }
        else
        {
            _wording = wording;
        }
    }

    public Question()
    {
    }

    public Question(String pkid)
    {
        _pkid = pkid;
    }

    public Question(String pkid, String fkc,
                    String order, String wording, String altWording,
                    boolean isInverted)
    {
        _pkid = pkid;
        _fkc = fkc;
        _order = order;
        setWording(wording);
        setAltWording(altWording);
        _isInverted = isInverted;
    }

    public void loadFromDB() throws Exception
    {
        DBProxy db = new DBProxy();
        String sqlQuestion = "SELECT * FROM question, wording "
                             + "WHERE question.pkid=" + getPKID() + " "
                             + "AND wording.fkqn=question.pkid";
        ResultSet rsQuestion = null;

        try
        {
            rsQuestion = db.executeQuery(sqlQuestion);

            int counter = 1;
            while (rsQuestion.next())
            {
                if (counter == 1)
                {
                    setFKC(rsQuestion.getString("fkc"));
                    setOrder(rsQuestion.getString("corder"));
                    setIsInverted(rsQuestion.getBoolean("isinverted"));
                    setWording(rsQuestion.getString("wording"));
                    counter++;
                }
                else
                {
                    setAltWording(rsQuestion.getString("wording"));
                    counter = 1;
                }
            }

            setWasLoaded(true);
            setHasAltWording(getAltWording() != null);
        }
        catch (Exception ex)
        {
            throw new Exception("SQL: " + sqlQuestion + " - Exception: " + ex.getMessage());
        }
        finally
        {
            db.close();
        }
    }

    public void saveToDB() throws Exception
    {
        if (wasLoaded())
        {
            update();
        }
    }

    private void update() throws Exception
    {
        DBProxy db = new DBProxy();
        String sql = null;

        try
        {
            sql = "UPDATE question SET fkc=" + getFKC() + ", "
                  + "corder=" + getOrder() + ", isinverted=" + isInverted() + " "
                  + "WHERE pkid=" + getPKID();
            db.executeNonQuery(sql);

            sql = "UPDATE wording SET wording='" + getWordingFormatted() + "' "
                  + "WHERE fkqn=" + getPKID() + " AND alt=0";

            db.executeNonQuery(sql);

            if (hasAltWording())
            {
                updateAltWording();
            }
            else if (getAltWording() != null)
            {
                insertAltWording();
            }

        }
        catch (Exception ex)
        {
            throw new Exception("SQL: " + sql + " - Exception: " + ex.getMessage());
        }
        finally
        {
            db.close();
        }
    }

    private void updateAltWording() throws Exception
    {
        String sqlAltWording = "";
        DBProxy db = new DBProxy();

        try
        {
            if (_altWording != null)
            {
                sqlAltWording = "UPDATE wording SET wording='" + getAltWordingFormatted() + "' "
                                + "WHERE fkqn=" + getPKID() + " AND alt=1";
                db.executeNonQuery(sqlAltWording);
            }
            else
            {
                sqlAltWording = "DELETE FROM wording "
                                + "WHERE fkqn=" + getPKID() + " AND alt=1";
                db.executeNonQuery(sqlAltWording);
            }
        }
        catch (Exception ex)
        {
            throw new Exception("SQL: " + sqlAltWording + " - Exception: " + ex.getMessage());
        }
        finally
        {
            db.close();
        }
    }

    private void insertAltWording() throws Exception
    {
        String sqlAltWording = "";
        DBProxy db = new DBProxy();

        try
        {
            sqlAltWording = "INSERT INTO wording (fkqn, alt, wording) VALUES (" + getPKID() + ", 1, '" + getAltWordingFormatted() + "')";
            db.executeNonQuery(sqlAltWording);
            setHasAltWording(true);
        }
        catch (Exception ex)
        {
            throw new Exception("SQL: " + sqlAltWording + " - Exception: " + ex.getMessage());
        }
        finally
        {
            db.close();
        }
    }

    public static Question[] getQuestions(String constructId) throws Exception
    {
        DBProxy db = new DBProxy();
        Vector questions = new Vector();
        String sql = "SELECT * FROM question, wording "
                     + "WHERE question.fkc=" + constructId + " "
                     + "AND wording.fkqn=question.pkid ORDER BY fkc,corder";

        try
        {
            ResultSet rs = db.executeQuery(sql);
            int counter = 1;
            String pkid = null;
            Question question = null;

            while (rs.next())
            {
                String newPkid = rs.getString("pkid");
                boolean normal = true;
                if (pkid != null)
                {
                    if (newPkid.equals(pkid))
                    {
                        normal = false;
                    }
                }

                if (normal)
                {
                    question = new Question(
                            rs.getString("pkid"),
                            rs.getString("fkc"),
                            rs.getString("corder"),
                            rs.getString("wording"),
                            null,
                            rs.getBoolean("isinverted"));
                    questions.add(question);

                    pkid = rs.getString("pkid");
                }
                else
                {
                    question.setAltWording(rs.getString("wording"));
                    pkid = null;
                }
            }
        }
        catch (Exception ex)
        {
            throw new Exception("SQL: " + sql + " - Exception: " + ex.getMessage());
        }
        finally
        {
            db.close();
        }

        Question[] questionsArray = new Question[questions.size()];
        for (int i = 0; i < questions.size(); i++)
        {
            questionsArray[i] = (Question) questions.get(i);
        }
        return questionsArray;
    }
}
