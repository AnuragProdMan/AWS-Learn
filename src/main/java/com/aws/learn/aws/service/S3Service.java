package com.aws.learn.aws.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;

@Service
public class S3Service {

    @Autowired
    private S3Client s3Client;

    private final String bucketName = "my-tf-state-anurag";

    public String uploadFile(String fileName,byte [] content){
        PutObjectRequest putObjectRequest = PutObjectRequest.builder()
                .bucket(bucketName)
                .key(fileName)
                .acl("private")
                .build();
        s3Client.putObject(putObjectRequest, RequestBody.fromBytes(content));

        return "https://%s.s3.amazonaws.com/%s".formatted(bucketName, fileName);
    }

}
