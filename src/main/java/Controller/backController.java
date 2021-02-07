package Controller;

import POJO.*;
import Service.DataShowService;
import Service.NewsService;
import Service.PicNewsService;
import Service.UsersService;
import com.alibaba.fastjson.JSON;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;

/**
 * 页面跳转以及初始化
 */
@Controller
@RequestMapping("/back")
public class backController {

    private Logger logger = LoggerFactory.getLogger(backController.class);

    @Resource
    private NewsService newsService;

    @Resource
    private PicNewsService picNewsService;

    @Resource
    private UsersService usersService;

    @Resource
    private DataShowService dataShowService;

    /**
     * 根据请求返回页面 ===> 后端各类页面页
     * begin
     */

    @RequestMapping("/showFeedback")
    public String showFeedback() {
        return "back/feedbackShow";
    }

    @RequestMapping("/index.html")
    public String showIndex() {
        return "back/index";
    }

    @RequestMapping("/login.html")
    public String showLogin(Model model,String code) {
        if(code!=null&&code.equals("1")) {
            model.addAttribute("code", 1);
            model.addAttribute("msg", "密码错误");
        }
        return "back/login";
    }
    /**
     *
     * @param model 附加参数 categoryId 轮播图类型
     * @return
     */
    @RequestMapping("/sliderShow")
    public String showSlider(Model model) {
        logger.info("sliderShow.......");

        List<PicNews> picNewsList = picNewsService.queryPicNewsByIsShownAndCategoryId((long)3);
        model.addAttribute("picNewsList", picNewsList);

        List<PicNews> picNewsListAll = picNewsService.queryPicNewsByCategoryId((long)3);
        model.addAttribute("picNewsListAll", picNewsListAll);

        return "back/sliderNew";
    }

    @RequestMapping("/interShow")
    public String showInter(Model model) {
        logger.info("interShow.......");

        List<PicNews> picNewsList = picNewsService.queryPicNewsByIsShownAndCategoryId((long)1);
        model.addAttribute("picNewsList", picNewsList);

        List<PicNews> picNewsListAll = picNewsService.queryPicNewsByCategoryId((long)1);
        model.addAttribute("allPicNewsList", picNewsListAll);

        return "back/international";
    }

    @RequestMapping("/boardShow")
    public String showBoard(Model model) {
        logger.info("init first page of showBoardNews......");
        List<boardNews> list = newsService.queryBoardNews((long)3);
        model.addAttribute("initBoardList",list);

        return "back/boardNew";
    }

    @RequestMapping("/auditingShow")
    public String showAuditing(Model model) {
        logger.info("init first page of News ... ");
        List<News> list = newsService.queryByPage(0, 7);
        model.addAttribute("newsList", list);
        return "/back/auditing";
    }

    @RequestMapping("/ManageUsersShow")
    public String showManageUsers(Model model) {
        logger.info("init first page of users ... ");
        List<Users> list = usersService.queryByPage(0, 7);
        model.addAttribute("usersList", list);
        return "back/manageUsers";
    }

    @RequestMapping("/adminShow")
    public String showAdmin() {
        return "back/adminDetail";
    }

    @RequestMapping("/dataShow")
    public String showData(Model model){
        logger.info("showData.........");
        List<DataShow> list = dataShowService.query();
        model.addAttribute("dataList", JSON.toJSONString(list));
        return "back/data";
    }


    @ResponseBody
    @RequestMapping("/feedbackData")
    public String feedbackShow(int limit,int offset,String search){
        logger.info(""+limit+"  "+offset+"  "+search);
        if(search.equals(""))
            search=null;
        HashMap<String,Object> map = dataShowService.queryAll(offset,limit,search);
        return JSON.toJSONString(map);
    }
    /**
     * 根据请求返回页面
     * end
     */

}
