package beans;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import database.Contributor;
import database.Database;

/**
 * Model for the DB's Contributors table, used to retrieve 0..n rows of contributors for a single Game.
 */
public class ContributorTableBean implements Serializable{

	private static final long serialVersionUID = 1L;
	private ArrayList<Contributor> contributors = new ArrayList<Contributor>();
	
	/**
	 * Fetch the contributors for the specified game from the DB and instantiate a ContributorTableBean with them.
	 * @param GamePKey the id of the game to get contributors for from Contributors table.
	 */
	public ContributorTableBean(String GamePKey)
	{
		List<Map<String, Object>> query = Database.executeQuery("SELECT * FROM Contributors WHERE GamePKey=" + GamePKey);
		//query looks like: [{AccountPKey=4, GamePKey=1, RolePKey=1}, {AccountPKey=3, GamePKey=1, RolePKey=5}]
        java.util.ListIterator<Map<String, Object>> litr = query.listIterator();
        while(litr.hasNext())
        {
        	Map<String, Object> temp = litr.next();
        	String a = temp.get("AccountPKey").toString();
        	String g = temp.get("GamePKey").toString();
        	String r = temp.get("RolePKey").toString();
        	contributors.add(new Contributor(a, g, r));
        }
	}
	
	// Bean getter / setter
	public ArrayList<Contributor> getContributors(){
		return contributors;
	}
	public void setContributors(ArrayList<Contributor> contributors) {
		this.contributors = contributors;
	}

}