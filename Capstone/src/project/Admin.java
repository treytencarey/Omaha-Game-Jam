package project;

public class Admin extends User {

	public Admin(String x) {
		super(x);
		permissionNumber = 1;
	}
	
	public void setUserPermissions(String id, int pernum) {
		//Set account permissions of id to pernum
	}
}
