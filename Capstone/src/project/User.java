package project;

public class User {

	String id;
	protected int permissionNumber;
	
	public User(String x) {
		
		permissionNumber = 2;
		id = x;
	}
	
	public int getPermission() {
		return permissionNumber;
	}
	
	@Override
	public String toString() {
		return "User Information:\n\nUser ID:  "+id;
	}
	
}
