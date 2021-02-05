package DAO;

import POJO.News;import POJO.boardNews;import org.apache.ibatis.annotations.Param;import java.util.List;

public interface NewsMapper {
    int deleteByPrimaryKey(Long newsId);

    int insert(News record);

    int insertSelective(News record);

    News selectByPrimaryKey(Long newsId);

    int updateByPrimaryKeySelective(News record);

    int updateByPrimaryKey(News record);

    List<News> queryByPage(@Param("offset") int offset, @Param("rows") int rows);

    int countAll();

    List<boardNews> queryBoardNews(long categoryId);    //用于获取主页标题新闻

    int updateNews(@Param("newsId") Long newsId, @Param("state") int state);

    List<News> queryAllNewsByCategoryId(@Param("categoryId") long categoryId,@Param("offset") int offset,@Param("row") int row);

    int countAllByCategoryId(long categoryId);

    int updateChangeTo0(Long newsId);

    int updateChangeTo1(Long newsId);

}