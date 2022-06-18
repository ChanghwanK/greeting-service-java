package com.example.greetingservice.interfaces;

import com.example.greetingservice.dto.response.CommonResponse;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequestMapping("/api/greeting")
@RestController
public class GreetingController {

    @GetMapping("")
    public CommonResponse hello() {
        return CommonResponse.builder()
            .statusCode(200)
            .message("Hello World")
            .build();
    }
}
