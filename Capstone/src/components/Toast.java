package components;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import project.Main;

@WebServlet("/toastServlet")
public class Toast extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * Handles form submissions for the accountServlet.
	 * @param request the servlet request.
	 * @param response the servlet for response.
	 */
	protected void doPost(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		
		String toast = new String(Files.readAllBytes(Paths.get(Main.context.getRealPath("/components/toast.jsp"))))
					.replaceAll("\\[\\[TOASTTITLE\\]\\]", request.getParameter("RSVPToastTitle"))
					.replaceAll("\\[\\[TOASTMESSAGE\\]\\]", request.getParameter("RSVPToastMessage"));
		
		response.getWriter().print(toast);
	}
}
