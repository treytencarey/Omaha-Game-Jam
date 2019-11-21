package database;

/**
 * Represents a single row from the Attendees table.
 */
public class Attendee {
	private String apk;
	private String epk;
	public Attendee(String accountPKey, String eventPKey)
	{
		this.setApk(accountPKey);
		this.setEpk(eventPKey);
	}
	
	public String getApk() {
		return apk;
	}
	public void setApk(String apk) {
		this.apk = apk;
	}
	public String getEpk() {
		return epk;
	}
	public void setEpk(String epk) {
		this.epk = epk;
	}	
}