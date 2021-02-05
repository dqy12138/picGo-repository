package Service;

import POJO.*;
import org.apache.ibatis.annotations.Select;

import javax.enterprise.inject.New;
import java.util.List;
import java.util.Map;

public interface FrontService {


    public String QueryNewsTitleById(long id);

    public News QueryNewsById(long id);

    public List<News> QueryNewsByKey(String key, int cPage);

    public int QueryNewsTotalByKey(String key);

    public List<News> QueryNewsByCId(long cid, int cPage);

    public int QueryNewsTotalByCId(long cid);

//    public List<List<News>> QueryNewsByCIds(long num);

    public List<News> QueryNewsByUId(long uid);

    public List<Category> QueryAllCategorys();

    public int AddNews(News news);

    public int UpdateNews(News news);

    public int DeleteNews(long nid);

    public int LastId();

    public int AddPic(Pics pic);

    public List<Pics> SelectPic();

    public int AddComment(Comment comment);

    public int QueryTotalCommentsByNewsId(long nid);

    public List<Comment> QueryCommentsByNewsId(long nid, int cPage);

    public List<Comment> QueryCommentsByUserId(long uid);

    public int DeleteComment(long cid);

    public Users QueryUserById(long uid);

    public int AddFeedback(Feedback feedback);

    public int DeleteFeedback(long fid);

    public List<Feedback> QueryFeedbackByUId(long uid);

    public int updateUserByUId(Users users);

    public int updatePwdByUId(String newPwd, long uid);
}
