package beans;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import database.Database;
import exceptions.EmptyQueryException;

/**
 * Model for the DB's Accounts table, used to retrieve 1 row for a single Account. Does not retrieve password.
 */
public class AccountBean implements Serializable {
	private static final long serialVersionUID = 1L;
	private String id, email;
	
	/**
	 * Gets an account from the database.
	 * @param PKey an integer value of the account's primary key.
	 */
	public AccountBean(String PKey) throws EmptyQueryException
	{
		String query = "SELECT PKey, Email FROM Accounts WHERE PKey=" + PKey;
		List<Map<String, Object>> result = Database.executeQuery(query);
		
		if (result.size() == 0)
			throw new EmptyQueryException(query);
		Map<String, Object> account = result.get(0);
		
		this.setId(PKey);
		this.setEmail(account.get("Email").toString());
	}
	
	public boolean isAdmin()
	{	
		List<Map<String, Object>> results = Database.executeQuery("SELECT COUNT(*) FROM Admins WHERE AccountPKey=" + this.getId());
		if (results.size() == 0) // Error contacting DB?
			throw new NullPointerException();
		String count = results.get(0).get("COUNT(*)").toString();
		return count.equals("1"); // Since there's a unique constraint, there can only be 1 row at most
	}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	
}
