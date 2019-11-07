package database;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

// Used to interface with the Role table
public class RoleTableInterface implements Serializable{

	private static final long serialVersionUID = 1L;
	private String title;
	
	public RoleTableInterface(String PKey)
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