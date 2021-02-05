package Controller;

import DAO.PicNewsMapper;
import POJO.*;
import Service.FrontService;
import Service.NewsService;
import Service.PicNewsService;
import Service.UsersService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

@Controller
@RequestMapping("/User")
public class UserController {

    @Autowired
    private UsersService userService;

    /**
     * 登陆页面，若密码错误，返回状态码：
     * 000  正确 001  密码错，未超3次 002  邮箱已注册，密码错三次 003  邮箱未注册
     *
     * @return
     */
    @RequestMapping("/preLogin")
    public void preLogin(Users user, HttpServletRequest request, HttpServletResponse response) throws IOException {
        int loginNum;
        String stateCode = "000";       //密码正确
        if (request.getSession().getAttribute("loginNum") == null) {
            request.getSession().setAttribute("loginNum", 1);
            loginNum = 1;
        } else {
            loginNum = (int) request.getSession().getAttribute("loginNum") + 1;
        }
        System.out.println(user);
        int code = userService.ValidateEmailName(user);
        if (code == 1) {
            request.getSession().removeAttribute("loginNum");
            System.out.println("成功登录");
            request.getSession().setAttribute("userS", userService.QueryUserByEmail(user.getUserEmail()));
            System.out.println(user.getUserEmail());
            System.out.println(userService.QueryUserByEmail(user.getUserEmail()));
            toLogin();
        } else {
            int emailCode = userService.ValidateEmail(user);
            if (emailCode == 0) {
                stateCode = "003";   //邮箱未注册
            } else {
                if (loginNum > 3) stateCode = "002";    //邮箱已注册，密码错三次
                else stateCode = "001";   //邮箱已注册，密码错未超过三次
            }
            request.getSession().setAttribute("loginNum", loginNum);
            System.out.println("账户密码不匹配");
        }
        response.getWriter().write(stateCode);
    }

    @RequestMapping("/validate")
    public void validate(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String validateCode = (String) request.getSession().getAttribute("validateCode");
        String userCode = request.getParameter("userCode");
        response.setHeader("Cache-Control", "no-cache");
        if (validateCode.equals(userCode)) {
            response.getWriter().write("1");
            System.out.println("验证成功");
        } else {
            response.getWriter().write("0");
        }
    }

    @RequestMapping("/send")//发送邮件
    public void sent(HttpServletRequest request, String address) {
        Send sentEmail = new Send(address, request);
        System.out.println("+++++++++++++++++++++++++++++");
        System.out.println(address);
        sentEmail.start();
    }

    @RequestMapping("/toEnroll")
    public String toEnroll(Users user) {
        // todo with mysql
        if (user == null || user.getUserName() == null || user.getUserName() == "" || user.getUserEmail() == ""
                || user.getUserPassword() == "")
            return "User/register";
        this.userService.SignIn(user);
        System.out.println(user);
        return "User/login";
    }

    @RequestMapping("/enroll")
    public String enroll() {
        return "User/register";  //跳转到注册页面
    }

