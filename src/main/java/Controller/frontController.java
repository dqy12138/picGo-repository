package Controller;

import DAO.PicNewsMapper;
import POJO.*;
import Service.FrontService;
import Service.NewsService;
import Service.PicNewsService;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
public class frontController {

    private Logger logger = LoggerFactory.getLogger(backController.class);

    @Autowired
    private FrontService frontService;

    @Resource
    private PicNewsMapper picNewsMapper;

    @Resource
    private PicNewsService picNewsService;

    @Resource
    private NewsService newsService;

    /**
     * 跳转到前端主页
     *
     * @return
     */
/*
    @RequestMapping("/news/index.html")
    public String toFrontIndex(Model model) {
        return "front/main";
    }
*/

    @RequestMapping("front/index.html")
    public String toIndex(Model model){
        logger.info("sliderShow.......");
        List<PicNews> picNewsList = picNewsService.queryPicNewsByIsShownAndCategoryId((long)3);
        model.addAttribute("picNewsList", picNewsList);
        logger.info("boardNews.......");
        HashMap<String,List<boardNews>> map = new HashMap<String, List<boardNews>>();
        List<boardNews> list;

        model.addAttribute("categorys", frontService.QueryAllCategorys());

        /*
             case "军事新闻": categoryId = 3; break;
                case "文化新闻": categoryId = 4; break;
                case "体育新闻": categoryId = 5; break;
                case "娱乐新闻": categoryId = 6; break;
                case "科技新闻": categoryId = 7; break;
                case "教育新闻": categoryId = 8; break;
                case "汽车新闻": categoryId = 9; break;
         */

        List<String> cat = Arrays.asList("军事新闻,文化新闻,体育新闻,娱乐新闻,科技新闻,教育新闻,汽车新闻".split(","));
        for(long i=0;i<7;i++){
            list = newsService.queryBoardNews(i+3);
            map.put(cat.get((int)i), list);
        }
        logger.info("categorys.......");
        model.addAttribute("boardNews",map);

        HashMap<String,List<PicNews>> picMap = new HashMap<String, List<PicNews>>(); //todo 新闻类别号

        /**
         * 带图片的新闻
          */
        List<PicNews> picNewsList1 = picNewsService.queryPicNewsByIsShownAndCategoryId((long)1);
        picMap.put("国内新闻",picNewsList1);
        picNewsList1 = picNewsService.queryPicNewsByIsShownAndCategoryId((long)2);
        picMap.put("国外新闻",picNewsList1);
        /*picNewsList1 = picNewsService.queryPicNewsByIsShownAndCategoryId((long)1);
        picMap.put("picNewsList",picNewsList1);*/
        logger.info("category.......");
        model.addAttribute("international",picMap);
        logger.info("ok.......");

        return "front/index";
    }

    @RequestMapping("queryMainNews")
    public ModelAndView queryMainNews() {
        ModelAndView mv = new ModelAndView("front/mainNews");
//        mv.addObject("newsLL", frontService.QueryNewsByCIds(5));
        return mv;
    }

    @RequestMapping("queryNewsByCId")
    public ModelAndView queryNewsByCid(@RequestParam("cid") long cid, @RequestParam(value = "cPage", required = false, defaultValue = "0") int cPage) {
        ModelAndView mv = new ModelAndView("front/news");
        List<News> newsL = frontService.QueryNewsByCId(cid, cPage);
        int total = frontService.QueryNewsTotalByCId(cid);
        int totalPage = (int) Math.ceil(total * 1.0 / 10);
        mv.addObject("cid", cid);
        mv.addObject("cPage", cPage);
        mv.addObject("totalPage", totalPage);
        mv.addObject("newsL", newsL);
        return mv;
    }

    @RequestMapping("queryNewsByCIdMore")
    @ResponseBody
    public String queryNewsByCIdMore(Model model, @RequestParam("cid") long cid, @RequestParam(value = "cPage", required = false, defaultValue = "0") int cPage) {
        Map<String, Object> map = new HashMap<String, Object>();
        List<News> newsL = frontService.QueryNewsByCId(cid, (cPage + 1) * 10);
        map.put("moreNews", newsL);
        map.put("cPage", cPage + 1);
        model.addAttribute("cPage", cPage + 1);
        JSON.DEFFAULT_DATE_FORMAT = "yyyy-MM-dd HH:mm:ss";
        return JSON.toJSONString(map, SerializerFeature.WriteDateUseDateFormat);
    }

