package database;

/**
 * Represents a single row from the Rows table. This does not interact with the DB in any way.
 */
public class Role {
	public String PKey, Title;
	public Role(String PKey, String Title)
	{
		this.PKey = PKey;
		this.Title = Title;
	}
}
