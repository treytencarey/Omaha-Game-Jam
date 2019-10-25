package project;

public class Admin {

	String id;
	
	public Admin(String x) {
		id = x;
	}
	
	@Override
	public String toString() {
		return "User Information:\n\nUser ID:  "+id;
	}
}
