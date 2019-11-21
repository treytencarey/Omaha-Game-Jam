package exceptions;

/**
 * Should be thrown when a Database.executeQuery() returns 0 results.
 */
public class EmptyQueryException extends Exception {
	private static final long serialVersionUID = 1L;
	private String query;
	
	/**
	 * Constructs a new EmptyQueryException and sets the query.
	 * @param query The query that led to this Exception.
	 */
	public EmptyQueryException(String query)
	{
		this.query = query;
	}
	
	/**
	 * Returns the causing query.
	 * @return The query that caused this Exception.
	 */
	public String getQuery()
	{
		return this.query;
	}
}
