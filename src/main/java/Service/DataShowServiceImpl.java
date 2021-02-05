package Service;

import POJO.Feedback;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import POJO.DataShow;
import DAO.DataShowMapper;
import Service.DataShowService;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;

@Service
public class DataShowServiceImpl implements DataShowService {

    @Resource
    private DataShowMapper dataShowMapper;

    @Override
    public int insertSelective(DataShow record) {
        return dataShowMapper.insertSelective(record);
    }

    @Override
    @Transactional
    public List<DataShow> query() {
        int count = dataShowMapper.count();
        return dataShowMapper.query(count-12);
    }

    @Override
    public int updateByPrimaryKeySelective(DataShow record) {
        return dataShowMapper.updateByPrimaryKeySelective(record);
    }

    @Override
    public DataShow queryLast() {
        return dataShowMapper.queryLast();
    }

    @Override
    @Transactional
    public HashMap<String,Object> queryAll(int offset, int rows, String search) {

        List<Feedback> list = dataShowMapper.queryAll(offset,rows,search);
        int result = dataShowMapper.queryCount(search);
        HashMap<String,Object> map = new HashMap<>();
        map.put("total",result);
        map.put("rows",list);

        return map;
    }
}

