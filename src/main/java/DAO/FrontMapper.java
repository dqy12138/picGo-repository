package DAO;

import POJO.*;
import org.apache.ibatis.annotations.*;
import org.springframework.security.core.parameters.P;

import java.util.List;
import java.util.Map;

@Mapper
public interface FrontMapper {


    /**
     * <result column="category_id" jdbcType="BIGINT" property="categoryId" />
     * <result column="user_id" jdbcType="BIGINT" property="userId" />
     * <result column="title" jdbcType="VARCHAR" property="title" />
     * <result column="content" jdbcType="LONGVARCHAR" property="content" />
     * <result column="state" jdbcType="INTEGER" property="state" />
     * <result column="create_time" jdbcType="TIMESTAMP" property="createTime" />
     * <result column="isShown" jdbcType="INTEGER" property="isshown" />
     *
     * @param id
     * @return
     */



    //@Select("select title from news where news_id=#{id}")
    public String QueryNewsTitleById(long id);

    @Select("select * from news where news_id=#{id} ")
    @Results(id = "News", value = {
            @Result(property = "newsId", column = "news_id", id = true),
            @Result(property = "categoryId", column = "category_id"),
            @Result(property = "userId", column = "user_id"),
            @Result(property = "title", column = "title"),
            @Result(property = "content", column = "content"),
            @Result(property = "state", column = "state"),
            @Result(property = "createTime", column = "createTime"),
            @Result(property = "isshown", column = "isShown")
    })
    public News QueryNewsById(long id);

    //@Select("select * from news where title like CONCAT('%',#{key},'%')")
    public List<News> QueryNewsByKey(@Param("key") String key, @Param("cPage") int cPage);

    @Select("select count(*) from news where title like CONCAT('%',#{key},'%')")
    public int QueryNewsTotalByKey(String key);

//    select * from news where category_id=1 and news_id<=(select news_id from news where category_id=1 order by news_id desc limit 2,1)order by news_id desc limit 2
    @Select("select * from news where category_id=#{cid} and state=1 and news_id<=(select news_id from news where category_id=#{cid} and state=1 order by news_id desc limit ${cPage},1)order by news_id desc limit 10")
    @ResultMap("News")
    public List<News> QueryNewsByCId(@Param("cid") long cid, @Param("cPage") int cPage);

    @Select("select count(*) from news where category_id=#{cid} and state=1")
    public int QueryNewsTotalByCId(long cid);

    //@Select("select news_id,title from news where category_id=#{cid} group by news_id desc limit #{num}")
//    public List<News> QueryNewsByCIds(@Param("cid") long cid, @Param("num") long num);

    //@Select("select * from news where user_id=#{uid}")
    public List<News> QueryNewsByUId(long uid);

    //@Select("select * from categorys")
    public List<Category> QueryAllCategorys();

    //@Insert("insert into news(category_id,user_id,title,content,state,createTime) values('${categoryId}','${userId}','${title}','${content}','${state}',NOW())")
    public int AddNews(News news);

    //@Update("update news set category_id=#{categoryId},title=#{title},content=#{content},state=#{},createTime=NOW() where news_id=#{newsId}")
    public int UpdateNews(News news);

    //@Delete("delete from news where news_id=#{nid}")
    public int DeleteNews(long nid);

    //@Delete("delete from comments where news_id=#{nid}")
    public int DeleteCommentN(long nid);

    //@Delete("delete from pics where news_id=#{nid}")
    public int DeletePic(long nid);

    @Select("select last_insert_id()")
    public int LastId();

    //@Insert("insert into pics(news_id,pic_url) values('${news_id}','${pic_url}')")
    public int AddPic(Pics pic);

    //@Select("select * from pics group by news_id desc limit 5")
    public List<Pics> SelectPic();

    //@Insert("insert into comments(user_id,news_id,content,createTime) values ('${user_id}','${news_id}','${content}',NOW())")
    public int AddComment(Comment comment);

    @Select("select count(*) from comments where news_id=#{nid}")
    public int QueryTotalCommentsByNewsId(long nid);

    //@Select("select * from comments where news_id=#{nid}")
    public List<Comment> QueryCommentsByNewsId(@Param("nid") long nid, @Param("cPage") int cPage);

    //@Select("select * from comments where user_id=#{uid}")
    public List<Comment> QueryCommentsByUserId(long uid);

    public int updateUserByUId(Users users);

    //@Update("update users set user_password=#{newPwd} where user_id=#{uid}")
    public int updatePwdByUId(@Param("newPwd") String newPwd, @Param("uid") long uid);

    //@Delete("delete from comments where comment_id=#{cid}")
    public int DeleteComment(long cid);

    //@Select("select * from users where user_id=#{uid}")
    @Select("select * from users where user_id=#{uid}")
    @Results(id = "Users",value = {
            @Result(property = "userId", column = "user_id", id = true),
            @Result(property = "userName", column = "user_name"),
            @Result(property = "userPassword", column = "user_password"),
            @Result(property = "userPhone", column = "user_phone"),
            @Result(property = "userAddress", column = "user_address"),
            @Result(property = "userDetail", column = "user_detail"),
            @Result(property = "userEmail", column = "user_email"),
            @Result(property = "userState", column = "user_state"),
            @Result(property = "userIcon", column = "user_icon")
    })
    public Users QueryUserById(long uid);

    //@Insert("insert into feedbacks(user_id,content,type,createTime) values('${user_id}','${content}','${type}',NOW())")
    public int AddFeedback(Feedback feedback);

    @Delete("delete from feedbacks where feedback_id=#{fid}")
    public int DeleteFeedback(long fid);

    @Select("select * from feedbacks where user_id=#{uid}")
    public List<Feedback> QueryFeedbackByUId(long uid);

}
