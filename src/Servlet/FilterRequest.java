package Servlet;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(filterName = "FilterRequest",urlPatterns = "/*")
public class FilterRequest implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        System.out.println("start");
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request=(HttpServletRequest) servletRequest;
        HttpServletResponse response=(HttpServletResponse) servletResponse;
        servletRequest.setCharacterEncoding("utf-8");
        servletResponse.setCharacterEncoding("utf-8");
        String url=request.getServletPath();

        //放行登录界面
        if (url.equals("/login.html")||url.endsWith(".js")||url.endsWith(".css")||url.endsWith(".png")||
        url.endsWith(".jpg")||url.equals("/LoginServlet")||url.equals("/RegisterServlet")){
            filterChain.doFilter(servletRequest,servletResponse);
            return;
        }

        //拦截请求
        HttpSession session=request.getSession();
        Object object=session.getAttribute("uid");
        if (object==null){
            response.sendRedirect("/j2ee/login.html");
        }else {
            filterChain.doFilter(servletRequest,servletResponse);
        }
    }

    @Override
    public void destroy() {
        System.out.println("destroy");
    }
}
