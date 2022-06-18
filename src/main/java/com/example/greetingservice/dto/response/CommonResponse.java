package com.example.greetingservice.dto.response;


import lombok.Builder;
import lombok.Getter;

@Getter
public class CommonResponse {
    int statusCode;
    String message;

    @Builder
    public CommonResponse(int statusCode, String message) {
        this.statusCode = statusCode;
        this.message = message;
    }
}
