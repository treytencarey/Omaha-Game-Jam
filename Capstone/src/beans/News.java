package beans;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.annotation.WebServlet;

import database.Database;
import project.Main;

/**
 * 
 * Handles interactions between the news page on the site and news articles in database.
 *
 */
public class News {
	private static final long serialVersionUID = 256L;
	
	/**
	 * The key of the news article.
	 */
	private int key;
	
	/**
	 * The title of the news article.
	 */
	private String title = "";
	
	/**
	 * The header of the news article.
	 */
	private String header = "";
	
	/**
	 * The date of the news article.
	 */
	private String date = "";
	
	/**
	 * The date of the news article.
	 */
	private int isPublic = 0;
	
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
		header = newsPost.get("Header").toString();
		date = newsPost.get("Date").toString();
		isPublic = Integer.parseInt(newsPost.get("IsPublic").toString());
	}
	
	/**
	 * Creates blank News article.
	 */
	public News() {
		
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
	 * Gets PKeys for the most recent public News articles in the database.
	 * @param a - Number of PKeys to get
	 * @param p - PKey to exclude from array
	 * @param pub - If the news articles include public articles (0 to include them, else do not)
	 * @return The array of PKeys for the News articles
	 */
	public static int[] getMostRecentNewsPostsKeys(int a, int p , int pub) {
		String kQueryString, sQueryString;
		
		if(pub == 0) {
			kQueryString = "SELECT PKey FROM Blogs WHERE NOT PKey=\'" + Integer.toString(p) + "\'";
			sQueryString = "SELECT COUNT(*) FROM Blogs WHERE NOT PKey=\'" + Integer.toString(p) + "\'";
		}
		else {
			kQueryString = "SELECT PKey FROM Blogs WHERE IsPublic=1 AND NOT PKey=\'" + Integer.toString(p) + "\'";
			sQueryString = "SELECT COUNT(*) FROM Blogs WHERE IsPublic=1 AND NOT PKey=\'" + Integer.toString(p) + "\'";
		}
		
		return queryNewsDatabase(a, kQueryString, sQueryString);
	}
	
	/**
	 * Queries the news table in the table and returns PKeys of articles depending on entered queries
	 * @param pKeyNum - Number of PKeys to get
	 * @param kQuery - Query of what PKeys to get from database
	 * @param sQuery - Query of COUNT of PKeys in database
	 * @return The array of PKeys from the database
	 */
	static int[] queryNewsDatabase(int pKeyNum, String kQuery, String sQuery) {
		int[] keys;
		ArrayList<Integer> keyList = new ArrayList<Integer>();
		
		List<Map<String, Object>> pKeyQuery = Database.executeQuery(kQuery);
		List<Map<String, Object>> sizeQuery = Database.executeQuery(sQuery);
		
		String size = sizeQuery.get(0).get("COUNT(*)").toString();
		int qSize = Integer.parseInt(size);
		int qSizeFloor = qSize - pKeyNum;
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
	 * Gets the header of the News article.
	 * @return The header of the News article.
	 */
	public String getHeader() {
		return this.header;
	}
	
	/**
	 * Gets the date of the News article.
	 * @return The date of the News article.
	 */
	public String getDate() {
		return this.date;
	}
	
	/**
	 * Gets the public status of the News article.
	 * @return The public status of the News article.
	 */
	public int getIsPublic() {
		return this.isPublic;
	}
	
	/**
	 * Gets the body of the article from a txt file corresponding to PKey
	 * @return the body of the article as a String
	 */
	public String getBody() {
		try {
			String body = "";
			String read = "";
			
			String origPath = "/Uploads/News/Body/Body";
			String[] splits = origPath.replaceAll("\\\\", "/").split("/");
			String fileName = splits[splits.length-1];
			String path = Main.context.getRealPath(origPath.substring(0,origPath.length()-fileName.length()));
			
			File file = new File(path + key + "_body.txt");
			BufferedReader bufferedReader = new BufferedReader(new FileReader(file));
			while((read = bufferedReader.readLine()) != null) {
				body = body + read;
			}
			bufferedReader.close();
			return body;
		} catch(Exception e) {
			System.err.println(e);
			return "Body not found";
		}
		
	}
}
