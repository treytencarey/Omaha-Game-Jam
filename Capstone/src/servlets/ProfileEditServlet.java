package servlets;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.FileSystems;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import beans.ProfileBean;
import exceptions.EmptyQueryException;
import exceptions.UnsuccessfulUpdateException;
import project.Main;

/**
 * Handles submissions from the Edit Profile modal, writing them to the DB and redirecting back to the Profile View page.
 */
@WebServlet("/profile_edit")
@MultipartConfig
public class ProfileEditServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	/**
	 * Handles all new changes submitted to a profile. Reverts profiles status back to 1 if currently a 2; back to 0 if currently a -1.
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id").toString();
		String newStatus = "1"; // Trusted but unverified by default
		try
		{
			ProfileBean old = new ProfileBean(id);
			newStatus = old.getStatus();
	
			if (old.getStatus().equals("2")) // If was verified, now trusted but unverified
				newStatus = "1";
			else if (old.getStatus().equals("-1")) // If was denied, now untrusted and unverified
				newStatus = "0";
		}
		catch (EmptyQueryException eqe)
		{
			System.out.println("From ProfileEditServlet: " + eqe.getQuery());
		}
		ProfileBean p = new ProfileBean(
				request.getParameter("id").toString(),
				request.getParameter("name").toString(),
				request.getParameter("bio").toString(),
				request.getParameter("site").toString(),
				request.getParameter("skills").toString(),
				newStatus );
		try
		{
			p.writeChanges();
		}
		catch (UnsuccessfulUpdateException uue)
		{
			System.out.println("Profile update unsuccessful.");
			System.out.println("From ProfileEditServlet:\n" + uue.getQuery() + "\n" + uue.getMessage());
		}
		
		Part picPart = request.getPart("pic");
		Path path = FileSystems.getDefault().getPath(Main.context.getRealPath("/Uploads/Profiles/Pics/" + p.getId()));

		//System.out.println("picPart size: " + picPart.getSize());
		if (picPart.getSize() > 0) // Only update/add a picture if the user selected one.
		{
			try (InputStream is = picPart.getInputStream())
			{
				Files.copy(is, path, StandardCopyOption.REPLACE_EXISTING);
			}
			catch (Exception e)
			{
				System.out.println("Error uploading the picture!");
				e.printStackTrace();
			}
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
