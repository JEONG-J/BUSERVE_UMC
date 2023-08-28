package com.example.buserve.src;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableScheduling
public class BuserveApplication {
    public static void main(String[] args){
        SpringApplication.run(BuserveApplication.class, args);
    }

}
