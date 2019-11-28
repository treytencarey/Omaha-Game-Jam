package beans;

public class Mutator {
	
	/*
	 * PKey for mutator event
	 */
	private String eventPKey;
	
	/*
	 * name of mutator
	 */
	private String name;
	
	/*
	 * description for mutator
	 */
	private String description;
	
	public Mutator(String pkey, String n, String d) {
		eventPKey = pkey;
		name = n;
		description = d;
	}
	
	public String getEventPKey() {
		return eventPKey;
	}
	
	public String getDescription() {
		return description;
	}
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setEventPKey(String eventPKey) {
		this.eventPKey = eventPKey;
	}

	public void setDescription(String description) {
		this.description = description;
	}
}