    @RequestMapping("queryNewsByKey")
    public ModelAndView queryNewsByKey(@RequestParam("key") String key, @RequestParam(value = "cPage", required = false, defaultValue = "0") int cPage) {
        ModelAndView mv = new ModelAndView("front/searchNews");
        List<News> newsL = frontService.QueryNewsByKey(key, cPage);
        int total = frontService.QueryNewsTotalByKey(key);
        int totalPage = (int) Math.ceil(total * 1.0 / 10);
        mv.addObject("key", key);
        mv.addObject("cPage", cPage);
        mv.addObject("totalPage", totalPage);
        mv.addObject("newsL", newsL);
        return mv;
    }

    @RequestMapping("queryNewsByKeyMore")
    @ResponseBody
    public String queryNewsByKeyMore(Model model, @RequestParam("key") String key, @RequestParam(value = "cPage", required = false, defaultValue = "0") int cPage) {
        Map<String, Object> map = new HashMap<>();
        List<News> newsL = frontService.QueryNewsByKey(key, (cPage + 1) * 10);
        map.put("moreNews", newsL);
        map.put("cPage", cPage + 1);
        model.addAttribute("cPage", cPage + 1);
        JSON.DEFFAULT_DATE_FORMAT = "yyyy-MM-dd HH:mm:ss";
        return JSON.toJSONString(map, SerializerFeature.WriteDateUseDateFormat);
    }

    @RequestMapping("toEdit")
    public ModelAndView toEdit(@RequestParam("uid") long uid) {
        ModelAndView mv = new ModelAndView("front/edit");
        mv.addObject("categorys", frontService.QueryAllCategorys());
        mv.addObject("ownNews", frontService.QueryNewsByUId(uid));
        return mv;
    }

    @RequestMapping("addNews")
    @ResponseBody
    public String addNews(News news) {
        Map<String, Object> map = new HashMap<>();
        int result = frontService.AddNews(news);
        //添加新闻成功
        long categoryId = news.getCategoryId() > 2 ? 3 : news.getCategoryId();

        if (result >= 0) {
//            //获取新闻ID
//            int LastId = 0;
//            LastId = Integer.parseInt(news.getNewsId().toString());
            boolean flag = true;
            PicNews picNews;
            for (String pic_url : ImageUploadUtils.GetHtmlImageSrcList(news.getContent())) {
                Pics pic = new Pics();
                pic.setNewsId(news.getNewsId());
                pic.setPicUrl(pic_url);
                if (flag) {
                    picNews = new PicNews();
                    picNews.setNewsId(news.getNewsId());
                    picNews.setCategoryId(categoryId);
                    picNews.setTitle(news.getTitle());
                    picNews.setPicUrl(pic_url);
                    picNewsMapper.insertSelective(picNews);
                    flag = false;
                }
                frontService.AddPic(pic);
            }
            map.put("result", "success");
            map.put("newsId", news.getNewsId());
        } else {
            map.put("result", "fail");
            System.out.println("新闻增加失败");
        }
        JSON.DEFFAULT_DATE_FORMAT = "yyyy-MM-dd HH:mm:ss";
        return JSON.toJSONString(map, SerializerFeature.WriteDateUseDateFormat);
    }

    @RequestMapping("toUpdate")
    @ResponseBody
    public String toUpdate(@RequestParam("nid") long nid) {
        News news = frontService.QueryNewsById(nid);
        Map<String, Object> map = new HashMap<>();
        if (news != null) {
            map.put("result", "success");
            map.put("newsId", nid);
            map.put("categoryId", news.getCategoryId());
            map.put("title", news.getTitle());
            map.put("content", news.getContent());
        } else {
            map.put("result", "fail");
        }
        return JSON.toJSONString(map);
    }

    @RequestMapping("updateNews")
    @ResponseBody
    public String updateNews(News news) {
        Map<String, Object> map = new HashMap<>();
        int result = frontService.UpdateNews(news);
        if (result >= 0) {
            map.put("result", "success");
            map.put("newsId", news.getNewsId());
            System.out.println("新闻修改成功");
        } else {
            map.put("result", "fail");
            System.out.println("新闻修改失败");
        }
        return JSON.toJSONString(map);
    }

