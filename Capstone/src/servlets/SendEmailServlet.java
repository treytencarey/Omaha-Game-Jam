package servlets;

import java.io.IOException;
import java.text.ParseException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.EventTableBean;
import database.Database;
import utils.Mail;

/**
 * Servlet implementation class SendEmailServlet
 */
@WebServlet("/SendEmailServlet")
public class SendEmailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private Mail email;
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SendEmailServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		System.out.println("Made it to servlet");
		String emailAccount = request.getParameter("email");
		String emailPassword = request.getParameter("password");
		String subject = request.getParameter("email-subject");
		String body = request.getParameter("email-body");
		System.out.println(emailAccount+", "+emailPassword+", "+subject+", "+body);
		
		EventTableBean etb = new EventTableBean();
		
		List<Map<String, Object>> query = null;
		try {
			query = Database.executeQuery("SELECT * FROM Attendees WHERE EventPKey=" + etb.getCurrentEvent().getKey());
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		System.out.println("Attendees: "+query.size());
		String[] cC = new String[query.size()];
		System.out.println("cC length: "+cC.length);
		
		for(int i = 0; i < query.size(); i++) {
			List<Map<String, Object>> query2 = Database.executeQuery("SELECT * FROM Accounts WHERE PKey=" + query.get(i).get("AccountPKey").toString());
			
			cC[i] = query2.get(0).get("Email").toString();
		}
		
		email = new Mail(emailAccount,emailPassword,subject,body);
		email.prepareMessage();
		email.addRecipients(cC);
		try {
			email.sendMail();
		} catch (Exception e) {
			e.printStackTrace();
		}
		response.sendRedirect(request.getContextPath() + "/AdminPanel/");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
