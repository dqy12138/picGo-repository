package Service;

import POJO.AdminUser;
import POJO.User;
import POJO.Users;

import java.util.List;

public interface UsersService{


    int deleteByPrimaryKey(Long userId);

    int insert(Users record);

    int insertSelective(Users record);

    Users selectByPrimaryKey(Long userId);

    int updateByPrimaryKeySelective(Users record);

    int updateByPrimaryKey(Users record);

    List<Users> queryByPage(int offset,int rows);

    int countAll();

    int SignIn(Users user);

    int ValidateEmail(Users user);

    int ValidateEmailName(Users user);

    int ValidateAdminUser(AdminUser user);

    Users QueryUserByEmail(String email);
}
