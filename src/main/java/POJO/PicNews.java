package POJO;

import java.util.Date;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PicNews {
    private Long newsId;

    private String title;

    private Date createTime;

    private String picUrl;

    private Long categoryId;

    /**
    * 0 ==>未审核；1 ==> 审核通过；2 ==> 审核未通过
    */
    private Integer state;

    private Integer isshown;
}