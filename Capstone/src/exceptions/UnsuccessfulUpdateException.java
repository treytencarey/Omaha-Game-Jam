package exceptions;
/**
 * Should be thrown when a Database.executeUpdate() is unsuccessful.
 */
public class UnsuccessfulUpdateException extends Exception {
	private static final long serialVersionUID = 1L;
	private String query;
	private String message;
	
	/**
	 * Constructs a new UnsuccessfulUpdateException and sets the query and message.
	 * @param query The query that led to this Exception.
	 * @param message The resulting error message.
	 */
	public UnsuccessfulUpdateException(String query, String message)
	{
		this.query = query;
		this.message = message;
	}
	
	/**
	 * Returns the causing query.
	 * @return The query that caused this Exception.
	 */
	public String getQuery()
	{
		return this.query;
	}
	
	/**
	 * Returns the resulting message identifying the error.
	 * @return The resulting error message.
	 */
	public String getMessage()
	{
		return this.message;
	}
}
