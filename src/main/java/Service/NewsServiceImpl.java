package Service;

import DAO.PicNewsMapper;
import POJO.boardNews;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import DAO.NewsMapper;
import POJO.News;
import Service.NewsService;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class NewsServiceImpl implements NewsService {


    @Resource
    private NewsMapper newsMapper;

    @Resource
    private PicNewsMapper picNewsMapper;

    @Override
    public int deleteByPrimaryKey(Long newsId) {
        return newsMapper.deleteByPrimaryKey(newsId);
    }

    @Override
    public int insert(News record) {
        return newsMapper.insert(record);
    }

    @Override
    public int insertSelective(News record) {
        return newsMapper.insertSelective(record);
    }

    @Override
    public News selectByPrimaryKey(Long newsId) {
        return newsMapper.selectByPrimaryKey(newsId);
    }

    @Override
    public int updateByPrimaryKeySelective(News record) {
        return newsMapper.updateByPrimaryKeySelective(record);
    }

    @Override
    public int updateByPrimaryKey(News record) {
        return newsMapper.updateByPrimaryKey(record);
    }

    @Override
    public List<News> queryByPage(int offset, int rows) {
        return newsMapper.queryByPage(offset, rows);
    }

    @Override
    public int countAll() {
        return newsMapper.countAll();
    }

    @Override
    public List<boardNews> queryBoardNews(long categoryId) {
        return newsMapper.queryBoardNews(categoryId);
    }

    @Override
    public boolean change(long oldId, long newId) {

        return false;
    }

    @Override
    @Transactional
    public int updateNews(long newsId, int state) {
        int result = newsMapper.updateNews(newsId, state);
        if(picNewsMapper.count(newsId) > 0){
            picNewsMapper.updateState(newsId,state);
        }
        return result;
    }

    @Override
    public List<News> queryAllNewsByCategoryId(long categoryId,int offset,int row) {
        return newsMapper.queryAllNewsByCategoryId(categoryId,offset,row);
    }

    @Override
    public int countAllByCategoryId(long categoryId) {
        return newsMapper.countAllByCategoryId(categoryId);
    }

    @Override
    @Transactional
    public boolean exchangeIsShown(long newsId20, long newsId21) {
        int result = newsMapper.updateChangeTo0(newsId20);
        result += newsMapper.updateChangeTo1(newsId21);

        return result==2;
    }


}



