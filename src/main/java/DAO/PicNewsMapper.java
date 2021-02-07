package DAO;

import POJO.PicNews;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface PicNewsMapper {
    int deleteByPrimaryKey(Long newsId);

    int insert(PicNews record);

    int insertSelective(PicNews record);

    PicNews selectByPrimaryKey(Long newsId);

    int updateByPrimaryKeySelective(PicNews record);

    int updateByPrimaryKey(PicNews record);

    int updateChangeTo0(Long newsId);

    int updateChangeTo1(Long newsId);

    int count(Long newsId);

    int updateState(@Param("newsId") Long newsId,@Param("newState") int state);

    List<PicNews> queryPicNewsByCategoryId(long categoryId);

    List<PicNews> queryPicNewsByIsShownAndCategoryId(long categoryId);  //用于主页获取轮播图以及带图片的新闻
}