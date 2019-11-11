package database;

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
		if(id != null)
			request.getRequestDispatcher(SUCCESS_JSP).forward(request, response);
		else {
			request.getRequestDispatcher(DEFAULT_JSP).forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
		
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("MM/dd/yyyy");
		String currentDate = dtf.format(LocalDateTime.now());
		
		Database.executeUpdate("INSERT OR REPLACE INTO Blogs(Date, Title, IsPublic, Header) VALUES (\'" + currentDate + "\', \'" + reqTitle + "\', \'" + isPublicDb + "\', \'" + reqHeader +"\')");
		List<Map<String, Object>> query = Database.executeQuery("SELECT PKey FROM Blogs WHERE Date=\'" + currentDate + "\' AND Title=\'" + reqTitle + "\'");
		String path = request.getContextPath() + "/Uploads/News/Body/" + query.get(0).get("PKey").toString() + "_body.txt";
		//File file = new File(path);
		//file.createNewFile();
		//System.out.println(file.exists());
		/*
		FileOutputStream outFile = new FileOutputStream(file);
		outFile.write(reqBody.getBytes());
		outFile.close(); */
	}

}