    @RequestMapping("deleteNews")
    @ResponseBody
    public String deleteNews(@RequestParam("nid") long nid) {
        int result = frontService.DeleteNews(nid);
        Map<String, Object> map = new HashMap<String, Object>();
        if (result > 0) {
            map.put("result", "success");
            System.out.println("新闻删除成功");
        } else {
            map.put("result", "fail");
            System.out.println("新闻删除失败");
        }
        return JSON.toJSONString(map);
    }

    @RequestMapping("queryNewsById")
    public ModelAndView queryNewsById(@RequestParam("nid") long nid) {
        ModelAndView mv = new ModelAndView("front/show");
        News news = frontService.QueryNewsById(nid);
        List<Comment> comments = frontService.QueryCommentsByNewsId(nid, 0);
        int total = frontService.QueryTotalCommentsByNewsId(nid);
        int totalPage = (int) Math.ceil(total * 1.0 / 3);
        mv.addObject("nid", nid);
        mv.addObject("news", news);
        mv.addObject("cPage", 0);
        mv.addObject("totalPage", totalPage);
        mv.addObject("comments", comments);
        return mv;
    }

    @RequestMapping("queryCommentByNIdMore")
    @ResponseBody
    public String queryCommentByNIdMore(@RequestParam("nid") long nid, @RequestParam(value = "cPage", required = false, defaultValue = "0") int cPage) {
        Map<String, Object> map = new HashMap<>();
        List<Comment> comments = frontService.QueryCommentsByNewsId(nid, (cPage + 1) * 3);
        map.put("moreComments", comments);
        map.put("cPage", cPage + 1);
        JSON.DEFFAULT_DATE_FORMAT = "yyyy-MM-dd HH:mm:ss";
        return JSON.toJSONString(map, SerializerFeature.WriteDateUseDateFormat);
    }


    @RequestMapping(value = "addComment", produces = "text/json;charset=UTF-8")
    @ResponseBody
    public String addComment(Comment comment) {
        int result = frontService.AddComment(comment);
        Map<String, Object> map = new HashMap<String, Object>();
        if (result > 0) {
            long LastId = comment.getComment_id();
            map.put("result", "success");
            map.put("cid", LastId);
            System.out.println("评论成功");
        } else {
            map.put("result", "fail");
            System.out.println("评论失败");
        }
        return JSON.toJSONString(map);
    }

    @RequestMapping(value = "deleteComment", produces = "text/json;charset=UTF-8")
    @ResponseBody
    public String deleteComment(@RequestParam("cid") long cid) {
        int result = frontService.DeleteComment(cid);
        Map<String, Object> map = new HashMap<String, Object>();
        if (result > 0) {
            map.put("result", "success");
            System.out.println("评论删除成功");
        } else {
            map.put("result", "fail");
            System.out.println("评论删除失败");
        }
        return JSON.toJSONString(map);
    }

    @RequestMapping("queryUserById")
    public String queryUserById(@RequestParam("uid") long uid, Model model) {
        Users user = frontService.QueryUserById(uid);
        List<News> newsL = frontService.QueryNewsByUId(uid);
        List<Comment> comments = frontService.QueryCommentsByUserId(uid);
        List<Feedback> feedbacks = frontService.QueryFeedbackByUId(uid);
        model.addAttribute("user", user);
        model.addAttribute("newsL", newsL);
        model.addAttribute("comments", comments);
        model.addAttribute("feedbacks", feedbacks);
        return "front/userDetail";
    }

    @RequestMapping("queryUser")
    public String queryUser() {
        return "front/userInfo";
    }

    @RequestMapping("queryUserInfo")
    public ModelAndView queryUserInfo(@RequestParam("uid") long uid) {
        ModelAndView mv = new ModelAndView("front/Info");
        Users user = frontService.QueryUserById(uid);
        mv.addObject("user", user);
        return mv;
    }

    @RequestMapping("queryUserPwd")
    public ModelAndView queryUserPwd(@RequestParam("uid") long uid) {
        ModelAndView mv = new ModelAndView("front/pwd");
        Users user = frontService.QueryUserById(uid);
        mv.addObject("user", user);
        return mv;
    }
    @RequestMapping("userDanger")
    public String userDanger(){return "front/misc";}

