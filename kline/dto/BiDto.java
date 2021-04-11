package com.zzw.dto;

import com.zzw.dao.TableKey;
import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

/**
 * Created by zzw on 2021/4/10.
 */
@Data
public class BiDto extends TableKey {
    private Date startTime;
    private Integer startIndex;

    private Date endTime;
    private Integer endIndex;

    private BigDecimal startPrice;

    private BigDecimal endPrice;

    private Integer type;
}
