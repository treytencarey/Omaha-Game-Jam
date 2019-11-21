package beans;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import database.Contributor;
import database.Database;

/**
 * Model for the DB's Games table, used to retrieve 0..n rows of games for a single event.
 */
public class GameTableBean implements Serializable {

	private static final long serialVersionUID = 1L;
	private ArrayList<GameBean> games = new ArrayList<GameBean>();
	
	/**
	 * Instantiate a blank GameTableBean.
	 */
	public GameTableBean() { }
	
	/**
	 * Execute the query and use the results to fill the contributors ArrayList. Access them with getGames()
	 * @param query The query to execute with Database.executeQuery()
	 * @return The number of hits.
	 */
	public int fillByQuery(String query)
	{
		List<Map<String, Object>> results = Database.executeQuery(query);
        java.util.ListIterator<Map<String, Object>> litr = results.listIterator();
        while(litr.hasNext())
        	games.add(new GameBean(litr.next()));
        return results.size();
	}
	
	/**
	 * Fetch the games for the specified event from the DB's Games table. Access these with getGames()
	 * @param EventPKey the id of the event to get games for.
	 */
	public int fillByEvent(String EventPKey) { return fillByQuery("SELECT * FROM Games WHERE EventPKey=" + EventPKey); }
	
	/**
	 * Fetch all games specified by ID from the DB's Games table. Access these with getGames()
	 * @param EventPKey the id of the event to get games for.
	 */
	public int fillByIds(String ...ids)
	{
		String query = "SELECT * FROM Games WHERE PKey=" + String.join(" OR PKey=", ids);
		return this.fillByQuery(query);
	}
	
	// Bean getter / setter
	public ArrayList<GameBean> getGames(){
		return games;
	}
	public void setGames(ArrayList<GameBean> games) {
		this.games = games;
	}

}
