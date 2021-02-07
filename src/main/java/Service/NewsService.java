package Service;

import POJO.News;
import POJO.Users;
import POJO.boardNews;

import java.util.List;

public interface NewsService {


    int deleteByPrimaryKey(Long newsId);

    int insert(News record);

    int insertSelective(News record);

    News selectByPrimaryKey(Long newsId);

    int updateByPrimaryKeySelective(News record);

    int updateByPrimaryKey(News record);

    List<News> queryByPage(int offset, int rows);

    int countAll();

    List<boardNews> queryBoardNews(long categoryId);

    boolean change(long oldId, long newId);

    int updateNews(long newsId, int state);

    List<News> queryAllNewsByCategoryId(long categoryId,int offset,int row);

    int countAllByCategoryId(long categoryId);

    boolean exchangeIsShown(long newsId20,long newsId21);
}



