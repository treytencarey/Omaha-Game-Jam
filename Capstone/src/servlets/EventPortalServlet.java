package servlets;

import static java.nio.file.StandardCopyOption.REPLACE_EXISTING;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.FileSystems;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import beans.Event;
import beans.EventTableBean;
import database.Mutator;
import database.Database;
import project.Main;

/**
 * Servlet implementation class EventServlet
 */
@WebServlet("/EventServlet")
@MultipartConfig
public class EventPortalServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EventPortalServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.sendRedirect(request.getContextPath() + "/Events/");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		
		boolean RSVPing = request.getParameter("RSVPButton") != null;
		if (RSVPing)
		{
			HttpSession session = request.getSession(false);
			
			if (session.getAttribute("accountPKey") == null)
			{
				response.setStatus(400);
				response.getWriter().print("You must log in or create an account first!");
				response.getWriter().flush();
				return;
			}
			
			String apk = session.getAttribute("accountPKey").toString();
			EventTableBean et = new EventTableBean();
			Event ec;
			try {
				ec = et.getCurrentEvent();
			} catch (ParseException e) {
				response.setStatus(400);
				response.getWriter().print("Error communicating with DB.");
				response.getWriter().flush();
				return;
			}
			List<Map<String, Object>> results = Database.executeQuery("SELECT COUNT(*) FROM Attendees WHERE AccountPKey=" + apk + " AND EventPKey=" + ec.getKey());
			if (results.size() == 0) // Error contacting DB?
				throw new NullPointerException();
			String count = results.get(0).get("COUNT(*)").toString();
			
			String success = "";
			
			if (request.getParameter("RSVPButton").toString().equals("RSVP")) {
				if (count.equals("0"))
				{
					//INSERT INTO Attendees (AccountPKey, EventPKey) VALUES (1, 1);
					String query = String.format("INSERT INTO Attendees (AccountPKey, EventPKey) VALUES (%s, %s);", apk, ec.getKey());
					if (Database.executeUpdate(query).length() == 0)
					{
						success = "You're now registered for " + ec.getTitle();
						request.setAttribute("EventPKey", ec.getKey());
					}
					else
					{
						response.setStatus(400);
						response.getWriter().print("Error communicating with DB.");
						response.getWriter().flush();
						return;
					}
				}
				else
				{
					success = "You're already registered!";
				}
			}
			else // UnRSVP'ing 
			{
				if (!count.equals("0"))
				{
					Database.executeUpdate("DELETE FROM Attendees WHERE AccountPKey=" + apk + " AND EventPKey=" + ec.getKey());
					success = "You're no longer registered for " + ec.getTitle();
				}
				else
				{
					response.setStatus(400);
					response.getWriter().print("You are not registered for this event.");
					response.getWriter().flush();
					return;
				}
			}
			response.setStatus(200);
			response.getWriter().print(success);
			response.getWriter().flush();
			
			return;
		}		
		
		String path;
		
		/**
		 * int representing visibility of event, 1 is visible, 0 is not
		 */
		int isPublic = 0;
		
		/**
		 * String representing schedule of event
		 */
		String schedule = request.getParameter("eventSchedule");
		
		/**
		 * String representing title of event
		 */
		String PKey = request.getParameter("PKey");
		
		/**
		 * String representing title of event
		 */
		String title = request.getParameter("title");
		
		/**
		 * String representing theme of event
		 */
		String theme = request.getParameter("theme");
		
		/**
		 * String representing description of event
		 */
		String eventDescription = request.getParameter("eventDescription");
		
		/**
		 * String array representing mutator list for event
		 */
		String[] mutators = request.getParameterValues("mutator");
		
		/**
		 * String array representing mutator descriptions for event
		 */
		String[] mutatorDescriptions = request.getParameterValues("mutatorDescription");
		
		/**
		 * String representing start date of event
		 */
		String startDate = request.getParameter("startDate");
		
		/**
		 * String representing end date of event
		 */
		String endDate = request.getParameter("endDate");
		
		if (request.getParameter("toDelete") != null && request.getParameter("toDelete").contentEquals("yes")) {
			Database.executeUpdate("DELETE FROM Mutators WHERE EventPKey=" + PKey);
			Database.executeUpdate("DELETE FROM Events WHERE PKey=" + PKey);
			try {
			path = getServerPath("/Uploads/Events/HeaderImages/HeaderImages");
			Files.deleteIfExists(Paths.get(path + PKey + "_header.png"));
			path = getServerPath("/Uploads/Events/Schedule/Schedule");
			Files.deleteIfExists(Paths.get(path + PKey + "_body.txt"));
			path = getServerPath("/Uploads/Events/Body/Body");
			Files.deleteIfExists(Paths.get(path + PKey + "_body.txt"));
			} catch(Exception e) {

			}
			response.sendRedirect(request.getContextPath() + "/AdminPanel/");
			return;
		}
		
		//Check if event pkey already exists in Events table
		List<Map<String, Object>> check = Database.executeQuery("SELECT * FROM Events WHERE PKey=" + String.valueOf(PKey));
		
		if(check.size() > 0) {
			
			if(request.getParameter("visibility") != null) {
				isPublic = 1;
			}
			//Update Mutators
			List<Map<String, Object>> mutatorquery = Database.executeQuery("SELECT * FROM Mutators WHERE EventPKey=" + String.valueOf(PKey));
			ArrayList<Mutator> oldMutators = new ArrayList<Mutator>();
			ArrayList<Mutator> newMutators = new ArrayList<Mutator>();

			//Arraylist of all old mutators for event
			for(Map<String, Object> oldMutator : mutatorquery) {
				oldMutators.add(new Mutator((int)oldMutator.get("PKey")));
			}

			//Arraylist of all new mutators for event
			if(mutators != null) {
				for(int i = 0; i < mutators.length; i++) {
					newMutators.add(new Mutator(mutators[i],mutatorDescriptions[i]));
				}
			}

			
			//Update mutators with same Title, delete if no longer exists
			for(Mutator oldMutator : oldMutators) {
				boolean delete = true;
				Mutator toRemove = null;
				for(Mutator newMutator : newMutators) {
					if(oldMutator.getTitle() == newMutator.getTitle()) {
						Database.executeUpdate("UPDATE Mutators SET Title=\'"+newMutator.getTitle()+"\', Description=\'"+newMutator.getDesc()+"\' WHERE Title="+oldMutator.getTitle());
						delete = false;
						toRemove = newMutator;
					}
				}
				if(delete) {
					Database.executeUpdate("DELETE FROM Mutators WHERE PKey="+oldMutator.getPKey());
				}
				if(toRemove != null) {
					newMutators.remove(toRemove);
				}
			}

			//Add remaining mutators to database
			for(Mutator newMutator : newMutators) {
				if(newMutator.getTitle() != null) {
					if(newMutator.getDesc() != null) {
						Database.executeUpdate("INSERT OR REPLACE INTO Mutators (EventPKey, Title, Description) VALUES ('" + PKey + "', '" + newMutator.getTitle() + "', '" + newMutator.getDesc() + "')");
					}
					else {
						Database.executeUpdate("INSERT OR REPLACE INTO Mutators (EventPKey, Title, Description) VALUES ('" + PKey + "', '" + newMutator.getTitle() + "', \'No Description\')");
					}
				}
			}

			//Update Event, event description, and event schedule
			Database.executeUpdate("UPDATE Events SET Title=\'" + title + "\', Theme=\'" + theme + "\', Description=\'" + eventDescription + "\', StartDate=\'" + startDate + "\', EndDate=\'" + endDate + "\', IsPublic=\'" + isPublic + "\' WHERE PKey=" + PKey);
			
			path = getServerPath("/Uploads/Events/Body/Body");
			createFile(PKey, path, eventDescription);
			path = getServerPath("/Uploads/Events/Schedule/Schedule");
			createFile(PKey, path, schedule);
		}
		else { //Insert new mutators and event into database
			Database.executeUpdate("INSERT OR REPLACE INTO Events (Title, Theme, Description, StartDate, EndDate, IsPublic) VALUES ('" + title + "', '" + theme + "', '" + " " + "', '" + startDate + "', '" + endDate + "', '" + isPublic +"')");
			List<Map<String, Object>> query = Database.executeQuery("SELECT PKey FROM Events WHERE Title=\'" + title + "\'");
			PKey = query.get(0).get("PKey").toString();
			
			//Create event description file
			path = getServerPath("/Uploads/Events/Body/Body");
			createFile(PKey, path, eventDescription);
			path = getServerPath("/Uploads/Events/Schedule/Schedule");
			if(schedule == null || schedule == "") {
				schedule = "No Schedule Available";
			}
			createFile(PKey, path, schedule);
			
			if(mutators != null) {
				for(int i = 0; i < mutators.length; i++) {
					if(mutators[i] != null && mutatorDescriptions[i] != null) {
						Database.executeUpdate("INSERT OR REPLACE INTO Mutators (EventPKey, Title, Description) VALUES ('" + PKey + "', '" + mutators[i] + "', '" + mutatorDescriptions[i] + "')");
					}
				}
			}
		}
		
		//Upload event image
		if(!request.getPart("eventImage").getSubmittedFileName().isEmpty()) {
	        
			Part headerImg = request.getPart("eventImage");
			path = getServerPath("/Uploads/Events/HeaderImages/HeaderImages");
			Files.deleteIfExists(Paths.get(path + PKey + "_header.png"));
			Path imgPath = FileSystems.getDefault().getPath(path, PKey + "_header.png");
			
			try (InputStream is = headerImg.getInputStream()) {
				Files.copy(is, imgPath, REPLACE_EXISTING);
			}
			
		}
		
		response.sendRedirect(request.getContextPath() + "/AdminPanel/");
		
		
	}
	
	/**
	 * Creates the body file for the news article
	 * @param pKey - The PKey of the article in the database, used for filename
	 * @param path - The path where the txt file is saved
	 * @param body - The content/text in the file
	 * @throws IOException
	 */
	private static void createFile(String pKey, String path, String body) throws IOException {
		System.out.print(path+pKey+"_body.txt");
		/**
		 * Create the file in the form of PKey_body.txt and write/overwrite to the file
		 */
		File file = new File(path + pKey + "_body.txt");
		file.createNewFile();
		FileOutputStream outFile = new FileOutputStream(file);
		outFile.write(body.getBytes());
		outFile.close();
	}
	
	private static String getServerPath(String orig) {
		String[] splits = orig.replaceAll("\\\\", "/").split("/");
		String fileName = splits[splits.length - 1];
		String pth = Main.context.getRealPath(orig.substring(0, orig.length() - fileName.length()));
		return pth;
	}

}
