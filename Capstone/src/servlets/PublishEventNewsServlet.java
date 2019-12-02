package servlets;

import static java.nio.file.StandardCopyOption.REPLACE_EXISTING;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.FileSystems;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import beans.Event;

/**
 * Servlet implementation class PublishEventNewsServlet
 */
@WebServlet("/PublishServlet")
public class PublishEventNewsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PublishEventNewsServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		
		int isPublic = 0;
		Event current = new Event(request.getParameter("key"));
		if(current.IsPublic()) {
			isPublic = 1;
		}
		
		File file = new File(request.getContextPath()+"/Uploads/Events/HeaderImages/"+request.getParameter("key")+"_header.png");
		
		NewsServlet.addNewsArticle(current.getTitle(), current.getTheme(), current.getDescription(), isPublic, (Part) file);
		response.sendRedirect(request.getContextPath() + "/AdminPanel/");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
