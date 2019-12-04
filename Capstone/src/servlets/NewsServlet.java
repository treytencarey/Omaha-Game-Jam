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
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.apache.commons.io.FileUtils;

import beans.News;
import database.Database;
import project.Main;

/**
 * Servlet implementation class NewsServlet
 */
@WebServlet("/NewsServlet")
@MultipartConfig
public class NewsServlet extends HttpServlet {
	private static final long serialVersionUID = -3600831944723019273L;
	private static final String SUCCESS_JSP = "view_news.jsp";
	private static final String DEFAULT_JSP = "News/index.jsp";

	String path;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public NewsServlet() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String id = request.getParameter("newsid");
		List<Map<String, Object>> query = Database.executeQuery("SELECT * FROM Blogs WHERE PKey=" + id);
		News news;

		if (id == null || query.size() == 0) {
			response.getWriter().append("No public news article found for " + id);
			return;
		}

		news = new News(Integer.parseInt(id));

		request.setAttribute("News", news);
		request.getRequestDispatcher(SUCCESS_JSP).forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		/**
		 * When the user submits an article/edits and article, this link will redirect
		 * them to the article
		 */
		String redirectLink = request.getContextPath() + "/News";

		/**
		 * Get title, header, and body from input on "Create/Edit News Article" modal
		 */
		String reqTitle = request.getParameter("newsTitle");
		String reqHeader = request.getParameter("newsHeader");
		String reqBody = request.getParameter("newsBody");
		String pKey = null;
		boolean isPublicChecked = request.getParameter("isPublicCheckbox") != null;

		/**
		 * Set isPublic to an Integer so that it can be put into the database
		 */
		int isPublicDb;
		if (isPublicChecked)
			isPublicDb = 1;
		else
			isPublicDb = 0;
		
		/**
		 * Get Part/image from form in each (exception occurs if getPart is used up here with the delete function)
		 */
		Part headerImg = null;

		if (request.getParameter("newNewsArticleButton") != null) {
			if (!request.getPart("newsFile").getSubmittedFileName().isEmpty())
				headerImg = request.getPart("newsFile");
			pKey = addNewsArticle(reqTitle, reqHeader, reqBody, isPublicDb, headerImg);
		}

		if (request.getParameter("editNewsArticleButton") != null) {
			String id = request.getParameter("newsId");
			if (!request.getPart("newsFile").getSubmittedFileName().isEmpty())
				headerImg = request.getPart("newsFile");
			pKey = editNewsArticle(id, reqTitle, reqHeader, reqBody, isPublicDb, headerImg);
		}

		if (request.getParameter("deleteNewsArticleButton") != null) {
			String id = request.getParameter("newsId");
			deleteNewsArticle(id);
			response.sendRedirect(redirectLink);
			return;
		}

