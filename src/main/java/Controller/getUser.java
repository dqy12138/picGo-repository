package Controller;

import POJO.Users;
import Service.UsersService;
import com.alibaba.fastjson.JSON;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

@Controller
@RequestMapping("/back")
public class getUser {

    private Logger logger = LoggerFactory.getLogger(backController.class);

    @Resource
    private UsersService usersService;

    /**
     * 获取 获取数据条数 ==> users
     * @return
     */
    @GetMapping("/countUsersAll")
    @ResponseBody
    public String countUsersAll() {
        logger.info("countUsersAll.........");
        Integer count = usersService.countAll();
        return count.toString();
    }

    /**
     * 通过页数获取页面内容  ==> User
     * @param offset
     * @return
     */
    @PostMapping(value = "/queryUsersPage", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String queryUsersPage(int offset) {
        logger.info("queryUsersPage.........");
        if (offset >= 1) {
            List<Users> list = usersService.queryByPage((offset - 1) * 7, 7);

            return JSON.toJSONString(list);
        } else return null;
    }

    @PostMapping(value = "/queryUsersTest")
    @ResponseBody
    public String queryUsersTest(int offset, int limit) {
        logger.info("queryUsersTest.........");
        List<Users> list = usersService.queryByPage(offset, limit);

        return JSON.toJSONString(list);
    }

    /**
     * 修改用户
     * @param data
     * @return
     * 1 成功
     * 0 失败
     */
    @PostMapping("/upDateUser")
    @ResponseBody
    public String upDateUser(String data){
        logger.info("upDateUser........");
        String[] user = data.split(",");
        logger.info(data);
        Users newUser = new Users();
        newUser.setUserId(Long.parseLong(user[0]));
        newUser.setUserName(user[1]);
        newUser.setUserPassword(user[2]);
        newUser.setUserEmail(user[6]);
        newUser.setUserState(Integer.parseInt(user[7]));
        if(!user[3].equals("undefined"))
            newUser.setUserPhone(user[3]);
        if(!user[4].equals("undefined"))
            newUser.setUserAddress(user[4]);
        if(!user[5].equals("undefined"))
            newUser.setUserDetail(user[5]);

        logger.info(newUser.toString());

        int result = usersService.updateByPrimaryKeySelective(newUser);
        String resultStr = "0";
        if(result>0){
            resultStr="1";
        }
        return resultStr;
    }

    /**
     * 通过 id 查询用户详情
     * @param id
     * @return
     */
    @ResponseBody
    @PostMapping("/getUserById")
    public String queryUserById(Integer id){
        logger.info("queryUserById.........");
        Users user = usersService.selectByPrimaryKey((long)id);
        return JSON.toJSONString(user);
    }
}
