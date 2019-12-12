package constants;

/**
 * Class for holding attribute constants that are stored in the session.
 */
public final class SessionConstants {
	public static final String ACCOUNT_PKEY = "accountPKey";
	public static final String ACCOUNT_EMAIL = "accountEmail";
	public static final String USER_CLASS = "userClass";
	
	public static final String REFERER = "Referer";
	public static final String LANDING = "Landing";
	public static final String ACCESS_DATE = "AccessDate";
	public static final String RSVPD_EVENT_PKEY = "RSVPdEventPKey";
	
	/**
	 * Can't be instantiated.
	 * https://stackoverflow.com/questions/479565/how-do-you-define-a-class-of-constants-in-java
	 */
	private void SessionConstant() {}
}
