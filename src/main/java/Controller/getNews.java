package Controller;

import POJO.News;
import POJO.PicNews;
import POJO.Users;
import POJO.boardNews;

import java.util.*;

import Service.NewsService;
import Service.PicNewsService;
import Service.UsersService;
import com.alibaba.fastjson.JSON;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.enterprise.inject.New;
import javax.ws.rs.POST;

@Controller
@RequestMapping("/back")
public class getNews {

    private Logger logger = LoggerFactory.getLogger(getNews.class);
    @Resource
    private NewsService newsService;

    @Resource
    private PicNewsService picNewsService;
    /**
     * 获取 轮播图 新闻
     * @return
     */
    public String getSliderNews(){  //todo 未完成

        return "";
    }

    /**
     * @param categoryId
     * @return 获取板块新闻
     */
    @ResponseBody
    @GetMapping("/getBoardNews")
    public String getBoardNews(long categoryId){
        logger.info("getBoardNews......");
        List<boardNews> list = newsService.queryBoardNews(categoryId);
        return JSON.toJSONString(list);
    }

    /** 轮播begin
     * 交换状态
     * @param oldId
     * @param newId
     * @return
     */
    @PostMapping("/change")
    @ResponseBody
    public String change(long oldId,long newId){
        logger.info("exchange ==> "+oldId+"\t"+newId);
        if(picNewsService.exchangeState(oldId,newId)){
            return "1";
        }
        return "0";
    }

    /** 轮播end
     * 通过 id 获取新闻详情
     * @param id
     * @return
     */
    @ResponseBody
    @PostMapping(value = "/getNewsById")
    public String queryNewsById(Integer id){
        logger.info("getNewsById......."+id);
        News aNews = newsService.selectByPrimaryKey((long)id);
        return JSON.toJSONString(aNews);
    }



    /**
     * 通过 id、state 修改新闻状态
     * @param id
     * @param state
     * @return
     */
    @ResponseBody
    @PostMapping("/updateNewsSate")
    public String updateNewsSate(Integer id,int state){
        logger.info(id+"\t"+state);
        int result = newsService.updateNews(id,state);
        if(result>0)
            return "1";
        return "0";
    }


    /**
     * 获取板块新闻 ==>分页查询
     * @param categoryId
     * @param offset
     * @param row
     * @return
     */
    @PostMapping("/queryAllNewsByCategoryIdAndPage")
    @ResponseBody
    public String queryAllNewsByCategoryIdAndPage(long categoryId,int offset,int row){
        logger.info("queryAllNewsByCategoryIdAndPage.......");
        List<News> listOfAllByCategory = newsService.queryAllNewsByCategoryId(categoryId,offset,row);
        return JSON.toJSONString(listOfAllByCategory);
    }

    /**
     * 获取未选择的总数
     * @param categoryId
     * @return
     */
    @GetMapping("/countAllByCategoryId")
    @ResponseBody
    public String countAllByCategoryId(long categoryId){
        logger.info("countAllByCategoryId.......");
        int result = newsService.countAllByCategoryId(categoryId);
        return ""+result;
    }

    /**
     * 重新选取板块新闻
     * @param newsId20
     * @param newsId21
     * @return
     */
    @ResponseBody
    @PostMapping("/exchangeIsShown")
    public String exchangeIsShown(long newsId20,long newsId21){
        logger.info("exchangeIsShown.......");
        if(newsService.exchangeIsShown(newsId20,newsId21))
            return "1";
        return "0";
    }

    /**
     * 分页查询 ===> 所有新闻
     * @param offset
     * @return
     */
    @PostMapping(value = "/queryNewsPage", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String queryNewsPage(int offset) {
        logger.info("queryNewsPage.......");
        if (offset >= 1) {
            List<News> list = newsService.queryByPage((offset - 1) * 7, 7);
            return JSON.toJSONString(list);
        } else return null;
    }

    /**
     * 分页查询 ==> 所有新闻
     * @param offset
     * @param limit
     * @return
     */
    @PostMapping("/queryNewsByPage")
    @ResponseBody
    public String queryNewsByPage(int offset,int limit){
        logger.info("queryNewsByPage.......");
        List<News> list = newsService.queryByPage(offset, limit);
        return JSON.toJSONString(list);
    }

    /**
     * 获取 获取数据条数 ==> news
     * @return
     */
    @GetMapping("/countNewsAll")
    @ResponseBody
    public String countNewsAll() {
        logger.info("countNewsAll.........");
        Integer count = newsService.countAll();
        return count.toString();
    }

    /**
     * 通过 categoryId 查询已经选取的国内外新闻
     * @param categoryId
     * @return
     */
    @ResponseBody
    @PostMapping("/queryPicNews")
    public String queryPicNews(long categoryId){
        logger.info("queryPicNews.........");
        List<PicNews> list = picNewsService.queryPicNewsByIsShownAndCategoryId(categoryId);
        List<PicNews> allList = picNewsService.queryPicNewsByCategoryId(categoryId);

        HashMap<String,List<PicNews>> map = new HashMap<String, List<PicNews>>();
        map.put("list",list);
        map.put("allList",allList);

        return JSON.toJSONString(map);
    }

}
