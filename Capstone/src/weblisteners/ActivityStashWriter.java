package weblisteners;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;
import constants.SessionConstants;

/**
 * Listens for Session expiration and appends its attributes to activities.csv.
 */
@WebListener
public class ActivityStashWriter implements HttpSessionListener {
//	private static Integer instances = 0;
//	private static BufferedWriter bw; // Singleton that all ActivityStashWriters use (but it looks like there's only 1 instantiated based on my tests)
	private static final String VIRTUAL_CSV_PATH = "Analytics/activities.csv"; // Path to CSV file from realPath (WebContent I think)
	private static final String CSV_HEADER_LINE = "AccountPKey,Referer,Landing,RSVPdEventPKey,AccessDate\n"; // Header line to begin the CSV file with in case CSV doesn't exist.
	private BufferedWriter bw; // Singleton that all ActivityStashWriters use (but it looks like there's only 1 instantiated based on my tests)

	/**
	 * Once a Session is about to expire, collects its attributes and stores them in activities.csv. If that file doesn't exist, create it and write its headers.
	 */
	public void sessionDestroyed(HttpSessionEvent se)
	{
		try
		{
			HttpSession session = se.getSession();

			// Retrieve attributes from Session
			String AccountPKey = formatAttributeForCSV(session.getAttribute(SessionConstants.ACCOUNT_PKEY));
			String Referer = formatAttributeForCSV(session.getAttribute(SessionConstants.REFERER));
			String Landing = formatAttributeForCSV(session.getAttribute(SessionConstants.LANDING));
			String RSVPdEventPKey = formatAttributeForCSV(session.getAttribute(SessionConstants.RSVPD_EVENT_PKEY));
			String AccessDate = formatAttributeForCSV(session.getAttribute(SessionConstants.ACCESS_DATE));
			
			// Print out the attributes
			System.out.println("Session expired! Appending to activities.csv...");
			System.out.println("Referer: " + Referer);
			System.out.println("Landing: " + Landing);
			System.out.println("AccountPKey: " + AccountPKey);
			System.out.println("RSVPdEventPKey: " + RSVPdEventPKey);
			System.out.println("AccessDate: " + AccessDate);
			
			// Prepare activities.csv
			File af = new File(session.getServletContext().getRealPath(VIRTUAL_CSV_PATH));
			System.out.println(af.getAbsolutePath());
			if (af.exists()) // If CSV already exists: just initialize bw
			{
				FileWriter fw = new FileWriter(af, true);
				bw = new BufferedWriter(fw);
			}
			else // If CSV doesn't exist: create it, initialize bw, and and write headers
			{
				af.createNewFile();
				FileWriter fw = new FileWriter(af, true);
				bw = new BufferedWriter(fw);
				bw.write(CSV_HEADER_LINE);
			}
			
			// Append attributes to activities.csv
			bw.append(String.format("%s,%s,%s,%s,%s\n", AccountPKey, Referer, Landing, RSVPdEventPKey, AccessDate)); // Append this user's Session attributes
			bw.flush();
		}
		catch (NullPointerException npe)
		{
			System.out.println("ActivityStashWriter: Oops, something was null.");
			npe.printStackTrace();
		}
		catch (IOException ioe)
		{
			System.out.println("Unable to append to activities.csv");
			ioe.printStackTrace();
		}
	}
	
	/**
	 * Returns "None" if attr is null, otherwise attr.toString() with all double quotes and commas wrapped.
	 * @param attr Attribute whose toString() to format.
	 * @return attr.toString() with commas and double quotes formatted for CSV, or "None"
	 */
	private String formatAttributeForCSV(Object attr)
	{
		String result = (attr == null ? "" : attr.toString()); // Set to "None" if attribute null
		result.replace("\"", "\"\"\""); // Wrap all double quotes in double quotes
		result.replace(",", "\",\""); // Wrap all commas in double quotes
		return result;
	}
	
//	public ActivityStashWriter() {
//		// TODO Auto-generated constructor stub
//		System.out.println("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nActivityStashWriter CREATED!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! YAYAYAYAYAYAYAY\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
//	}
//	
//	public void sessionCreated(HttpSessionEvent se) {
//		System.out.println("Session created!"); // Just to show this class is listening, don't actually need this method overridden.
//	}
}