		/**
		 * Add the PKey to the id parameter in url so that user gets redirected to the
		 * page they just created/edited
		 */
		redirectLink = redirectLink + "/view?newsid=" + pKey;
		response.sendRedirect(redirectLink);
	}

	/**
	 * Adds a news article to the database
	 * @param title - Title of the news article
	 * @param subtitle - Subtitle of the news article
	 * @param body - Body of the news article (saved to a txt file)
	 * @param isPublic - If the article is public (0 for not public, 1 for public)
	 * @param headerImg - The image for the header
	 * @return the PKey of the created news article database entry
	 * @throws IOException
	 */
	public static String addNewsArticle(String title, String subtitle, String body, int isPublic, Part headerImg) throws IOException {
		List<Map<String, Object>> query = null;
		/**
		 * Format the date to MM/dd/yyyy to display in database/page
		 */
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("MM/dd/yyyy");
		String currentDate = dtf.format(LocalDateTime.now());

		/**
		 * Find the path where the body txt file will go
		 */
		String path = getServerPath("/Uploads/News/Body/Body");

		Database.executeUpdate("INSERT OR REPLACE INTO Blogs(Date, Title, IsPublic, Header) VALUES (\'" + currentDate
				+ "\', \'" + title + "\', \'" + isPublic + "\', \'" + subtitle + "\')");
		query = Database.executeQuery(
				"SELECT PKey FROM Blogs WHERE Date=\'" + currentDate + "\' AND Title=\'" + title + "\'");
		
		String pKey = query.get(0).get("PKey").toString();
		createFile(pKey, path, body);
		
		/**
		 * Get the part(image) and write to Upload/News/Photo
		 */
		if(headerImg != null) {
			path = getServerPath("/Uploads/News/Photo/Photo");
			Path imgPath = FileSystems.getDefault().getPath(path, pKey + "_header.png");

			try (InputStream is = headerImg.getInputStream()) {
				Files.copy(is, imgPath, REPLACE_EXISTING);
			}
		}
		
		return pKey;
	}
	
	/**
	 * Adds a news article to the database
	 * @param title - Title of the news article
	 * @param subtitle - Subtitle of the news article
	 * @param body - Body of the news article (saved to a txt file)
	 * @param isPublic - If the article is public (0 for not public, 1 for public)
	 * @param eventPKey - The PKey of the event to copy header photo from
	 * @return the PKey of the created news article database entry
	 * @throws IOException
	 */
	public static String addEventNewsArticle(String title, String subtitle, String body, int isPublic, int eventPKey) throws IOException {
		String pKey;
		
		//check if the event already has an article to prevent duplicates
		List<Map<String, Object>> query = Database.executeQuery("SELECT PKey FROM Blogs WHERE Title=\'" + title + "\' AND Header=\'" + subtitle + "\'");
		if(!query.isEmpty()) {
			pKey = query.get(0).get("PKey").toString();
			return pKey;
		}
		
		pKey = addNewsArticle(title, subtitle, body, isPublic, (Part)null);
		File headerSrc = new File(getServerPath("/Uploads/Events/HeaderImages/HeaderImages") + "/" + eventPKey + "_header.png");
		File newsDest = new File(getServerPath("/Uploads/News/Photo/Photo") + "/" + pKey + "_header.png");

		try {
			FileUtils.copyFile(headerSrc, newsDest);
		} catch(IOException e) {
			e.printStackTrace();
			return pKey;
		}
		
		return pKey;
	}
	
	/**
	 * Edits the news article based on given parameters
	 * @param id - the id/PKey of the article in the database
	 * @param title - the title of the news article
	 * @param subtitle - Subtitle of the news article
	 * @param body - Body of the news article (saved to a txt file)
	 * @param isPublic - If the article is public (0 for not public, 1 for public)
	 * @param headerImg - The image for the header (if null, image will stay the same)
	 * @return the PKey of the created news article database entry
	 * @throws IOException
	 */
	public static String editNewsArticle(String id, String title, String subtitle, String body, int isPublic, Part headerImg) throws IOException {
		List<Map<String, Object>> query = null;
		/**
		 * Format the date to MM/dd/yyyy to display in database/page
		 */
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("MM/dd/yyyy");
		String currentDate = dtf.format(LocalDateTime.now());

		/**
		 * Find the path where the body txt file will go
		 */
		String path = getServerPath("/Uploads/News/Body/Body");

		Database.executeUpdate("UPDATE Blogs SET Date=\'" + currentDate + "\', Title=\'" + title
				+ "\', IsPublic=\'" + isPublic + "\', Header=\'" + subtitle + "\' WHERE PKey=" + id);
		query = Database.executeQuery("SELECT PKey FROM Blogs WHERE Pkey=" + id);
		
		String pKey = query.get(0).get("PKey").toString();
		createFile(pKey, path, body);
		
		/**
		 * Get the part(image) and write to Upload/News/Photo
		 */
		if(headerImg != null) {
			path = getServerPath("/Uploads/News/Photo/Photo");
			Path imgPath = FileSystems.getDefault().getPath(path, pKey + "_header.png");

			try (InputStream is = headerImg.getInputStream()) {
				Files.copy(is, imgPath, REPLACE_EXISTING);
			}
		}
		
		return pKey;
	}
	
	/**
	 * Deletes news article from the database, along with its body and image from file directories
	 * @param id - The id/PKey of the news article in the database
	 * @throws IOException
	 */
	public static void deleteNewsArticle(String id) throws IOException {
		String path = getServerPath("/Uploads/News/Body/Body");
		Database.executeUpdate("DELETE FROM Blogs WHERE PKey=" + id);
		Files.deleteIfExists(Paths.get(path + id + "_body.txt"));
		path = getServerPath("/Uploads/News/Photo/Photo");
		Files.deleteIfExists(Paths.get(path + id + "_header.png"));
	}
	
	/**
	 * Creates the body file for the news article
	 * @param pKey - The PKey of the article in the database, used for filename
	 * @param path - The path where the txt file is saved
	 * @param body - The content/text in the file
	 * @throws IOException
	 */
	private static void createFile(String pKey, String path, String body) throws IOException {
		/**
		 * Create the file in the form of PKey_body.txt and write/overwrite to the file
		 */
		File file = new File(path + pKey + "_body.txt");
		file.createNewFile();
		FileOutputStream outFile = new FileOutputStream(file);
		outFile.write(body.getBytes());
		outFile.close();
	}

	/**
	 * Gets the real server path from the original path given
	 * @param orig - The original path
	 * @return The real server path
	 */
	private static String getServerPath(String orig) {
		String[] splits = orig.replaceAll("\\\\", "/").split("/");
		String fileName = splits[splits.length - 1];
		String pth = Main.context.getRealPath(orig.substring(0, orig.length() - fileName.length()));
		return pth;
	}

}
