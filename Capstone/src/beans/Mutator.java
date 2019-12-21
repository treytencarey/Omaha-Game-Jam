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
	
	/**
	 * @param pkey Primary key in Mutators table
	 * @param n name
	 * @param d description
	 */
	public Mutator(String pkey, String n, String d) {
		eventPKey = pkey;
		name = n;
		description = d;
	}
	/**
	 * @return Mutator's primary key
	 */
	public String getEventPKey() {
		return eventPKey;
	}
	/**
	 * @return Mutator's description
	 */
	public String getDescription() {
		return description;
	}
	/**
	 * @return Mutator's name
	 */
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	/** 
	 * @param eventPKey Mutator's primary key
	 */
	public void setEventPKey(String eventPKey) {
		this.eventPKey = eventPKey;
	}
	/**
	 * @param description Mutator's description
	 */
	public void setDescription(String description) {
		this.description = description;
	}
}
