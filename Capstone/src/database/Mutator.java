package database;

/**
 * Represents a single row from the Mutators table. This does not interact with the DB in any way.
 */
public class Mutator{

	private String title, desc;
	public Mutator(String title, String desc) {
		this.setTitle(title);
		this.setDesc(desc);
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getDesc() {
		return desc;
	}
	public void setDesc(String desc) {
		this.desc = desc;
	}
	
}
