package servlets;

import static java.nio.file.StandardCopyOption.REPLACE_EXISTING;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.FileSystems;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

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
		
		String path;
		
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
		 * String array representing image list for event
		 */
		String[] eventImages = request.getParameterValues("eventImage");
		
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
		
		//Check if event pkey already exists in Events table
		List<Map<String, Object>> check = Database.executeQuery("SELECT * FROM Events WHERE PKey=" + String.valueOf(PKey));
		
		if(check.size() > 0) {
			Database.executeUpdate("UPDATE Events SET Title='"+title+"', Theme='"+theme+"', Description='"+eventDescription+"', StartDate='"+startDate+"', EndDate='"+endDate+" WHERE PKey='"+PKey+"'");
			//Update Mutators
			List<Map<String, Object>> m = Database.executeQuery("SELECT * FROM Mutators WHERE EventPKey=" + String.valueOf(PKey));
			for(int i = 0; i < m.size(); i++) {
				boolean tf = false;
				int index = -1;
				
				for(int j = 0; j < mutators.length; j++) {
					if(m.get(i).get("Title").equals(mutators[j])) {
						tf = true;
						index = j;
						break;
					}
				}
				if(tf) {
					Database.executeUpdate("UPDATE Mutators SET Title='"+mutators[index]+"', Description='"+mutatorDescriptions[index]+"' WHERE Title="+m.get(i).get("Title"));
					mutators[index] = null;
					mutatorDescriptions[index] = null;
					
				} else {
					Database.executeUpdate("DELETE FROM Mutators WHERE Title='"+m.get(i).get("Title"));
				}
			}
			for(int i = 0; i < mutators.length; i++) {
				if(mutators[i] != null) {
					Database.executeUpdate("INSERT OR REPLACE INTO Mutators (EventPKey, Title, Description) VALUES ('" + PKey + "', '" + mutators[i] + "', '" + mutatorDescriptions[i] + "')");
				}
			}
		}
		else {
			Database.executeUpdate("INSERT OR REPLACE INTO Events (Title, Theme, Description, StartDate, EndDate) VALUES ('" + title + "', '" + theme + "', '" + eventDescription + "', '" + startDate + "', '" + endDate + "')");
			List<Map<String, Object>> query = Database.executeQuery("SELECT PKey FROM Events WHERE Title=\'" + title + "\'");
			PKey = query.get(0).get("PKey").toString();
			
			for(int i = 0; i < mutators.length; i++) {
				if(mutators[i] != null && mutatorDescriptions[i] != null) {
					Database.executeUpdate("INSERT OR REPLACE INTO Mutators (EventPKey, Title, Description) VALUES ('" + PKey + "', '" + mutators[i] + "', '" + mutatorDescriptions[i] + "')");
				}
			}
		}
		
		/**
		 * Get the image from newsFile in form, and write to Upload/News/Photo
		 */
		if(!request.getPart("eventImage").getSubmittedFileName().isEmpty()) {
			Part headerImg = request.getPart("eventImage");
			path = getServerPath("/Uploads/Events/HeaderImages/HeaderImages");
			Path imgPath = FileSystems.getDefault().getPath(path, PKey + "_header.png");

			try (InputStream is = headerImg.getInputStream()) {
				Files.copy(is, imgPath, REPLACE_EXISTING);
			}
		}
		
		response.sendRedirect(request.getContextPath() + "/Events/");
		
		
	}
	
	private static String getServerPath(String orig) {
		String[] splits = orig.replaceAll("\\\\", "/").split("/");
		String fileName = splits[splits.length - 1];
		String pth = Main.context.getRealPath(orig.substring(0, orig.length() - fileName.length()));
		return pth;
	}

}
