package POJO;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Users implements Serializable {

    private Long userId;
    
    private String userName;

    private String userPassword;

    private String userPhone;

    private String userAddress;

    private String userDetail;

    private String userEmail;

    private Integer userState;

    private String userIcon;

    private static final long serialVersionUID = 1L;
}

