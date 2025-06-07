package com.aws.learn.aws.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HeartBeat {

    public static final Logger log = LoggerFactory.getLogger(HeartBeat.class);

    @GetMapping("/health")
    public String getHeartBeat(){
        log.info("Received request to do the health check");
        return "I am healthy";
    }

}
