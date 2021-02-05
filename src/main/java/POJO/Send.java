package POJO;

import org.springframework.context.ApplicationContext;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.servlet.http.HttpServletRequest;
import java.util.Random;

public class Send extends Thread{
    private String address;
    private HttpServletRequest request;

    public Send(String address, HttpServletRequest request) {
        this.address = address;
        this.request = request;
    }

    @Override
    public void run(){
        try{
            Random r = new Random();
            StringBuilder rs = new StringBuilder();
            for (int i = 0; i < 6; i++) {
                rs.append(r.nextInt(10));
            }
            System.out.println("验证码是: "+rs+"\t邮箱地址是: "+address);
            String msg = String.format("亲爱的用户,你好!你本次的验证码是:%s,此验证码仅用于用户注册.",rs);

            ApplicationContext act = WebApplicationContextUtils
                    .getWebApplicationContext(request.getServletContext());
            SimpleMailMessage message = (SimpleMailMessage) act.getBean("mailMessage");

            message.setSubject("注册-验证码");
            message.setText(msg);
            message.setTo(address);
            JavaMailSenderImpl sender = (JavaMailSenderImpl) act.getBean("mailSender");
            //sender.send(message);
            request.getSession().setAttribute("validateCode",rs.toString());
        }catch (Exception e){
            throw new RuntimeException(e);
        }
    }
}
