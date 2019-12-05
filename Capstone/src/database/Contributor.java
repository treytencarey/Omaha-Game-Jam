package database;

import java.io.IOException;
import java.util.List;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Represents a single row from the Contributors table. This does not interact with the DB in any way.
 */
@WebServlet("/contributorServlet")
public class Contributor extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private String AccountPKey, GamePKey, RolePKey;
	
	/**
	 * Handles form submissions for the accountServlet.
	 * @param request the servlet request.
	 * @param response the servlet for response.
	 */
	protected void doPost(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		
		boolean gettingContributorsAutoComplete = request.getParameter("contributorAutoComplete") != null;
		if (gettingContributorsAutoComplete)
		{
			String inputValue = request.getParameter("inputValue");
			String inputName = request.getParameter("inputName");
			
			List<Map<String, Object>> allNames = Database.executeQuery("" +
					"SELECT Email FROM Accounts WHERE Email LIKE '" + inputValue + "%' " +
					"UNION " +
					"SELECT Name AS Email FROM Profiles WHERE Name LIKE '" + inputValue + "%' " +
				"");
			
			List<String> names = new ArrayList<String>();
			for (Map<String, Object> name : allNames)
				names.add("\"" + name.get("Email").toString() + "\"");

			String JS = "autocomplete(document.getElementsByName('" + inputName + "')[0], " + names.toString() + ");" +
						"document.getElementsByName('" + inputName + "')[0].dispatchEvent(new Event('input', {bubbled: true, cancelable: true}));";
			response.setStatus(200);
			response.getWriter().print(JS);
			response.getWriter().flush();
			
			return;
		}
	}
	
	/**
	 * Instantiate a Contributor with the passed arguments.
	 */
	public Contributor(String AccountPKey, String GamePKey, String RolePKey)
	{
		setAccountPKey(AccountPKey);
		setGamePKey(GamePKey);
		setRolePKey(RolePKey);
	}
	public Contributor(String AccountPKey, String RolePKey)
	{
		setAccountPKey(AccountPKey);
		setRolePKey(RolePKey);
	}
	public Contributor()
	{
		
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
