package models;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.*;

@WebFilter("/secure/*")
public class AuthenticationFilter implements Filter {
    public void init(FilterConfig config) throws ServletException {
    }

    public void destroy() {
    }

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpSession session = req.getSession(false);

        // Check if user is logged in
        if (session == null || session.getAttribute("user_id") == null) {
            // Not logged in, redirect to login page
            HttpServletResponse res = (HttpServletResponse) response;
            res.sendRedirect(req.getContextPath() + "/login.jsp");
        } else {
            // Logged in, proceed with the request
            chain.doFilter(request, response);
        }
    }
}
