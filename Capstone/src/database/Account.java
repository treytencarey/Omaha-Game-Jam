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

import project.User;
import project.Admin;

import java.util.Base64;

@WebServlet("/accountServlet")
public class Account extends HttpServlet {
	private static final long serialVersionUID = 1L;

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
					session.setAttribute("message", "<a style='color: red'>Failed to create an account: " + registerErr + "</a>");
					response.sendRedirect(session.getAttribute("curPage").toString());
					return;
				}
			}

			if (!login(email, password, session))
			{
				session.setAttribute("message", "<a style='color: red'>Email or password does not exist.</a>");
				response.sendRedirect(session.getAttribute("curPage").toString());
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

			List<?> result2 = Database.executeQuery("SELECT Permissions FROM AccountPermissions WHERE PKey = "+accountPKey);
			Map<?, ?> map2 = (Map<?, ?>) result2.get(0);
			int accountPermissions = Integer.parseInt(map2.get("Permissions").toString());
			
			session.setAttribute("accountPermissions", accountPermissions);
			session.setAttribute("accountPKey",accountPKey);
			session.setAttribute("accountEmail",email);
			
			return true;
		}
	    return false;
	}

	protected String register(String email, String password)
	{
		if (password.length() == 0)
			return "A password is required.";
		try {
			password = encrypt(password);
		} catch (Exception e) {
			e.printStackTrace();
		}
		Database.executeUpdate("INSERT INTO AccountPermissions (Permissions) VALUES (" + 1 + ")");
		return Database.executeUpdate("INSERT INTO Accounts (Email, Password) VALUES ('" + email + "', '" + password + "')");
	}

	private static final String ALGORITHM = "AES";
	private static final byte[] keyValue =
	    new byte[] { 'T', 'h', 'i', 's', 'I', 's', 'A', 'S', 'e', 'c', 'r', 'e', 't', 'K', 'e', 'y' };

	 public static String encrypt(String valueToEnc) throws Exception {
	    Key key = generateKey();
	    Cipher c = Cipher.getInstance(ALGORITHM);
	    c.init(Cipher.ENCRYPT_MODE, key);
	    byte[] encValue = c.doFinal(valueToEnc.getBytes());
	    String encryptedValue = Base64.getEncoder().encodeToString(encValue); // new BASE64Encoder().encode(encValue);
	    return encryptedValue;
	}

	private static Key generateKey() throws Exception {
	    Key key = new SecretKeySpec(keyValue, ALGORITHM);
	    return key;
	}
}
