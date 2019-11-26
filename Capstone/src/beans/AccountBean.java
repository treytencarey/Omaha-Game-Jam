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
