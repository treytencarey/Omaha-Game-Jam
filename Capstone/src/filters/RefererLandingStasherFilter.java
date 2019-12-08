package filters;

import java.io.File;
import java.io.FileWriter;
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
		HttpServletRequest httpRequest;
		try
		{
			httpRequest = (HttpServletRequest)request;
			String referer = httpRequest.getHeader("referer");
			String landing = httpRequest.getRequestURL().toString();
			if (! referer.contains(httpRequest.getContextPath())) // Gets called for a bunch of stuff including image requests
			{
				httpRequest.getSession().setAttribute("Referer", referer);
				httpRequest.getSession().setAttribute("Landing", landing);
			}
		}
		catch (Exception e)
		{
			// After testing, this seems to only occur when the user directly types in the URL.
			System.out.println("RefererLoggerFilter couldn't cast the request to HTTP. So, the Session's Referer attribute will be null.");
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
