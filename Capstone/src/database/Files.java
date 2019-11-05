package database;

import java.io.File;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.RequestContext;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;
import org.apache.tomcat.util.http.fileupload.servlet.ServletRequestContext;

import project.Main;

@WebServlet("/filesServlet")
public class Files extends HttpServlet {
	protected void doPost(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		
		File file ;
		int maxFileSize = 5000 * 1024;
		int maxMemSize = 5000 * 1024;
		String fullPath = session.getAttribute("uploadFilePath").toString();
		String[] splits = fullPath.replaceAll("\\\\", "/").split("/");
		String fileName = splits[splits.length-1];
		String filePath = Main.context.getRealPath(fullPath.substring(0,fullPath.length()-fileName.length()));
		   
		String contentType = request.getContentType();
		if ((contentType.indexOf("multipart/form-data") >= 0)) {
			DiskFileItemFactory factory = new DiskFileItemFactory();
			factory.setSizeThreshold(maxMemSize);
			factory.setRepository(new File("c:\\temp"));
			ServletFileUpload upload = new ServletFileUpload(factory);
			upload.setSizeMax( maxFileSize );
			try{
				List<?> fileItems = upload.parseRequest(new ServletRequestContext(request));
				Iterator<?> i = fileItems.iterator();
				while ( i.hasNext () ) 
				{
					FileItem fi = (FileItem)i.next();
					if ( !fi.isFormField () )  {
						// Below: fileName of uploaded file without file path
						// String fileName = fi.getName().replace("\\","/"); fileName = fileName.substring(fileName.lastIndexOf("/")+1);
						// System.out.println("Uploading: " + filePath + fileName);
						file = new File( filePath + fileName) ;
						fi.write( file ) ;
					}
				}
				 
				response.sendRedirect(session.getAttribute("curPage").toString());
			}catch(Exception ex) {
				System.out.println(ex);
				ex.printStackTrace();
			}
		}else{
			// failed to upload file
		}
	}
}
