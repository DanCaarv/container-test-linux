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

    @Value("${app.teste}")
    private String appTeste;

    @Value("${app.consult}")
    private String appConsult;

    @GetMapping("/variavel")
    public String getMethodName() {
        return appConsult;
    }

    @GetMapping("/teste")
    public String getAppTeste() {
        return appTeste;
    }
    

}
