package filters;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;

/**
 * Filter that, after EventServlet has finished, sets the Session's "RSVPdEventPKey" attribute if RSVPing was successful.
 */
@WebFilter("/EventServlet")
public class RSVPStasherFilter implements Filter {

    /**
     * Default constructor. 
     */
    public RSVPStasherFilter() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		// pass the request along the filter chain
		chain.doFilter(request, response);
		//Done after EventServlet
		HttpServletRequest httpRequest;
		try
		{
			httpRequest = (HttpServletRequest)request;
			Object epko = request.getAttribute("EventPKey"); // Null if unsuccessfully RSVP; otherwise contains EventPKey of RSVP'd event
			if (epko != null)
				httpRequest.getSession().setAttribute("RSVPdEventPKey", epko.toString());
		}
		catch (Exception e)
		{
			System.out.println("RSVPStasherFilter couldn't cast the request to HTTP. So, the Session's RSVPdEventPKey attribute will be null.");
		}
		
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
