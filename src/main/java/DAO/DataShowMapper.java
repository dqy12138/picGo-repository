package DAO;

import POJO.DataShow;
import POJO.Feedback;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface DataShowMapper {
    int insertSelective(DataShow record);

    int updateByPrimaryKeySelective(DataShow record);

    List<DataShow> query(Integer count);

    DataShow queryLast();

    int count();

    List<Feedback> queryAll(@Param("offset") int offset,@Param("rows") int rows,@Param("search") String search);

    int queryCount(@Param("search") String search);
}