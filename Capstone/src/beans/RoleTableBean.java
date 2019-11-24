package beans;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import database.Contributor;
import database.Database;
import database.Role;
import exceptions.EmptyQueryException;

/**
 * Model for the DB's Roles table, used to retrieve a single row when given a Role's ID.
 */
public class RoleTableBean implements Serializable{

	private static final long serialVersionUID = 1L;
	private String title;
	private ArrayList<Role> roles = new ArrayList<Role>();
	
	/**
	 * Instantiate a blank RoleTableBean.
	 */
	public RoleTableBean() { }

	/**
	 * @deprecated
	 */
	public RoleTableBean(String id) { this.fillByIds(id); }
	
	/**
	 * @deprecated
	 */
	public String getTitle() { return roles.get(0).Title; }
	
	/**
	 * Fetch all games specified by ID from the DB's Games table. Access these with getGames()
	 * @param EventPKey the id of the event to get games for.
	 */
	public int fillByIds(String ...ids)
	{
		String query = "SELECT * FROM Roles WHERE PKey=" + String.join(" OR PKey=", ids);
		return this.fillByQuery(query);
	}
	
	/**
	 * Execute the query and use the results to fill the roles ArrayList.
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
        	String id = temp.get("PKey").toString();
        	String t = temp.get("Title").toString();
        	roles.add(new Role(id, t));
        }
        return results.size();
	}
	
	/**
	 * Returns the Title associated with the ID
	 * @param id The ID whose title we want.
	 * @return The Title associated with the ID.
	 */
	public String getTitle(String id)
	{
		for (Role r : roles)
		{
			if (r.PKey.equals(id))
				return r.Title;
		}
		System.out.println("Role title not found. Printed from RoleTableBean.");
		return "Role title not found";
	}
	

}