package beans;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import database.Database;

/**
 * Model for the DB's Roles table, used to retrieve a single row when given a Role's ID.
 */
public class RoleTableBean implements Serializable{

	private static final long serialVersionUID = 1L;
	private String title;
	
	/**
	 * Fetch the specified role from the DB and instantiate a RoleTableBean with its data.
	 * @param PKey the id of the role to fetch from Roles table.
	 */
	public RoleTableBean(String PKey)
	{
		List<Map<String, Object>> query = Database.executeQuery("SELECT * FROM Roles WHERE PKey=" + PKey);
		if (query.size() == 0)
			throw new NullPointerException();
		title = query.get(0).get("Title").toString();
	}
	
	public String getTitle(){
		return title;
	}

}