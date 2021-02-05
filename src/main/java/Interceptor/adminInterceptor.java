package Interceptor;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class adminInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        String Url = request.getRequestURI();
        System.out.println("Url ==> "+Url);

        boolean flag = false;
        if(Url.indexOf("/back/") > 0) {   //  访问后台
            String ip = request.getRemoteAddr();
            System.out.println("ip ==> "+ip);
            if (ip.equals("0:0:0:0:0:0:0:1")) {
                System.out.println("本机ip，允许通过...");
                if(Url.indexOf("login") > 0 || request.getSession().getAttribute("AdminUser")!=null){
                    // 未登录 ==> login +已经登录 ==> session
                    System.out.println("login + session/......."+request.getSession().getAttribute("AdminUser"));
                    flag = true;
                }else{
                    System.out.println("Interceptor 不放行 ==> 未登录");
                    response.sendRedirect("../User/toAdmin/login");   //未登录
                }
            }
            else{
                System.out.println("Interceptor 不放行");
                response.sendRedirect("../User/info");   //ip不符合要求，直接跳转到前端首页
            }
        }else
            flag = true;
        return flag;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {

    }
}
