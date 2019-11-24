package database;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/sqlTableServlet")
public class SqlTable extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	/**
	 * Creates a primary key for an SQL statement. This is used in the sqlTable component only.
	 * This is for security reasons so that users cannot hack SQL statements, yet we can dynamically control it ourselves in the backend.
	 * @param session the servlet session.
	 * @param path the full filepath of whether the file will be saved (note that in Eclipse, this is in .metadata).
	 * @return PKey a primary key of the next file.
	 */
	public static int setSessionNextSQLStatement(HttpSession session, String sql)
	{
		int PKey = 1;
		if (session.getAttribute("sqlTablePKey") != null)
			PKey = Integer.parseInt(session.getAttribute("sqlTablePKey").toString())+1;
		
		session.setAttribute("sqlTablePKey", String.valueOf(PKey));
		session.setAttribute("sqlTablePKeyStatement" + String.valueOf(PKey), sql);
		
		return PKey;
	}
	
	/**
	 * Handles form submissions for the accountServlet.
	 * @param request the servlet request.
	 * @param response the servlet for response.
	 */
	protected void doPost(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);

		boolean gettingSQLTable = request.getParameter("sqlTable") != null;
		if (gettingSQLTable)
		{
			String PKey = request.getParameter("PKey");
			int page = Integer.valueOf(request.getParameter("page"))-1;
			int limit = 2;
			
			String SQL = session.getAttribute("sqlTablePKeyStatement" + PKey).toString();
			
			String SQLMax = "SELECT COUNT(*) as sqlTableCNT FROM (" + SQL + ")";
			List<Map<String, Object>> res = Database.executeQuery(SQLMax);
			int maxCount = Integer.parseInt(res.get(0).get("sqlTableCNT").toString());
			
			SQL ="SELECT * FROM (" + SQL + ") LIMIT " + String.valueOf(page*limit) + "," + String.valueOf(limit);
			res = Database.executeQuery(SQL);
			if (res.size() > 0)
			{
				String table = 	"<table class='table'>" +
								"	<thead>" +
								"		<tr>" +
								" 			<th scope='col'>#</th>";
				
				List<String> cols = new ArrayList<String>();
				for (Entry<String, Object> col : res.get(0).entrySet())
				{
					cols.add(col.getKey());
					table +=	" 			<th scope='col'>" + col.getKey() + "</th>";
				}
				
				table += 		"		</tr>" +
								"	</thead>" +
								"	<tbody>";
				int rowNum = page*limit;
				for (Map<String, Object> row : res)
				{
					table += 	"		<tr>" +
								"			<th scope='row'>" + String.valueOf(++rowNum) + "</th>";
					for (String col : cols)
					{
						table +="			<td>" + row.get(col) + "</td>";
					}
					
					table += 	"		</tr>";
				}
				table += 		"	</tbody>" +
								"</table>";
				
				table +=		"<a style='text-color: white;'>Showing " + String.valueOf(page*limit+1) + " to " + String.valueOf(page*limit+limit) + " of " + String.valueOf(maxCount) + " entries</a>";
				
				table +=		"<div style='content-align: center;'>" +
								"	<nav aria-label='Page navigation example'>" +
								"		<ul class='pagination justify-content-center'>" +
								"			<li class='page-item'>" +
								"				<a class='page-link ' " + (page > 0 ? "href='#' onclick='setSQLTablePage(" + String.valueOf(PKey) + ", " + String.valueOf(page) + ");'" : "disabled") + ">Previous</a>" +
								"			</li>" +
								"			<li class='page-item'>" +
								"				<a class='page-link' href='#' onclick='setSQLTablePage(" + String.valueOf(PKey) + ", " + String.valueOf(page == 0 || page == 1 ? 1 : page) + ");'>" + (page == 0 ? "<b>1</b>" : page == 1 ? "1" :  String.valueOf(page)) + "</a>" +
								"			</li>" +
								( maxCount-(page == 0 || page == 1 ? 1 : page)*limit > 0 ?
								"			<li class='page-item'>" +
								"				<a class='page-link' href='#' onclick='setSQLTablePage(" + String.valueOf(PKey) + ", " + String.valueOf(page == 0 || page == 1 ? 2 : page+1) + ");'>" + (page == 0 ? "2" : page == 1 ? "<b>2</b>" : "<b>" + String.valueOf(page+1)) + "</b>" + "</a>" +
								"			</li>"
								: "") +
								( maxCount-(page == 0 || page == 1 ? 2 : page+1)*limit > 0 ?
								"			<li class='page-item'>" +
								"				<a class='page-link' href='#' onclick='setSQLTablePage(" + String.valueOf(PKey) + ", " + String.valueOf(page == 0 || page == 1 ? 3 : page+2) + ");'>" + (page == 0 || page == 1 ? "3" : String.valueOf(page+2)) + "</a>" +
								"			</li>"
								: "" ) +
								"			<li class='page-item'>" +
								"				<a class='page-link' " + ( maxCount-(page+1)*limit > 0 ? "href='#' onclick='setSQLTablePage(" + String.valueOf(PKey) + ", " + String.valueOf(page+2) + ");'" : "disabled") + ">Next</a>" +
								"			</li>";
				
				response.getWriter().print(table);
			}
			else
			{
				response.setStatus(400);
				response.getWriter().print("No data found.");
			}
			return;
		}
	}
}
