package io.github.huypva.helloworld.config;

import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.client.builder.AwsClientBuilder;
import com.amazonaws.services.dynamodbv2.AmazonDynamoDB;
import com.amazonaws.services.dynamodbv2.AmazonDynamoDBClientBuilder;
import com.amazonaws.services.dynamodbv2.datamodeling.DynamoDBMapper;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;

/**
 * @author huypva
 */
public class DynamoDBConfig {

  @Value("${aws.dynamodb.endpoint}")
  private String dynamodbEndpoint;

  @Value("${aws.region}")
  private String awsRegion;

  @Value("${aws.accessKey}")
  private String dynamodbAccessKey;

  @Value("${aws.secretKey}")
  private String dynamodbSecretKey;

  @Bean
  public DynamoDBMapper dynamoDBMapper() {
    return new DynamoDBMapper(buildAmazonDynamoDB());
  }

  private AmazonDynamoDB buildAmazonDynamoDB() {
    return AmazonDynamoDBClientBuilder
        .standard()
        .withEndpointConfiguration(
            new AwsClientBuilder.EndpointConfiguration(dynamodbEndpoint,awsRegion))
        .withCredentials(new AWSStaticCredentialsProvider(
            new BasicAWSCredentials(dynamodbAccessKey,dynamodbSecretKey)))
        .build();
  }
}