package POJO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class boardNews {
    private long news_id;
    private long category_id;
    private String title;
    private Date createTime;
}
