package com.aws.learn.aws.controller;

import com.aws.learn.aws.service.S3Service;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

@RestController
public class HeartBeat {

    public static final Logger log = LoggerFactory.getLogger(HeartBeat.class);

    @Autowired
    private S3Service s3Service;

    @GetMapping("/health")
    public String getHeartBeat(){
        log.info("Received request to do the health check");
        return "I am healthy";
    }

    @PostMapping("/upload")
    public ResponseEntity<String> uploadFile(@RequestParam("file") MultipartFile file) throws IOException {
        log.info("Upload File called in controller");
        String fileUrl = s3Service.uploadFile(file.getOriginalFilename(), file.getBytes());
        return ResponseEntity.ok(fileUrl);
    }

}
