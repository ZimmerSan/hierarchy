package com.primat.hierarchy.model;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class Alternative {

    private String code;
    private String name;

    public Alternative(String code) {
        this.code = code;
    }

}
