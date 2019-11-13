package database;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import project.Main;

/**
 * Servlet implementation class NewsServlet
 */
@WebServlet("/NewsServlet")
public class NewsServlet extends HttpServlet {
	private static final long serialVersionUID = -3600831944723019273L;
	private static final String SUCCESS_JSP = "view_news.jsp";
	private static final String DEFAULT_JSP = "News/index.jsp";
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NewsServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		List<Map<String, Object>> query = Database.executeQuery("SELECT * FROM Blogs WHERE PKey=" + id + " AND IsPublic = 1");
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
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		
		/**
		 * When the user submits an article/edits and article, this link will redirect them to the article
		 */
		String redirectLink = request.getContextPath() + "/News/view?id=";
		
		/**
		 * Get title, header, and body from input on "Create/Edit News Article" modal
		 */
		String reqTitle = request.getParameter("newsTitle");
		String reqHeader = request.getParameter("newsHeader");
		String reqBody = request.getParameter("newsBody");
		boolean isPublicChecked = request.getParameter("isPublicCheckbox") != null;
		
		/**
		 * Set isPublic to an Integer so that it can be put into the database
		 */
		int isPublicDb;
		if(isPublicChecked)
			isPublicDb = 1;
		else
			isPublicDb = 0;
		
		/**
		 * Format the date to MM/dd/yyyy to display in database/page
		 */
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("MM/dd/yyyy");
		String currentDate = dtf.format(LocalDateTime.now());
		
		List<Map<String, Object>> query = null;
		
		if(request.getParameter("newNewsArticleButton") != null) {
			Database.executeUpdate("INSERT OR REPLACE INTO Blogs(Date, Title, IsPublic, Header) VALUES (\'" + currentDate + "\', \'" + reqTitle + "\', \'" + isPublicDb + "\', \'" + reqHeader +"\')");
			query = Database.executeQuery("SELECT PKey FROM Blogs WHERE Date=\'" + currentDate + "\' AND Title=\'" + reqTitle + "\'");
		}
		if(request.getParameter("editNewsArticleButton") != null) {
			String id = request.getParameter("newsId");
			Database.executeUpdate("UPDATE Blogs SET Date=\'" + currentDate + "\', Title=\'" + reqTitle + "\', IsPublic=\'" + isPublicDb + "\', Header=\'" + reqHeader +"\' WHERE PKey=" + id);
			query = Database.executeQuery("SELECT PKey FROM Blogs WHERE Pkey=" + id);
		}
		
		/**
		 * Find the path where the body txt file will go
		 */
		String origPath = "/Uploads/News/Body/Body";
		String[] splits = origPath.replaceAll("\\\\", "/").split("/");
		String fileName = splits[splits.length-1];
		String path = Main.context.getRealPath(origPath.substring(0,origPath.length()-fileName.length()));
		
		
		/**
		 * Create the file in the form of PKey_body.txt and write/overwrite to the file
		 */
		String pKey = query.get(0).get("PKey").toString();
		File file = new File(path +  pKey + "_body.txt");
		file.createNewFile();
		System.out.println(path + pKey + "_body.txt");
		FileOutputStream outFile = new FileOutputStream(file);
		outFile.write(reqBody.getBytes());
		outFile.close();
		
		/**
		 * Add the PKey to the id parameter in url so that user gets redirected to the page they just created/edited
		 */
		redirectLink = redirectLink + pKey;
		response.sendRedirect(redirectLink);
	}

}
