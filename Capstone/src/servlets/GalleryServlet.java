package servlets;

import static java.nio.file.StandardCopyOption.REPLACE_EXISTING;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.FileSystems;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Collections;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import beans.Event;
import beans.EventTableBean;
import project.Main;

/**
 * Servlet implementation class GalleryServlet
 */
@WebServlet("/GalleryServlet")
@MultipartConfig
public class GalleryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String DESTINATION_JSP = "Gallery/index.jsp";
	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public GalleryServlet() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String id = request.getParameter("id");
		EventTableBean eventTable = new EventTableBean();

		/**
		 * Setup gallery page for the current event if no id is given
		 */
		try {
			ArrayList<Event> events = new ArrayList<Event>();
			ArrayList<Event> pastEvents = eventTable.getPastEvents();
			
			Collections.reverse(pastEvents);
			if(eventTable.getCurrentEvent().IsPublic())
				events.add(eventTable.getCurrentEvent());
			if (id == null) {
				/**
				 * Display only three most recent event galleries for the default page
				 */
				for(int i = 0; i < pastEvents.size(); i++) {
					if(events.size() == 3)
						break;
					if(pastEvents.get(i).IsPublic())
						events.add(pastEvents.get(i));
				}
				
					request.setAttribute("events", events);
			}
			else { //gallery page for single event, indicated by id parameter in url
				//search for the id (pkey), get that event, and return that as a single entry in an arraylist (so that the existing gallery page can read it)
				pastEvents.add(eventTable.getCurrentEvent());
				int eKey = Integer.parseInt(id);
				ArrayList<Event> thisEvent = new ArrayList<Event>();
				
				for(int i = 0; i < pastEvents.size(); i++) {
					if(eKey == pastEvents.get(i).getKey() && pastEvents.get(i).IsPublic()) {
						thisEvent.add(pastEvents.get(i));
						request.setAttribute("events", thisEvent);
					}
				}
			}
		} catch (Exception ex) {
			System.err.println(ex);
		} finally {
			request.getRequestDispatcher(DESTINATION_JSP).forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		/**
		 * Redirect link back to the gallery page
		 */
		String redirectLink = request.getContextPath() + "/Gallery";
		int eventNum = Integer.parseInt(request.getParameter("galleryEvent"));
		int eventPKey = 0;
		
		ArrayList<Event> events = new ArrayList<Event>();
		try {
			EventTableBean evTable = new EventTableBean();
			ArrayList<Event> pastEvents = evTable.getPastEvents();
			
			Collections.reverse(pastEvents);
			events.add(evTable.getCurrentEvent());
			for (int i = 0; i < pastEvents.size(); i++) {
				events.add(pastEvents.get(i));
			}
			
			for (int i = 0; i < events.size(); i++) {
				if(events.get(i).getKey() == eventNum) {
					eventPKey = events.get(i).getKey();
					break;
				}
			}
		} catch (Exception e) {
			System.err.println(e);
			return;
		}


		if (request.getParameter("addGalleryPhotosButton") != null) {
			for (Part part : request.getParts()) {
				if (part.getSubmittedFileName() != null)
					saveFile(part, part.getSubmittedFileName(), eventPKey);
			}
		}
		
		if (request.getParameter("deleteGalleryPhotosButton") != null) {
			String fileToDelete = request.getParameter("galleryFile");
			deleteFile(fileToDelete, eventPKey);
		}

		response.sendRedirect(redirectLink);
	}

	/**
	 * Saves the given file in a directory on the server (Uploads/Gallery)
	 * @param p - Part to get input stream from
	 * @param filename - name of the file to be saved into directory
	 * @param pKey - specifies the PKey of the event. Event PKey is the name of folder that file is saved in
	 * @throws IOException
	 */
	private static void saveFile(Part p, String filename, int pKey) throws IOException {
		String path = Main.context.getRealPath("/Uploads/Gallery/");
		path = path + pKey + "\\" + filename;
		
		Path realPath = Paths.get(path);

		try (InputStream is = p.getInputStream()) {
			if(!Files.exists(realPath)) {
				//System.out.println(realPath);
				Files.createDirectories(realPath);
			}
			Files.copy(is, realPath, REPLACE_EXISTING);
		}
	}
	
	/**
	 * Deletes a file from server directory based on given filename and pKey
	 * @param filename - name of the file to be deleted from directory
	 * @param pKey - specifies the PKey of the event. Event PKey is the name of folder that file is saved in
	 */
	private static void deleteFile(String filename, int pKey) {
		String path = Main.context.getRealPath("/Uploads/Gallery/");
		path = path + pKey + "\\" + filename;
		System.out.println(path);
		new File(path).delete();
	}
}
