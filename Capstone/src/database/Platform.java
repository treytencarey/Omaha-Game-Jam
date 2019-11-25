package database;

import java.util.List;
import java.util.Map;

/**
 * Represents a single row from the Mutators table. This does not interact with the DB in any way.
 */
public class Platform{

	private Integer PKey;
	private String title;
	public Platform(String title) {
		this.setTitle(title);
	}
	public Platform(Integer PKey) {
		List<Map<String, Object>> res = Database.executeQuery("SELECT * FROM Platforms WHERE PKey=" + PKey);
		if (res.size() == 0)
			throw new NullPointerException();
		this.setTitle(res.get(0).get("Name").toString());
		this.setPKey(PKey);
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public Integer getPKey() {
		return PKey;
	}
	public void setPKey(Integer PKey) {
		this.PKey = PKey;
	}
}
