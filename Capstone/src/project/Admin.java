package project;

import database.Database;

public class Admin extends User {

	public Admin(String x) {
		super(x);
	}
	
	public void setUserPermissions(String id, int pernum) {
		Database.executeUpdate("UPDATE AccountPermissions SET Permissions = " + pernum + " WHERE PKey = " + id);
	}
}
