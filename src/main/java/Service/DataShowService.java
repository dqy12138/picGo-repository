package Service;

import POJO.DataShow;
import POJO.Feedback;

import java.util.HashMap;
import java.util.List;

public interface DataShowService {

    int insertSelective(DataShow record);

    List<DataShow> query();

    int updateByPrimaryKeySelective(DataShow record);

    DataShow queryLast();

    HashMap<String,Object> queryAll(int offset, int rows, String search);

}

