<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.io.output.*" %>
<%@ page import="project.Main" %>
<%@ page import="database.Database" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Guru File Upload</title>
</head>
<body>
<%
   File file ;
   int maxFileSize = 5000 * 1024;
   int maxMemSize = 5000 * 1024;
   String filePath = Main.context.getRealPath("/profile/pics/");
   
   String contentType = request.getContentType();
   if ((contentType.indexOf("multipart/form-data") >= 0)) {

      DiskFileItemFactory factory = new DiskFileItemFactory();
      factory.setSizeThreshold(maxMemSize);
      factory.setRepository(new File("c:\\temp"));
      ServletFileUpload upload = new ServletFileUpload(factory);
      upload.setSizeMax( maxFileSize );
      try{
         List fileItems = upload.parseRequest(request);
         Iterator i = fileItems.iterator();
         out.println("<html>");
         out.println("<body>");
         while ( i.hasNext () ) 
         {
            FileItem fi = (FileItem)i.next();
            if ( !fi.isFormField () )  {
                String fieldName = fi.getFieldName();
                // Below: fileName of uploaded file without file path
                // String fileName = fi.getName().replace("\\","/"); fileName = fileName.substring(fileName.lastIndexOf("/")+1);
                String fileName = session.getAttribute("accountPKey").toString();
                boolean isInMemory = fi.isInMemory();
                long sizeInBytes = fi.getSize();
                file = new File( filePath + fileName) ;
                fi.write( file ) ;
                out.println("Uploaded Filename: " + filePath + fileName + "<br>");
            }
         }
         out.println("</body>");
         out.println("</html>");
         
         response.sendRedirect(session.getAttribute("curPage").toString());
      }catch(Exception ex) {
         System.out.println(ex);
         ex.printStackTrace();
      }
   }else{
      out.println("<html>");
      out.println("<body>");
      out.println("<p>No file uploaded</p>"); 
      out.println("</body>");
      out.println("</html>");
   }
%>
</body>
</html>