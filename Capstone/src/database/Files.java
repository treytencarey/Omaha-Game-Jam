package database;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;
import org.apache.tomcat.util.http.fileupload.servlet.ServletRequestContext;

import project.Main;

/**
 * 
 * Handles uploaded files by users.
 *
 */
@WebServlet("/filesServlet")
public class Files extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * Creates a primary key for a file being uploaded. This is used in the upload component only.
	 * This is for security reasons so that users cannot hack where files are uploaded to, yet we can dynamically control it ourselves in the backend.
	 * @param session the servlet session.
	 * @param path the full filepath of whether the file will be saved (note that in Eclipse, this is in .metadata).
	 * @return PKey a primary key of the next file.
	 */
	public static int setSessionNextUploadFile(HttpSession session, String path)
	{
		int PKey = 1;
		if (session.getAttribute("filesPKey") != null)
			PKey = Integer.parseInt(session.getAttribute("filesPKey").toString())+1;
		
		session.setAttribute("filesPKey", String.valueOf(PKey));
		session.setAttribute("filesPKeyPath" + String.valueOf(PKey), path);
		
		return PKey;
	}
	
	/**
	 * Gets the last Files.doPost() parameters for a session. This allows us to use the Files class
	 * for any forms that contain file(s), and then to get the params rather than re-implementing file upload per class that uses it.
	 * @param session the servlet session.
	 * @return A map of the params got by the doPost method.
	 */
	public static Map<String, String> getLastPostParams(HttpSession session)
	{
		return (Map<String, String>)session.getAttribute("filesPostParams");
	}
	
	/**
	 * Handles form submissions for the filesServlet.
	 * @param request the servlet request.
	 * @param response the servlet for response.
	 */
	protected void doPost(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		
		File file ;
		int maxFileSize = 5000 * 1024;
		int maxMemSize = 5000 * 1024;
		
		Map<String, String> postParams = new HashMap<String, String>();
		
		// Full file paths, so we can check if any of the same name has been uploaded (for input multiple)
		List<String> fullPaths = new ArrayList<String>();
		   
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
						String PKey = null;
						if (fi.getFieldName().indexOf("file") == 0)
							PKey = fi.getFieldName().substring("file".length());

						String fullPath = session.getAttribute("filesPKeyPath" + PKey).toString();
			    		
			    		String[] splits = fullPath.replaceAll("\\\\", "/").split("/");
			    		
			    		String fileName = splits[splits.length-1];
			    		String filePath = Main.context.getRealPath(fullPath.substring(0,fullPath.length()-fileName.length()));
						fullPath = filePath + fileName;
						
						int tries = 1;
						while (fullPaths.contains(fullPath)) {
							String ext = "";
							String fileNameNoExt = fileName;
							if (fileName.indexOf(".") >= 0) {
								ext = fileName.substring(fileName.lastIndexOf(".")+1);
								fileNameNoExt = fileName.substring(0,fileName.lastIndexOf("."));
							}
							fullPath = filePath + fileNameNoExt + " (" + String.valueOf(tries++) + ")." + ext;
						}
						fullPaths.add(fullPath);
			    		
						file = new File( fullPath ) ;
						fi.write( file ) ;
					}
					else
					{
						String fieldname = fi.getFieldName();
						String fieldvalue = fi.getString();
						postParams.put(fieldname, fieldvalue);
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
		session.setAttribute("filesPostParams", postParams);
		System.out.println(postParams);
	}
}
