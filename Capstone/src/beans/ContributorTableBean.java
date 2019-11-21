package beans;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Iterator;
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
	 * Instantiate a blank ContributerBeanTable. Call fillByGame() or fillByAccount() to fill it up.
	 */
	public ContributorTableBean() {	}
	
	/**
	 * Fetch the contributors for the specified game from the DB and store in contributors.
	 * @param GamePKey the id of the game to get contributors for from Contributors table.
	 * @return the number of rows fetched.
	 */
	public int fillByGame(String GamePKey) { return fillByQuery("SELECT * FROM Contributors WHERE GamePKey=" + GamePKey); }
	
	/**
	 * Fetch the contributors for the specified account from the DB and store in contributors.
	 * @param AccountPKey the id of the account to get contributors for from Contributors table.
	 * @return the number of rows fetched.
	 */
	public int fillByAccount(String AccountPKey) { return fillByQuery("SELECT * FROM Contributors WHERE AccountPKey=" + AccountPKey); }
	
	/**
	 * Execute the query and use the results to fill the contributors ArrayList.
	 * @param query The query to execute with Database.executeQuery()
	 * @return The number of hits.
	 */
	public int fillByQuery(String query)
	{
		List<Map<String, Object>> results = Database.executeQuery(query);
//		fillFromResults(results);
		//query looks like: [{AccountPKey=4, GamePKey=1, RolePKey=1}, {AccountPKey=3, GamePKey=1, RolePKey=5}]
        java.util.ListIterator<Map<String, Object>> litr = results.listIterator();
        while(litr.hasNext())
        {
        	Map<String, Object> temp = litr.next();
        	String a = temp.get("AccountPKey").toString();
        	String g = temp.get("GamePKey").toString();
        	String r = temp.get("RolePKey").toString();
        	contributors.add(new Contributor(a, g, r));
        }
        return results.size();
	}
	
	// Bean getter / setter
	public ArrayList<Contributor> getContributors(){
		return contributors;
	}
	public void setContributors(ArrayList<Contributor> contributors) {
		this.contributors = contributors;
	}
	
	/**
	 * Returns the GamePKey of the current contributors as an ArrayList<String>.
	 * @return The GamePKeys of the currents contributors.
	 */
	public ArrayList<String> getGameIds()
	{
		Iterator<Contributor> i = this.getContributors().iterator();
		ArrayList<String> result = new ArrayList<String>();
		while (i.hasNext())
			result.add(i.next().getGamePKey());
		return result;
	}
	
//	/**
//	 * Take the results from a query and fill the contributors ArrayList.
//	 * @param results The results returned from a Database.executeQuery()
//	 */
//	private void fillFromResults(List<Map<String, Object>> results)
//	{
//
//	}

}