    @RequestMapping("/toLogin")
    public String toLogin(){
        return "redirect:../front/index.html";
//        ModelAndView model =new ModelAndView("front/index");
//
//        List<PicNews> picNewsList = picNewsService.queryPicNewsByIsShownAndCategoryId((long)3);
//
//        model.addObject("picNewsList", picNewsList);
//
//        logger.info("boardNews.......");
//        HashMap<String,List<boardNews>> map = new HashMap<String, List<boardNews>>();
//        List<boardNews> list;
//
//        List<String> cat = Arrays.asList("文化新闻,体育新闻,娱乐新闻,科技新闻,教育新闻,汽车新闻".split(","));
//
//        for(long i=0;i<5;i++){
//            list = newsService.queryBoardNews(i+3);
//            map.put(cat.get((int)i), list);
//        }
//        logger.info("categorys.......");
//
//        model.addObject("boardNews",map);
//
//
//        model.addObject("categorys", frontService.QueryAllCategorys());
//
//        HashMap<String,List<PicNews>> picMap = new HashMap<String, List<PicNews>>(); //todo 新闻类别号
//        List<PicNews> picNewsList1 = picNewsService.queryPicNewsByIsShownAndCategoryId((long)1);
//        picMap.put("国内新闻",picNewsList1);
//        picNewsList1 = picNewsService.queryPicNewsByIsShownAndCategoryId((long)2);
//        picMap.put("国外新闻",picNewsList1);
//        logger.info("category.......");
//
//        model.addObject("international",picMap);
//
//        logger.info("ok.......");

//        logger.info("sliderShow.......");
//        ModelAndView mv=new ModelAndView("front/index");
//        List<PicNews> picNewsList = picNewsService.queryPicNewsByIsShownAndCategoryId((long)1);
//        mv.addObject("picNewsList", picNewsList);
//
//        HashMap<String,List<boardNews>> map = new HashMap<String, List<boardNews>>();
//        List<boardNews> list;
//
//        for(long i=1;i<=5;i++){
//            list = newsService.queryBoardNews(i);
//            map.put("categoryId-"+i,list);
//        }
//        mv.addObject("boardNews",map);
//        mv.addObject("categorys", frontService.QueryAllCategorys());
//        HashMap<String,List<PicNews>> picMap = new HashMap<String, List<PicNews>>(); //todo 新闻类别号
//        List<PicNews> picNewsList1 = picNewsService.queryPicNewsByIsShownAndCategoryId((long)1);
//        picMap.put("国内新闻",picNewsList1);
//        picNewsList1 = picNewsService.queryPicNewsByIsShownAndCategoryId((long)2);
//        picMap.put("国外新闻",picNewsList1);
//        mv.addObject("international",picMap);
//        ModelAndView model =new ModelAndView("front/index");
//        logger.info("sliderShow.......");
//        List<PicNews> picNewsList = picNewsService.queryPicNewsByIsShownAndCategoryId((long)3);
//        model.addObject("picNewsList", picNewsList);
//        logger.info("boardNews.......");
//        HashMap<String,List<boardNews>> map = new HashMap<String, List<boardNews>>();
//        List<boardNews> list;
//
//        model.addObject("categorys", frontService.QueryAllCategorys());
//
//
//        List<String> cat = Arrays.asList("军事新闻,文化新闻,体育新闻,娱乐新闻,科技新闻,教育新闻,汽车新闻".split(","));
//        for(long i=0;i<7;i++){
//            list = newsService.queryBoardNews(i+3);
//            map.put(cat.get((int)i), list);
//        }
//        logger.info("categorys.......");
//        model.addObject("boardNews",map);
//
//        HashMap<String,List<PicNews>> picMap = new HashMap<String, List<PicNews>>(); //todo 新闻类别号
//
//        /**
//         * 带图片的新闻
//         */
//        List<PicNews> picNewsList1 = picNewsService.queryPicNewsByIsShownAndCategoryId((long)1);
//        picMap.put("国内新闻",picNewsList1);
//        picNewsList1 = picNewsService.queryPicNewsByIsShownAndCategoryId((long)2);
//        picMap.put("国外新闻",picNewsList1);
//        /*picNewsList1 = picNewsService.queryPicNewsByIsShownAndCategoryId((long)1);
//        picMap.put("picNewsList",picNewsList1);*/
//        logger.info("category.......");
//        model.addObject("international",picMap);
//        logger.info("ok.......");
//        return model;
    }

    @RequestMapping("/login")
    public String login() {
        return "User/login";    //跳转到登录页面
    }

    @RequestMapping("/logout")
    public String logout(HttpSession session) {
        session.removeAttribute("userS");
        return "redirect:../front/index.html";
    }

    private Logger logger = LoggerFactory.getLogger(getNews.class);

    /**
     * 后端操作
     * @return
     */
    @RequestMapping("/toAdmin/login")
    public String toAdminLogin() {
        return "User/admin-login";
    }

    @PostMapping("/AdminLogin")
    public String AdminLogin(AdminUser user, Model model, HttpServletRequest request) {
        logger.info(user.toString());

        int result = userService.ValidateAdminUser(user);
        if (result > 0) {
            request.getSession().setAttribute("AdminUser", user);
            return "redirect:/back/index.html";
        } else {
            model.addAttribute("code", 1);
            return "redirect:/back/login.html";
        }
    }

    @ResponseBody
    @PostMapping("/logOut")
    public String AdminLogin(HttpServletRequest request) {
        logger.info("退出....");
        request.getSession().removeAttribute("AdminUser");
        return "1";
    }
}
