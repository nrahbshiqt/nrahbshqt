package com.zzw.dto;

import com.zzw.dao.TableKey;
import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Created by zzw on 2021/4/11.
 */
@Data
public class SegDto  extends TableKey {
    private Date startDate;
    private Integer startIndex;
    private Integer type;
    private Boolean finished;
    private List<BiDto> biDtos;
    private Boolean gap;

    private BigDecimal curExtreme;
    private Integer curExtremePos;
    private BigDecimal prevExtreme;

    public SegDto(List<BiDto> biDtos, List<KlineContainsDto> klineContainsDtos) {
        this.startDate = biDtos.get(0).getStartTime();
        this.startIndex = biDtos.get(0).getStartIndex();
        this.type = biDtos.get(0).getType();
        this.finished = false;
        this.biDtos = biDtos;
        this.gap = false;
        KlineContainsDto klineContainsDto3 = klineContainsDtos.get(biDtos.get(2).getEndIndex());
        KlineContainsDto klineContainsDto1 = klineContainsDtos.get(biDtos.get(0).getEndIndex());
        if (this.type == 1) {
            this.curExtreme = klineContainsDto3.getHigh();
            this.curExtremePos = biDtos.get(2).getEndIndex();
            this.prevExtreme = klineContainsDto1.getHigh();
        } else {
            this.curExtreme = klineContainsDto3.getLow();
            this.curExtremePos = biDtos.get(0).getEndIndex();
            this.prevExtreme = klineContainsDto1.getLow();
        }
    }
}
