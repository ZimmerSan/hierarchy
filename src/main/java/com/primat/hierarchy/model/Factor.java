package com.primat.hierarchy.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@EqualsAndHashCode(of = {"code"})
public class Factor {

    private String code;
    private String name;

    public Factor(String code) {
        this.code = code;
    }

}
