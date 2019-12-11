package filters;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * Filter that intercepts all requests, determines if they came from an external website, and if so, sets the Session's "Referer" and "Landing" attributes.
 */
@WebFilter("/*")
public class RefererLandingStasherFilter implements Filter {

    /**
     * Default constructor. 
     */
    public RefererLandingStasherFilter() {
        // TODO Auto-generated constructor 
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
		
		HttpServletRequest httpRequest = (HttpServletRequest)request;
		HttpSession s = httpRequest.getSession();
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("MM/dd/yyyy"); // Stolen from NewsServlet
		String date = dtf.format(LocalDateTime.now());
		
		
		try
		{
			String referer = httpRequest.getHeader("referer"); // Will be null if coming to a website that doesn't set this.
			String landing = httpRequest.getRequestURL().toString();
			if (! referer.contains(httpRequest.getContextPath())) // Only record Referer and Landing if the user came from an external site.
			{	
				s.setAttribute("Referer", referer);
				s.setAttribute("Landing", landing);
			}
		}
		catch (NullPointerException npe) // After testing, this seems to only occur when the user directly types in the URL.
		{
//			System.out.println("HTTP header was probably null. So, the Session's Referer attribute will be null.");
//			npe.printStackTrace();
		}
		finally
		{
			s.setAttribute("AccessDate", date); // Set date no matter what (gets set not when they arrive, but at the last page they visit before their session expires).
			//System.out.println(date);
		}

		// pass the request along the filter chain
		chain.doFilter(request, response);
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
