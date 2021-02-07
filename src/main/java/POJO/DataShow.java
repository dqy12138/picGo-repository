package POJO;

import java.util.Date;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class DataShow {
    private Integer dataId;

    private Date date;

    private Integer newsCount;

    private Integer userCount;

    private Integer feedbackCount;
}