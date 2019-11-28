package beans;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import database.Database;
import exceptions.EmptyQueryException;
import exceptions.UnsuccessfulUpdateException;

/**
 * Model for the DB's Profiles table, used to retrieve 1 row for a single Profile.
 */
public class ProfileBean implements Serializable{

	private static final long serialVersionUID = 1L;
	
	/**
	 * The PKey of the account.
	 */
	private String id;
	/**
	 * The name of the profile.
	 */
	private String name;
	/**
	 * The bio of the profile.
	 */
	private String bio;
	/**
	 * The website of the profile.
	 */
	private String website;
	/**
	 * The skills of the profile.
	 */
	private String skills;
	private String status;
	
	/**
	 * Query the database for the status of the profile for AccountPKey of id.
	 * @param id AccountPKey of desired profile
	 * @return status of profile
	 * @throws EmptyQueryException 
	 */
	public static String queryStatus(String id) throws EmptyQueryException
	{
		String qstr = "SELECT Status FROM Profiles WHERE AccountPKey=" + id;
		List<Map<String, Object>> query = Database.executeQuery(qstr);
		if (query.size() == 0)
			throw new EmptyQueryException(qstr);
		return query.get(0).get("Status").toString();
	}
	
	
	/**
	 * Gets a profile from the database.
	 * @param PKey an integer value of the profile's primary key.
	 */
	public ProfileBean(String PKey) throws EmptyQueryException
	{
		String qstr = "SELECT * FROM Profiles WHERE AccountPKey=" + PKey;
		List<Map<String, Object>> query = Database.executeQuery(qstr);
		
		if (query.size() == 0)
			throw new EmptyQueryException(qstr);
		Map<String, Object> account = query.get(0);
		
		this.setId(PKey);
		this.setName(account.get("Name").toString());
		this.setBio(account.get("Bio").toString());
		this.setWebsite(account.get("Website").toString());
		this.setSkills(account.get("SkillsList").toString());
		this.setStatus(account.get("Status").toString());
	}
	
	/**
	 * Gets a profile based on the given values.
	 * @param name a string of the name of the account (email/username).
	 * @param bio a string of the profile's bio.
	 * @param website a string of the profile's website.
	 * @param skills a string of the profile's skills.
	 */
	public ProfileBean(String id, String name, String bio, String website, String skills, String status)
	{
		this.setId(id);
		this.setName(name);
		this.setBio(bio);
		this.setWebsite(website);
		this.setSkills(skills);
		this.setStatus(status);
	}
	
	/**
	 * Gets a blank profile.
	 */
	public ProfileBean() {
		this("", "", "", "", "", "");
	}
	
	/**
	 * Updates the profile in the database with the given primary key to the values of the profile.
	 * @param PKey an integer value of the profile's primary key.
	 * @throws UnsuccessfulUpdateException 
	 */
	public void writeChanges() throws UnsuccessfulUpdateException
	{
		String query = String.format("INSERT OR REPLACE INTO Profiles (AccountPKey, Name, Bio, Website, SkillsList, Status) VALUES (%s, '%s', '%s', '%s', '%s', '%s');",
				this.getId(), this.getName(), this.getBio(), this.getWebsite(), this.getSkills(), this.getStatus());
		String message = Database.executeUpdate(query);
		if (! message.equals(""))
			throw new UnsuccessfulUpdateException(query, message);
	}
	
	/**
	 * @return The status of this profile.
	 * <ul>
	 * <li>-1: denied (not public)</li>
	 * <li>0: untrusted, unverified (not public)</li>
	 * <li>1: trusted, unverified (public)</li>
	 * <li>2: verified (public)</li>
	 * </ul>
	 */
	public String getStatus() {
		return this.status;
	}
	
	/**
	 * @param status The status set to.
	 * <ul>
	 * <li>-1: denied (not public)</li>
	 * <li>0: untrusted, unverified (not public)</li>
	 * <li>1: trusted, unverified (public)</li>
	 * <li>2: verified (public)</li>
	 * </ul>
	 */
	public void setStatus(String status) {
		this.status = status;
	}
	
	/**
	 * @return The PKey of this profile.
	 */
	public String getId() {
		return this.id;
	}
	
	/**
	 * @param id The ID to set PKey to.
	 */
	public void setId(String id) {
		this.id = id;
	}
	
	/**
	 * Gets the name of the profile username.
	 * @return The name of the profile username.
	 */
	public String getName()
	{
		return this.name;
	}
	
	/**
	 * Gets the bio of the profile.
	 * @return The bio of the profile.
	 */
	public String getBio()
	{
		return this.bio;
	}
	
	/**
	 * Gets the website of the profile.
	 * @return The website of the profile.
	 */
	public String getWebsite()
	{
		return this.website;
	}
	
	/**
	 * Gets the skills of the profile.
	 * @return The skills of the profile.
	 */
	public String getSkills()
	{
		return this.skills;
	}
	
	/**
	 * Sets the name of the profile.
	 * @param name a string of the name (email/username).
	 */
	public void setName(String name)
	{
		this.name = name;
	}
	
	/**
	 * Sets the bio of the profile.
	 * @param bio a string of the bio.
	 */
	public void setBio(String bio)
	{
		this.bio = bio;
	}
	
	/**
	 * Sets the website of the profile.
	 * @param website a string of the website.
	 */
	public void setWebsite(String website)
	{
		this.website = website;
	}
	
	/**
	 * Sets the skills of the profile.
	 * @param skills a string of the skills.
	 */
	public void setSkills(String skills)
	{
		this.skills = skills;
	}

}
