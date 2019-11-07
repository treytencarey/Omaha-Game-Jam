package database;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * 
 * Handles interactions between the news page on the site and news articles in database.
 *
 */
@WebServlet("/newsServlet")
public class News extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	/**
	 * The key of the news article.
	 */
	private int key;
	
	/**
	 * The title of the news article.
	 */
	private String title = "";
	/**
	 * The date of the news article.
	 */
	private String date = "";
	
	/**
	 * Handles form submissions for the newsServlet.
	 * @param request the servlet request.
	 * @param response the servlet for response.
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		//HttpSession session = request.getSession(false);
		//System.out.println(request.getParameter("article-title-input"));
	}
	
	/**
	 * Gets a News article from the database.
	 * @param PKey an integer value of the News article's primary key.
	 */
	public News(int PKey) {
		List<Map<String, Object>> query = Database.executeQuery("SELECT * FROM Blogs WHERE PKey=" + String.valueOf(PKey));
		
		if (query.size() == 0)
			throw new NullPointerException();
		Map<String, Object> newsPost = query.get(0);
		
		key = PKey;
		title = newsPost.get("Title").toString();
		date = newsPost.get("Date").toString();
	}
	
	
	/**
	 * Gets the total number of News articles in the database.
	 * @return The number of News articles in the database.
	 */
	public static int getNumOfNewsPosts() {
		List<Map<String, Object>> query = Database.executeQuery("SELECT COUNT(*) FROM Blogs");
		/**
		 * Above query prints one row, get the COUNT(*) value from that row and parse it to an integer to be returned
		 */
		String size = query.get(0).get("COUNT(*)").toString();
		return Integer.parseInt(size);
	}
	
	/**
	 * Gets PKeys for the six (or less) most recent public News articles in the database.
	 * @return The array of PKeys for the six (or less) most public News articles.
	 */
	public static int[] getMostRecentNewsPostsKeys() {
		int[] keys;
		ArrayList<Integer> keyList = new ArrayList<Integer>();
		List<Map<String, Object>> pKeyQuery = Database.executeQuery("SELECT PKey FROM Blogs WHERE IsPublic=1");
		List<Map<String, Object>> sizeQuery = Database.executeQuery("SELECT COUNT(*) FROM Blogs WHERE IsPublic=1");
		
		String size = sizeQuery.get(0).get("COUNT(*)").toString();
		int qSize = Integer.parseInt(size);
		int qSizeFloor = qSize - 6;
		if(qSizeFloor < 0) qSizeFloor = 0;
		
		for(int i = qSize; i > qSizeFloor; i--) {
			keyList.add(Integer.parseInt(pKeyQuery.get(i - 1).get("PKey").toString()));
		}
		
		keys = new int[(qSize - qSizeFloor)];
		for(int i = 0; i < keyList.size(); i++) {
			keys[i] = keyList.get(i);
		}
		
		return keys;
	}
	
	/**
	 * Gets the key of the News article.
	 * @return The key of the News article.
	 */
	public int getKey() {
		return this.key;
	}
	
	/**
	 * Gets the title of the News article.
	 * @return The title of the News article.
	 */
	public String getTitle() {
		return this.title;
	}
	
	/**
	 * Gets the date of the News article.
	 * @return The date of the News article.
	 */
	public String getDate() {
		return this.date;
	}
	
	public String getBody(String startPath, int key) {
		try {
			String body = "";
			String read = "";
			
			File f = new File(startPath + "/Uploads/News/Body/" + key + ".txt");
			BufferedReader bufferedReader = new BufferedReader(new FileReader(f));
			while((read = bufferedReader.readLine()) != null) {
				body = body + read + "\n";
			}
			bufferedReader.close();
			System.out.println(body);
			return body;
		} catch(Exception e) {
			System.err.println(e);
			return "Body not found";
		}
		
	}
}
