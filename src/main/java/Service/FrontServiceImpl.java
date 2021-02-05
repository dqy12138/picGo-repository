package Service;

import DAO.FrontMapper;
import POJO.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service
public class FrontServiceImpl implements FrontService {

    private final FrontMapper frontMapper;

    public FrontServiceImpl(FrontMapper frontMapper) {
        this.frontMapper = frontMapper;
    }

    @Override
    public int QueryNewsTotalByKey(String key) {
        return this.frontMapper.QueryNewsTotalByKey(key);
    }

    @Override
    public String QueryNewsTitleById(long id) {
        return this.frontMapper.QueryNewsTitleById(id);
    }

    @Override
    public News QueryNewsById(long id) {
        return this.frontMapper.QueryNewsById(id);
    }

    @Override
    public List<News> QueryNewsByKey(String key,int cPage) {
        return this.frontMapper.QueryNewsByKey(key,cPage);
    }

    @Override
    public int QueryNewsTotalByCId(long cid) {
        return this.frontMapper.QueryNewsTotalByCId(cid);
    }

    @Override
    public List<News> QueryNewsByCId(long cid,int cPage) {
        return this.frontMapper.QueryNewsByCId(cid,cPage);
    }

//    @Override
//    public List<List<News>> QueryNewsByCIds(long num) {
//        List<List<News>> newsLL = new ArrayList<>();
//        for (Category c : this.frontMapper.QueryAllCategorys()) {
//            long cid = c.getCategory_id();
//            System.out.println(cid);
//            newsLL.add(this.frontMapper.QueryNewsByCIds(cid, num));
//        }
//        return newsLL;
//    }

    @Override
    public List<News> QueryNewsByUId(long uid) {
        return this.frontMapper.QueryNewsByUId(uid);
    }

    @Override
    public List<Category> QueryAllCategorys() {
        return this.frontMapper.QueryAllCategorys();
    }

    @Override
    public int AddNews(News news) {
        return this.frontMapper.AddNews(news);
    }

    @Override
    public int UpdateNews(News news) {
        return this.frontMapper.UpdateNews(news);
    }

    @Override
    public int DeleteNews(long nid) {
        return this.frontMapper.DeleteNews(nid) + this.frontMapper.DeleteCommentN(nid) + this.frontMapper.DeletePic(nid);
    }

    @Override
    public int LastId() {
        return this.frontMapper.LastId();
    }

    @Override
    public int AddPic(Pics pic) {
        return this.frontMapper.AddPic(pic);
    }

    @Override
    public List<Pics> SelectPic() {
        return this.frontMapper.SelectPic();
    }

    @Override
    public int AddComment(Comment comment) {
        return this.frontMapper.AddComment(comment);
    }

    @Override
    public int QueryTotalCommentsByNewsId(long nid) {
        return this.frontMapper.QueryTotalCommentsByNewsId(nid);
    }

    @Override
    public List<Comment> QueryCommentsByNewsId(long nid,int cPage) {
        return this.frontMapper.QueryCommentsByNewsId(nid,cPage);
    }

    @Override
    public List<Comment> QueryCommentsByUserId(long uid) {
        return this.frontMapper.QueryCommentsByUserId(uid);
    }

    @Override
    public int DeleteComment(long cid) {
        return this.frontMapper.DeleteComment(cid);
    }

    @Override
    public Users QueryUserById(long uid) {
        return this.frontMapper.QueryUserById(uid);
    }

    @Override
    public List<Feedback> QueryFeedbackByUId(long uid) {
        return this.frontMapper.QueryFeedbackByUId(uid);
    }

    @Override
    public int DeleteFeedback(long fid) {
        return this.frontMapper.DeleteFeedback(fid);
    }

    @Override
    public int updateUserByUId(Users users) {
        return this.frontMapper.updateUserByUId(users);
    }

    @Override
    public int AddFeedback(Feedback feedback) {
        return this.frontMapper.AddFeedback(feedback);
    }

    @Override
    public int updatePwdByUId(String newPwd, long uid) {
        return this.frontMapper.updatePwdByUId(newPwd, uid);
    }
}
