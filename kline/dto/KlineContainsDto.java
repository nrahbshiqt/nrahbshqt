package com.zzw.dto;

import com.zzw.dao.TableKey;
import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

/**
 * Created by zzw on 2021/4/2.
 */
@Data
public class KlineContainsDto extends TableKey{

    private Date startTime;

    private BigDecimal high;

    private BigDecimal low;

    private Integer fenXing;
}
