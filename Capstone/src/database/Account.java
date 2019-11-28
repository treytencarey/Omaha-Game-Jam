package database;

import java.io.IOException;
import java.security.Key;
import java.util.List;
import java.util.Map;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import project.Admin;

import java.util.Base64;

/**
 * 
 * Handles all interactions between the site and an account.
 *
 */
@WebServlet("/accountServlet")
public class Account extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String USER_CLASS_ADMIN = "admin";
	private static final String USER_CLASS_USER = "user";

	/**
	 * Handles form submissions for the accountServlet.
	 * @param request the servlet request.
	 * @param response the servlet for response.
	 */
	protected void doPost(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);

		boolean loggingIn = request.getParameter("registerButton") != null || request.getParameter("loginButton") != null;
		if (loggingIn)
		{
			String email = request.getParameter("email");
			String password = request.getParameter("password");
			boolean registering = request.getParameter("registerButton") != null;

			if (registering)
			{
				String registerErr = register(email, password);
				if (registerErr.length() > 0)
				{
					response.setStatus(400);
					response.getWriter().print("Failed to create an account: " + registerErr);
					response.getWriter().flush();
					return;
				}
			}

			if (!login(email, password, session))
			{
				response.setStatus(400);
				response.getWriter().print("Email or password does not exist.");
				response.getWriter().flush();
				return;
			}

			response.sendRedirect(session.getAttribute("curPage").toString());
			return;
		}

		boolean loggingOut = request.getParameter("logout") != null;
		if (loggingOut)
		{
    		session.invalidate();
			response.sendRedirect("/Capstone/");
			return;
		}
	}

	/**
	 * Logs into the account for a user's session. Returns true if successful, false otherwise.
	 * Also sets session attributes based on the the user's successful login (such as the accountPKey and accountEmail attribute).
	 * 
	 * @param email a string of the email address (AKA username).
	 * @param password a string of the password (unencrypted).
	 * @param session the user's HttpSession.
	 * @return True if the login was successful, otherwise false.
	 */
	protected boolean login(String email, String password, HttpSession session)
	{
		try {
			password = encrypt(password);
		} catch (Exception e) {
			e.printStackTrace();
		}

		List<?> result = Database.executeQuery("SELECT PKey FROM Accounts WHERE lower(Email)=lower('" + email + "') AND Password='" + password + "'");
		
		if (result.size() > 0)
		{
			Map<?, ?> map = (Map<?, ?>) result.get(0);

			String accountPKey = map.get("PKey").toString();
			
			List<?> isAdmin = Database.executeQuery("SELECT AccountPKey FROM Admins WHERE AccountPKey = " + accountPKey);
			if(isAdmin.isEmpty()) {
				session.setAttribute("userClass", USER_CLASS_USER);
			}
			else {
				session.setAttribute("userClass", USER_CLASS_ADMIN);
			}
				
			session.setAttribute("accountPKey",accountPKey);
			session.setAttribute("accountEmail",email);
			
			return true;
		}
	    return false;
	}

	/**
	 * Registers an account. Returns true if successful, false otherwise.
	 * Note that the database contains triggers that can cause a fail if the email already exists, case-insensitive.
	 * @param email a string of the email address (AKA username).
	 * @param password a string of the password (unencrypted).
	 * @return True if the registration was successful, otherwise false.
	 */
	protected String register(String email, String password)
	{
		if (password.length() == 0)
			return "A password is required.";
		try {
			password = encrypt(password);
		} catch (Exception e) {
			e.printStackTrace();
		}
		//Database.executeUpdate("INSERT INTO AccountPermissions (Permissions) VALUES (" + 1 + ")");
		return Database.executeUpdate("INSERT INTO Accounts (Email, Password) VALUES ('" + email + "', '" + password + "')");
	}

	/**
	 * The encryption algorithm to be used.
	 */
	private static final String ALGORITHM = "AES";
	/**
	 * The encryption key value.
	 */
	private static final byte[] keyValue =
	    new byte[] { 'T', 'h', 'i', 's', 'I', 's', 'A', 'S', 'e', 'c', 'r', 'e', 't', 'K', 'e', 'y' };

	 /**
	  * Encrypts a string value using the encryption algorithm and key.
	  * @param valueToEnc a string of the value to be encrypted.
	  * @return A string of the valueToEnc string encrypted.
	  * @throws Exception
	  */
	 public static String encrypt(String valueToEnc) throws Exception {
	    Key key = generateKey();
	    Cipher c = Cipher.getInstance(ALGORITHM);
	    c.init(Cipher.ENCRYPT_MODE, key);
	    byte[] encValue = c.doFinal(valueToEnc.getBytes());
	    String encryptedValue = Base64.getEncoder().encodeToString(encValue); // new BASE64Encoder().encode(encValue);
	    return encryptedValue;
	}

	/**
	 * Generates a key for the encryption algorithm.
	 * @return A new key.
	 * @throws Exception
	 */
	private static Key generateKey() throws Exception {
	    Key key = new SecretKeySpec(keyValue, ALGORITHM);
	    return key;
	}
	
	/**
	 * Determines whether the logged-in user stored in the session is an admin or not.
	 * This doesn't contact the database, it simply checks for a session attribute that should be stored on login.
	 * @param session The session object to check.
	 * @return Whether user is an admin or not.
	 */
	public static boolean isAdmin(HttpSession session)
	{
		String uc = session.getAttribute("userClass").toString();
		return uc != null && uc.equals(USER_CLASS_ADMIN);
	}
}
