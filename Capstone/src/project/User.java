package project;

public class User {

	String id;
	
	public User(String x) {
		
		id = x;
	}
	
	@Override
	public String toString() {
		return "User Information:\n\nUser ID:  "+id;
	}
}
