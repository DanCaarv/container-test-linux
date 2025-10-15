package br.com.consultdg.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.GetMapping;


@RestController
@RequestMapping("/app")
public class AppController {

    @Value("${app.name:DefaultAppName}")
    private String appName;

    @GetMapping("/variavel")
    public String getMethodName() {
        return appName;
    }
    

}
