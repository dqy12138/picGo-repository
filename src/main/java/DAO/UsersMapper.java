package DAO;

import POJO.AdminUser;
import POJO.User;
import POJO.Users;
import org.apache.ibatis.annotations.*;

import java.util.List;

public interface UsersMapper {
    int deleteByPrimaryKey(Long userId);

    int insert(Users record);

    int insertSelective(Users record);

    Users selectByPrimaryKey(Long userId);

    int updateByPrimaryKeySelective(Users record);

    int updateByPrimaryKey(Users record);

    List<Users> queryByPage(@Param("offset")int offset,@Param("rows")int rows);

    int countAll();

    @Select("select * from users where user_email=#{email}")
    @Results(id = "Users",value = {
            @Result(property = "userId", column = "user_id", id = true),
            @Result(property = "userName", column = "user_name"),
            @Result(property = "userPassword", column = "user_password"),
            @Result(property = "userPhone", column = "user_phone"),
            @Result(property = "userAddress", column = "user_address"),
            @Result(property = "userDetail", column = "user_detail"),
            @Result(property = "userEmail", column = "user_email"),
            @Result(property = "userState", column = "user_state"),
            @Result(property = "userIcon", column = "user_icon")
    })
    public Users QueryUserByEmail(String email);

    @Insert("insert into users (user_name,user_password,user_email) values ('${userName}','${userPassword}','${userEmail}')")
    public int SignIn(Users user); //注册

    @Select("select count(*) from users where user_email = '${userEmail}'")
    public int ValidateEmail(Users user);    //验证邮箱

    @Select("select count(*) from users where user_email = '${userEmail}' and user_password = '${userPassword}'")
    public int ValidateEmailName(Users user);    //登录

    @Select("select count(*) from adminuser where name = '${name}' and password = '${password}'")
    public int ValidateAdminUser(AdminUser user);   //管理员登录


}