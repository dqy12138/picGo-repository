package Service;

import POJO.AdminUser;
import POJO.User;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

import POJO.Users;
import DAO.UsersMapper;
import Service.UsersService;

import java.util.List;

@Service
public class UsersServiceImpl implements UsersService {

    @Resource
    private UsersMapper usersMapper;

    @Override
    public int deleteByPrimaryKey(Long userId) {
        return usersMapper.deleteByPrimaryKey(userId);
    }

    @Override
    public int insert(Users record) {
        return usersMapper.insert(record);
    }

    @Override
    public int insertSelective(Users record) {
        return usersMapper.insertSelective(record);
    }

    @Override
    public Users selectByPrimaryKey(Long userId) {
        return usersMapper.selectByPrimaryKey(userId);
    }

    @Override
    public int updateByPrimaryKeySelective(Users record) {
        return usersMapper.updateByPrimaryKeySelective(record);
    }

    @Override
    public int updateByPrimaryKey(Users record) {
        return usersMapper.updateByPrimaryKey(record);
    }

    @Override
    public List<Users> queryByPage(int offset, int rows) {
        return usersMapper.queryByPage(offset, rows);
    }

    @Override
    public int countAll() {
        return usersMapper.countAll();
    }

    @Override
    public int SignIn(Users user) {
        return this.usersMapper.SignIn(user);
    }

    @Override
    public int ValidateEmail(Users user) {
        return this.usersMapper.ValidateEmail(user);
    }

    @Override
    public int ValidateEmailName(Users user) {
        return this.usersMapper.ValidateEmailName(user);
    }

    @Override
    public int ValidateAdminUser(AdminUser user) {
        return usersMapper.ValidateAdminUser(user);

    }

    @Override
    public Users QueryUserByEmail(String email) {
        return usersMapper.QueryUserByEmail(email);
    }
}

