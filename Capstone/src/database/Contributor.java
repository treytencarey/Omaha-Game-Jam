package database;

/**
 * Represents a single row from the Contributors table. This does not interact with the DB in any way.
 */
public class Contributor {
	private String AccountPKey, GamePKey, RolePKey;
	
	/**
	 * Instantiate a Contributor with the passed arguments.
	 */
	public Contributor(String AccountPKey, String GamePKey, String RolePKey)
	{
		setAccountPKey(AccountPKey);
		setGamePKey(GamePKey);
		setRolePKey(RolePKey);
	}
	public String getAccountPKey() {
		return AccountPKey;
	}
	public void setAccountPKey(String accountPKey) {
		AccountPKey = accountPKey;
	}
	public String getGamePKey() {
		return GamePKey;
	}
	public void setGamePKey(String gamePKey) {
		GamePKey = gamePKey;
	}
	public String getRolePKey() {
		return RolePKey;
	}
	public void setRolePKey(String rolePKey) {
		RolePKey = rolePKey;
	}
	
	
}
