package Interceptor;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class jspInterceptor implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        String Url = ((HttpServletRequest)request).getRequestURI();
        if(Url.indexOf("Module") > 0){
            System.out.println("URL 不放行");
            ((HttpServletResponse)response).sendError(404);
            return;
        }
        chain.doFilter(request,response);
    }

    @Override
    public void destroy() {

    }
}
