package project;

/**
 * 
 * Handles the interaction between the site and the admin.
 *
 */
public class Admin {
	/**
	 * The id of the asmin.
	 */
	String id;
	
	/**
	 * Gets the admin from the database
	 * @param x a string of the primary key of the admin.
	 */
	public Admin(String x) {
		id = x;
	}
	
	/**
	 * Gets the admin as a string value.
	 * @return The admin as a string value.
	 */
	@Override
	public String toString() {
		return "User Information:\n\nUser ID:  "+id;
	}
}
