package POJO;


import java.util.Date;

public class Comment{
    private long comment_id;
    private long user_id;
    private long news_id;
    private String user_name;
    private String title;
    private String content;
    private String createTime;
    private String user_icon;

    public String getUser_icon() {
        return user_icon;
    }

    public void setUser_icon(String user_icon) {
        this.user_icon = user_icon;
    }

    public Comment() {
    }

    @Override
    public String toString() {
        return "Comment{" +
                "comment_id=" + comment_id +
                ", user_id=" + user_id +
                ", news_id=" + news_id +
                ", content='" + content + '\'' +
                ", createTime='" + createTime + '\'' +
                '}';
    }

    public Comment(long user_id, long news_id, String content) {
        this.user_id = user_id;
        this.news_id = news_id;
        this.content = content;
    }

    public Comment(long comment_id, long user_id, long news_id, String content, String createTime) {
        this.comment_id = comment_id;
        this.user_id = user_id;
        this.news_id = news_id;
        this.content = content;
        this.createTime = createTime;
    }

    public String getUser_name() {
        return user_name;
    }

    public void setUser_name(String user_name) {
        this.user_name = user_name;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getCreateTime() { return createTime; }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public long getComment_id() {
        return comment_id;
    }

    public void setComment_id(long comment_id) {
        this.comment_id = comment_id;
    }

    public long getUser_id() {
        return user_id;
    }

    public void setUser_id(long user_id) {
        this.user_id = user_id;
    }

    public long getNews_id() {
        return news_id;
    }

    public void setNews_id(long news_id) {
        this.news_id = news_id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
}
