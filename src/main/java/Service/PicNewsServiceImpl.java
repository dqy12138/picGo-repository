package Service;

import DAO.NewsMapper;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import DAO.PicNewsMapper;
import POJO.PicNews;
import Service.PicNewsService;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class PicNewsServiceImpl implements PicNewsService{

    @Resource
    private PicNewsMapper picNewsMapper;

    @Resource
    private NewsMapper newsMapper;

    @Override
    public int deleteByPrimaryKey(Long newsId) {
        return picNewsMapper.deleteByPrimaryKey(newsId);
    }

    @Override
    public int insert(PicNews record) {
        return picNewsMapper.insert(record);
    }

    @Override
    public int insertSelective(PicNews record) {
        return picNewsMapper.insertSelective(record);
    }

    @Override
    public PicNews selectByPrimaryKey(Long newsId) {
        return picNewsMapper.selectByPrimaryKey(newsId);
    }

    @Override
    public int updateByPrimaryKeySelective(PicNews record) {
        return picNewsMapper.updateByPrimaryKeySelective(record);
    }

    @Override
    public int updateByPrimaryKey(PicNews record) {
        return picNewsMapper.updateByPrimaryKey(record);
    }

    @Override
    @Transactional
    public boolean exchangeState(long oldId, long newId) {
        int result = picNewsMapper.updateChangeTo0(oldId);
        result += picNewsMapper.updateChangeTo1(newId);
        return result == 2;
    }

    @Override
    public List<PicNews> queryPicNewsByIsShownAndCategoryId(Long categoryId) {
        return picNewsMapper.queryPicNewsByIsShownAndCategoryId(categoryId);
    }

    @Override
    public List<PicNews> queryPicNewsByCategoryId(Long categoryId) {
        return picNewsMapper.queryPicNewsByCategoryId(categoryId);
    }
}
