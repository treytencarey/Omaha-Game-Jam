package database;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;

/**
 * 
 * Handles interactions between the news page on the site and news articles in database.
 *
 */
@WebServlet("/newsServlet")
public class News extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	/**
	 * The title of the news article.
	 */
	private String title = "";
	/**
	 * The date of the news article.
	 */
	private String date = "";
	
	/**
	 * Gets a News article from the database.
	 * @param PKey an integer value of the News article's primary key.
	 */
	public News(int PKey) {
		List<Map<String, Object>> query = Database.executeQuery("SELECT * FROM Blogs WHERE PKey=" + String.valueOf(PKey));
		
		if (query.size() == 0)
			throw new NullPointerException();
		Map<String, Object> newsPost = query.get(0);
		
		this.title = newsPost.get("Title").toString();
		this.date = newsPost.get("Date").toString();
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
}
