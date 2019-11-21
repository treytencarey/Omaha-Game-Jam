package servlets;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.FileSystems;
import java.nio.file.Files;
import java.nio.file.Path;
import static java.nio.file.StandardCopyOption.REPLACE_EXISTING;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import beans.ProfileBean;
import project.Main;

/**
 * Handles submissions from the Edit Profile modal, writing them to the DB and redirecting back to the Profile View page.
 */
@WebServlet("/profile_edit")
@MultipartConfig
public class ProfileEditServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ProfileBean p = new ProfileBean( request.getParameter("id").toString(), request.getParameter("name").toString(), request.getParameter("bio").toString(), request.getParameter("site").toString(), request.getParameter("skills").toString() );
		p.writeChanges();
		
		Part picPart = request.getPart("pic");
		Path path = FileSystems.getDefault().getPath(Main.context.getRealPath("/Uploads/Profiles/Pics/" + p.getId()));
		//System.out.println(path);
		
		try (InputStream is = picPart.getInputStream())
		{
			Files.copy(is, path, REPLACE_EXISTING);
		}
		
		response.sendRedirect("profile?id=" + p.getId());
	}
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
