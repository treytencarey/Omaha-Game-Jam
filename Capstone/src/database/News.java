package database;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;

@WebServlet("/newsServlet")
public class News extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private String title = "";
	private String date = "";
	
	
	public News(int PKey) {
		List<Map<String, Object>> query = Database.executeQuery("SELECT * FROM Blogs WHERE PKey=" + String.valueOf(PKey));
		
		if (query.size() == 0)
			throw new NullPointerException();
		Map<String, Object> newsPost = query.get(0);
		
		this.title = newsPost.get("Title").toString();
		this.date = newsPost.get("Date").toString(); //just for testing
	}
	
	public static int getNumOfNewsPosts() {
		List<Map<String, Object>> query = Database.executeQuery("SELECT COUNT(*) FROM Blogs");
		//above query prints one row, get the COUNT(*) value from that row and parse it to an integer to be returned
		String size = query.get(0).get("COUNT(*)").toString();
		return Integer.parseInt(size);
	}
	
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
	
	public String getTitle() {
		return this.title;
	}
	
	public String getDate() {
		return this.date;
	}
}
