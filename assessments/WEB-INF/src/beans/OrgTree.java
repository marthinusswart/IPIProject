/* OrgTree.java
 * 
 * Created on 19-Oct-2005
 */
package beans;

import java.sql.ResultSet;
import java.util.Enumeration;
import java.util.Vector;

/**
 * This class represents the organigational hierarchy of a customer. Each node has a Customer object representing
 * that department and a Vector of Customer objects representing the departments on the level below that node.
 * 
 * @author psnel (Dot-Ellipses IT Solutions cc)
 *
 */
public class OrgTree {
    
    private Customer	node;			// the customer on this level of the hierarchy
    private Vector		children=null;	// list of child nodes (OrgTree's), i.e. departments underneath this one 
    
    public OrgTree(Customer node){
        this.node	= node;
    }
    
    private static ResultSet _res;		// special resultset used in recursive db queries in buildChildren()
    
    /**
     * Checks the root node and builds
     * 
     * @throws Exception
     */
    public void buildTree() throws Exception{
        // check root
        if(node==null || node.getPKID()==null) throw new Exception("No root node specified");
        // check root exists
        DBProxy db = new DBProxy();
        
        try{
            OrgTree.buildChildren(this, db);
        }catch(Exception e){
            throw e;
        }finally{
            db.close();
            _res = null;
        }
    }
    
    
    /**
     * Recursive helper method for buildTree(). Takes an OrgTree node and DBProxy, and recursively queries
     * the db whilst constructing the tree.
     * 
     * @param db - db connection used in recursively querying the db
     * @throws Exception
     */
    private static void buildChildren(OrgTree tNode, DBProxy db) throws Exception{
        // get children for 'node'
        _res = db.executeQuery(
                "SELECT pkid, name, credits, code, isdisabled " +
        		"FROM Customer WHERE fkparentcust="+tNode.getNode().getPKID()+
        		" ORDER BY name");
        
        while(_res.next())
            tNode.addChild(new Customer(
                    _res.getString("pkid"),
                    _res.getString("name"),
                    _res.getInt("credits"),
                    _res.getString("code"),
                    tNode.getNode().getLevel()+1,
                    _res.getBoolean("isdisabled")));
        
        OrgTree otChild=null;

		if(tNode.children != null)
        for(Enumeration e = tNode.children.elements(); e.hasMoreElements(); )
            // RECURSIVE CALL =>
            OrgTree.buildChildren((OrgTree)e.nextElement(), db);
    }
    
    
    /**
     * Walk the tree and build (adn return) an HTML string for output onto a web page.
     * 
     * Pre: requires the following predefined styles in the CSS namespace of the output page, for the tree
     *      to display correctly:-
     * .subtreeHIDE{display: none; margin-left:30px;}
     * .subtreeSHOW{display: block;	margin-left:30px;}
     * 
     * , also the following images are required in the specified paths:-
     * images/EDTreeView/leaf.gif
     * images/EDTreeView/minus.gif
     * images/EDTreeView/plus.gif
     * 
     * @return and HTML string that is in the format expected by the CEDTreeView.js script
     */
    public StringBuilder htmlString(){
       
        StringBuilder sbHTML = new StringBuilder();
        
        // create htmlString for this node, recurring into its subtree before continuing to the next..
        if(children==null){		// leaf node
            // .. current node
            sbHTML.append("<div>\n<img src=\"images/EDTreeView/leaf.gif\"> ");
            sbHTML.append("<input onclick=\"selectedNodeVal=this.value;disableToggle=true\" type='radio' name=\"org\" value=\""+node.getPKID()+"\" "+((node.getLevel()==0)?"checked":"")+"> ");

            if (node.isDisabled())
            {
                sbHTML.append("<span class='nodeDisabled'>"+node.getName()+" *"+"</span>");
            }
            else
            {
                sbHTML.append(node.getName());
            }

            sbHTML.append("<div class='nodeCmd'>[ code:"+node.getCode()+" | credit:"+node.getCredits()+" ]</div></div>\n");
        }else{					// non-leaf node: subtree
            // .. current node
            sbHTML.append("<div onclick=\"Toggle(this)\">\n<img src=\"images/EDTreeView/plus.gif\"> ");
            sbHTML.append("<input onclick=\"selectedNodeVal=this.value;disableToggle=true\" type='radio' name=\"org\" value=\""+node.getPKID()+"\" "+((node.getLevel()==0)?"checked":"")+"> ");
            
            if (node.isDisabled())
            {
                sbHTML.append("<span class='nodeDisabled'>"+node.getName()+" *"+"</span>");
            }
            else
            {
                sbHTML.append(node.getName());
            }
            
            sbHTML.append("<div class='nodeCmd'>[ code:"+node.getCode()+" | credit:"+node.getCredits()+" ]</div></div>\n");
            
            // .. build subtree
            sbHTML.append("<div class='subtreeHIDE'>");
            for(Enumeration e = children.elements(); e.hasMoreElements();){
                sbHTML.append( ((OrgTree) e.nextElement()).htmlString() ); // <-- recursive call
            }
            sbHTML.append("</div>\n");
        }
                
        return sbHTML;
    }
    
    //private static StringBuffer
    
    public void addChild(Customer child){
        if (children==null) children = new Vector(5,5);
        children.add(new OrgTree(child));
    }
    
    /**
     * @return Returns the node.
     */
    public Customer getNode() {
        return node;
    }
    /**
     * @param node The node to set.
     */
    public void setNode(Customer node) {
        this.node = node;
    }
    /**
     * @return Returns the OrgTree [] array of child nodes.
     */
    public OrgTree[] getChildren() {     
        return (OrgTree[]) children.toArray();
    }
}
