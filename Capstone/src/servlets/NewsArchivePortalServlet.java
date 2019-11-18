package servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.News;
import database.Database;

@WebServlet("/NewsArchivePortalServlet")
public class NewsArchivePortalServlet extends HttpServlet {
	private static final long serialVersionUID = -3181407903760153532L;
	/**
     * @see HttpServlet#HttpServlet()
     */
	
    public NewsArchivePortalServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String year = request.getParameter("year");
		List<Map<String, Object>> query = Database.executeQuery("SELECT PKey FROM Blogs WHERE Date LIKE \'%" + year + "%\' AND IsPublic = 1");
		int yearTest;
		
		try {
			yearTest = Integer.parseInt(year);
		} catch (NumberFormatException e) {
			response.getWriter().append("Invalid year (empty or not in format XXXX)");
			return;
		}
		
		News[] news = new News[query.size()];
		for(int i = 0; i < news.length; i++) {
			news[i] = new News(Integer.parseInt(query.get(i).get("PKey").toString()));
		}
		
		query = Database.executeQuery("SELECT MAX(Date) as maxDate, MIN(Date) as minDate FROM Blogs");
		String minYear = query.get(0).get("minDate").toString().split("/")[2];
		String maxYear = query.get(0).get("maxDate").toString().split("/")[2];
		
		request.setAttribute("newsPosts", news);
		request.setAttribute("minYear", Integer.parseInt(minYear));
		request.setAttribute("maxYear", Integer.parseInt(maxYear));
		request.getRequestDispatcher("news_archive.jsp").forward(request, response);
	}
}
