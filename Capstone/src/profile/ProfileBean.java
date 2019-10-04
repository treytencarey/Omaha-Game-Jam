package profile;

import java.io.Serializable;

public class ProfileBean implements Serializable{
	
	private static final long serialVersionUID = 1L;
	private String id, name, bio, site, skills;
	private boolean isBlank, exists; // isBlank is only set is fetchAndFillUsed. Might need to update this every time a value changed?

	public ProfileBean() {
		id = name = bio = site = skills = "";
		isBlank = true;
		exists = false;
	}
	
	/*
	 * Check if all the values are blank; update isBlank accordingly.
	 */
	public void updateIsBlank()
	{
		setIsBlank( String.join("", name, bio, site, skills).trim().isEmpty() );
	}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getBio() {
		return bio;
	}
	public void setBio(String bio) {
		this.bio = bio;
	}
	public String getSite() {
		return site;
	}
	public void setSite(String site) {
		this.site = site;
	}
	public String getSkills() {
		return skills;
	}
	public void setSkills(String skills) {
		this.skills = skills;
	}
	public boolean getIsBlank() {
		return isBlank;
	}
	public void setIsBlank(boolean isBlank) {
		this.isBlank = isBlank;
	}
	public boolean getExists() {
		return exists;
	}
	public void setExists(boolean exists) {
		this.exists = exists;
	}

}
