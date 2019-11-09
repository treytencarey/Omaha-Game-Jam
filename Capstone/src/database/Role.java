package database;

// Represents a row in the Role table
public class Role {
	public String PKey, Title;
	public Role(String PKey, String Title)
	{
		this.PKey = PKey;
		this.Title = Title;
	}
}
