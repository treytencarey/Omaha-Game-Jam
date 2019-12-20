package servlets;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import project.Main;

/**
 * Servlet implementation class AlterSiteServlet
 */
@WebServlet("/AlterSiteServlet")
public class AlterSiteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AlterSiteServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(request.getParameter("changeSiteDescBtn") != null) {
			String path = getServerPath("/Uploads/Site/Site");
			createFile("sitedescription", path, request.getParameter("siteDescription"));
			response.sendRedirect(request.getContextPath() + "/index.jsp");
		}
	}

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
