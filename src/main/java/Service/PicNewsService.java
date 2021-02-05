package Service;

import POJO.PicNews;

import java.util.List;

public interface PicNewsService{


    int deleteByPrimaryKey(Long newsId);

    int insert(PicNews record);

    int insertSelective(PicNews record);

    PicNews selectByPrimaryKey(Long newsId);

    int updateByPrimaryKeySelective(PicNews record);

    int updateByPrimaryKey(PicNews record);

    boolean exchangeState(long oldId, long newId);

    List<PicNews> queryPicNewsByIsShownAndCategoryId(Long categoryId);

    List<PicNews> queryPicNewsByCategoryId(Long categoryId);

}
