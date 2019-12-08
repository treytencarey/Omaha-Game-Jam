package weblisteners;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

/**
 * Listens for Session expiration and appends its attributes to activities.csv.
 */
public class ActivityStashWriter implements HttpSessionListener {
	
	@Override
	public void sessionCreated(HttpSessionEvent se) {
		// Just to show this class is listening, don't actually need this method overriden.
		HttpSessionListener.super.sessionCreated(se);
		System.out.println("Session created!");
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent se)
	{
		HttpSessionListener.super.sessionDestroyed(se);
		try
		{
			HttpSession session = se.getSession();

			String AccountPKey = attributeToStringOrNoneIfNullSorryLongName(session.getAttribute("accountPKey"));
			String Referer = attributeToStringOrNoneIfNullSorryLongName(session.getAttribute("Referer"));
			String Landing = attributeToStringOrNoneIfNullSorryLongName(session.getAttribute("Landing"));
			String RSVPdEventPKey = attributeToStringOrNoneIfNullSorryLongName(session.getAttribute("RSVPdEventPKey"));
			
			System.out.println("Session expired! Appending to activities.csv... (doesn't work yet)");
			System.out.println("Referer: " + Referer);
			System.out.println("Landing: " + Landing);
			System.out.println("AccountPKey: " + AccountPKey);
			System.out.println("RSVPdEventPKey: " + RSVPdEventPKey);
		}
		catch (Exception e)
		{
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	/**
	 * Returns attr.toString() if attr not null, "None" if null.
	 * @param attr Object to check if null.
	 * @return Str or "None"
	 */
	private String attributeToStringOrNoneIfNullSorryLongName(Object attr)
	{
		return (attr == null ? "None" : attr.toString());
	}
}
