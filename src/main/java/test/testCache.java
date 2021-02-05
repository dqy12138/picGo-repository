package test;

import DAO.*;
import POJO.*;
import com.alibaba.fastjson.JSON;
import org.junit.jupiter.api.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.awt.*;
import java.util.Date;
import java.util.List;

public class testCache {

    @Test
    public void testO2J() {
        ApplicationContext act = new ClassPathXmlApplicationContext
                ("applicationContext.xml");
        NewsMapper newsMapper = act.getBean(NewsMapper.class);
        News aNews = newsMapper.selectByPrimaryKey((long) 1);
        String userJson = JSON.toJSONString(aNews);

        System.out.println(aNews);
        System.out.println(userJson);
    }

    @Test
    public void testPageQuery() {
        ApplicationContext act = new ClassPathXmlApplicationContext
                ("applicationContext.xml");
        NewsMapper newsMapper = act.getBean(NewsMapper.class);

        List<News> list = newsMapper.queryAllNewsByCategoryId(1, 0, 10);
        for (News aNews : list)
            System.out.println(aNews);
    }

    @Test
    public void testQueryUserById() {
        ApplicationContext act = new ClassPathXmlApplicationContext
                ("applicationContext.xml");
        UsersMapper userMapper = act.getBean(UsersMapper.class);


        System.out.println(userMapper.countAll());
    }

    @Test
    public void testDateTime() {
        ApplicationContext act = new ClassPathXmlApplicationContext
                ("applicationContext.xml");
        NewsMapper userMapper = act.getBean(NewsMapper.class);
        News news = userMapper.selectByPrimaryKey((long) 28);
        System.out.println(news.getCreateTime().getTime());

        System.out.println(JSON.toJSONString(news));

    }

    @Test
    public void testBoardNews() {
        ApplicationContext act = new ClassPathXmlApplicationContext
                ("applicationContext.xml");
        NewsMapper userMapper = act.getBean(NewsMapper.class);
        List<boardNews> list = userMapper.queryBoardNews((long) 2);
        for (boardNews board : list)
            System.out.println(board);
    }

    @Test
    public void testQueryPicNewsByStateAndCategoryId() {
        ApplicationContext act = new ClassPathXmlApplicationContext
                ("applicationContext.xml");
        PicNewsMapper userMapper = act.getBean(PicNewsMapper.class);

        List<PicNews> picNewsListAll = userMapper.queryPicNewsByIsShownAndCategoryId(1);
        for (PicNews board : picNewsListAll)
            System.out.println(board);
    }

    @Test
    public void testStringToArray() {
        ApplicationContext act = new ClassPathXmlApplicationContext
                ("applicationContext.xml");
        PicNewsMapper userMapper = act.getBean(PicNewsMapper.class);

        int result = userMapper.count((long) 46);
        System.out.println(result);
    }

    @Test
    public void testNews1212() {
        ApplicationContext act = new ClassPathXmlApplicationContext
                ("applicationContext.xml");
        /*FrontMapper frontMapper = act.getBean(FrontMapper.class);

        List<News> list = frontMapper.QueryNewsByCId((long)3);
        for (News a:list){
            System.out.println(a);
        }*/
//        DataShowService dataShowService = act.getBean(DataShowService.class);
//
//        List<DataShow> list = dataShowService.queryData();
//        System.out.println(list.toString());

//        DataShowMapper dataShowMapper = act.getBean(DataShowMapper.class);
////        List<DataShow> list = dataShowMapper.query();
////        System.out.println(list);
////        DataShow a = dataShowMapper.queryLast();
////        Date ads = new Date();
////        System.out.println(a.getDate());
//        List<Feedback> list = dataShowMapper.queryAll(0,10,null);
//        for(Feedback a:list)
//            System.out.println(a);

        FrontMapper d = act.getBean(FrontMapper.class);
        List<Comment> l = d.QueryCommentsByUserId((long) 1);
        for (Comment s : l)
            System.out.println(s);

    }
}