    @RequestMapping(value = "updateUserByUId", produces = "text/json;charset=UTF-8")
    @ResponseBody
    public String updateUserByUId(Users users,HttpSession session) {
        Map<String, Object> map = new HashMap<>();
        int result = frontService.updateUserByUId(users);
        if (result > 0) {
            map.put("result", "success");
            session.setAttribute("userS",users);
            System.out.println("修改成功");
        } else {
            map.put("result", "error");
            System.out.println("修改异常");
        }
        return JSON.toJSONString(map);
    }

    @RequestMapping(value = "updatePwd", produces = "text/json;charset=UTF-8")
    @ResponseBody
    public String updatePwd(@RequestParam("oldPwd") String oldPwd, @RequestParam("newPwd") String newPwd, HttpSession session) {
        Users user = (Users) session.getAttribute("userS");
        Map<String, Object> map = new HashMap<>();
        System.out.println(user.getUserPassword());
        System.out.println(oldPwd);
        System.out.println(newPwd);
        if (oldPwd.equals(user.getUserPassword())) {
            long uid = user.getUserId();
            int result = frontService.updatePwdByUId(newPwd, uid);
            if (result > 0) {
                map.put("result", "success");
                System.out.println("修改成功");
                session.invalidate();
            } else {
                map.put("result", "error");
                System.out.println("修改异常");
            }
        } else {
            map.put("result", "fail");
            System.out.println("原密码不正确");
        }
        return JSON.toJSONString(map);
    }
    @RequestMapping("toHelp")
    public String toHelp(){return "front/help";}

    @RequestMapping("toFeedback")
    public String toFeedback() {
        return "front/feedback";
    }

    @RequestMapping("addFeedback")
    @ResponseBody
    public String addFeedback(Feedback feedback) {
        int result = frontService.AddFeedback(feedback);
        Map<String, Object> map = new HashMap<>();
        if (result > 0) {
            map.put("result", "success");
            map.put("uid", feedback.getUser_id());
            System.out.println("反馈成功");
        } else {
            map.put("result", "fail");
            System.out.println("反馈失败");
        }
        logger.info("loginAfter.....");
        return JSON.toJSONString(map);
    }

    @RequestMapping(value = "deleteFeedback")
    @ResponseBody
    public String deleteFeedback(@RequestParam("fid") long fid) {
        int result = frontService.DeleteFeedback(fid);
        Map<String, Object> map = new HashMap<>();
        if (result > 0) {
            map.put("result", "success");
            System.out.println("反馈删除成功");
        } else {
            map.put("result", "fail");
            System.out.println("反馈删除失败");
        }
        return JSON.toJSONString(map);
    }


    /**
     * 实现图片上传至本地
     *
     * @param request
     * @param response
     */
    @RequestMapping(value = "uploadImage")
    public void uploadSource(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("up");
        String DirectoryName = "Static/img";
        try {
            ImageUploadUtils.ckeditor(request, response, DirectoryName);
        } catch (IllegalStateException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    //图片上传测试
    @ResponseBody
    @RequestMapping("uploadUserIcon")
    public Map upload(MultipartFile file, HttpSession session){

        Users users= (Users) session.getAttribute("userS");
        String prefix="";
        String myFileName=users.getUserId()+"_icon";
        //保存上传
        OutputStream out = null;
        InputStream fileInput=null;
        try{
            if(file!=null){
                String originalName = file.getOriginalFilename();
                prefix=originalName.substring(originalName.lastIndexOf(".")+1);

                String filepath = session.getServletContext().getRealPath("/Static/img");
                String fileName = filepath +"\\"+myFileName+"." + prefix;

                File files=new File(fileName);
                //打印查看上传路径
                System.out.println(filepath);
                if(!files.getParentFile().exists()){
                    files.getParentFile().mkdirs();
                }
                file.transferTo(files);
                Map<String,Object> map2=new HashMap<>();
                Map<String,Object> map=new HashMap<>();
                map.put("code",0);
                map.put("msg","");
                map.put("data",map2);
                map2.put("src","/Static/img/"+myFileName+"." + prefix);
                return map;
            }

        }catch (Exception e){
        }finally{
            try {
                if(out!=null){
                    out.close();
                }
                if(fileInput!=null){
                    fileInput.close();
                }
            } catch (IOException e) {
            }
        }
        Map<String,Object> map=new HashMap<>();
        map.put("code",1);
        map.put("msg","");
        return map;
    }


}
