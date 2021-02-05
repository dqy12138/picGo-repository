package Interceptor;

import Controller.getNews;
import POJO.DataShow;
import Service.DataShowService;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Date;


@Aspect
@Component
public class logInterceptor {

    private Logger logger = LoggerFactory.getLogger(getNews.class);
    private int userNumber,feedBackNumber,newsNumber;
    private DataShow dataShow=null;
    private Date now = new Date();
    private Boolean flag = false;

    @Resource
    private DataShowService dataShowService;


    @After(value = "execution(* Controller.UserController.preLogin(..))")
    public void loginAfter(JoinPoint joinPoint){
        Object[] args = joinPoint.getArgs();//获取访问的方法的参数
        for (Object arg : args) {
            System.out.println(arg);
        }
        logger.info(args[0]+"尝试登陆.....");
        String ip = ((HttpServletRequest)args[1]).getRemoteAddr();  //ip
        logger.info(ip);
        //尝试登录....
        if(dataShow==null){
            init(); //初始化登录人数
        }
        userNumber++;
        refresh(); //刷新登录人数
    }

    @After(value = "execution(* Controller.frontController.addNews(..))")
    public void addAfter(){
        //尝试登录....
        logger.info("addAfter.....");
        if(dataShow==null){
            init();
        }
        newsNumber++;
        refresh();
    }

    @After(value = "execution(* Controller.frontController.addFeedback(..))")
    public void feedbackAfter(){
        logger.info("loginAfter.....");
        if(dataShow==null){
            init();
        }
        feedBackNumber++;
        refresh();
    }

    public void init(){
        this.dataShow = dataShowService.queryLast();
        String oldString = new SimpleDateFormat("yyyy-MM-dd").format(dataShow.getDate());
        String nowString = new SimpleDateFormat("yyyy-MM-dd").format(now);
        if(oldString.equals(nowString)){
            userNumber = dataShow.getUserCount();
            feedBackNumber = dataShow.getFeedbackCount();
            newsNumber = dataShow.getNewsCount();
            flag = true;
        }else {
            dataShow = new DataShow();
            userNumber=0;
            newsNumber=0;
            feedBackNumber=0;
        }
    }

    public void refresh(){
        //todo 定时  通过时间判断是否访问数据库，修改数据
        //由于模拟需要，暂时不设置定时
        logger.info(""+flag);

        dataShow.setDate(new Date());
        dataShow.setFeedbackCount(feedBackNumber);  //反馈提交数
        dataShow.setNewsCount(newsNumber);  //新闻发布数
        dataShow.setUserCount(userNumber); //登录人数
        try{
            if(flag){
                dataShowService.updateByPrimaryKeySelective(dataShow);
            }else{
                dataShowService.insertSelective(dataShow);
                flag = true;
            }
        }catch (Exception e){
            e.printStackTrace();
            logger.info("更新数据库失败！！！");
        }
    }
}
