package POJO;

import java.util.Date;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class News {
    private Long newsId;

    private Long categoryId;

    private Long userId;

    private String title;

    private String content;

    /**
     * 0 ==>未审核；1 ==> 审核通过；2 ==> 审核未通过
     */
    private Integer state;

    private Date createTime;

    private Integer isshown;
}