package beans;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import database.Database;

/**
 * Model for the DB's Games table, used to retrieve 0..n rows of games for a single event.
 */
public class GameTableBean implements Serializable {

	private static final long serialVersionUID = 1L;
	private ArrayList<GameBean> games = new ArrayList<GameBean>();
	
	/**
	 * Fetch the games for the specified event from the DB's Games table and instantiate a GameTableBean with them.
	 * @param EventPKey the id of the event to get games for.
	 */
	public GameTableBean(String EventPKey)
	{
		List<Map<String, Object>> query = Database.executeQuery("SELECT * FROM Games WHERE EventPKey=" + EventPKey);
        java.util.ListIterator<Map<String, Object>> litr = query.listIterator();
        while(litr.hasNext())
        	games.add(new GameBean(litr.next()));
	}
	
	// Bean getter / setter
	public ArrayList<GameBean> getGames(){
		return games;
	}
	public void setGames(ArrayList<GameBean> games) {
		this.games = games;
	}

}
