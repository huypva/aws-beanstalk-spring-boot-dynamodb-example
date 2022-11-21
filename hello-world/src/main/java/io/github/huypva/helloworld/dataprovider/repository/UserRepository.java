package io.github.huypva.helloworld.dataprovider.repository;

import com.amazonaws.services.dynamodbv2.datamodeling.DynamoDBMapper;
import com.amazonaws.services.dynamodbv2.datamodeling.DynamoDBSaveExpression;
import com.amazonaws.services.dynamodbv2.model.AttributeValue;
import com.amazonaws.services.dynamodbv2.model.ExpectedAttributeValue;
import io.github.huypva.helloworld.dataprovider.entity.User;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

/**
 * @author huypva
 */
@Repository
public class UserRepository {

  @Autowired
  private DynamoDBMapper dynamoDBMapper;

  public User save(User user) {
    dynamoDBMapper.save(user);
    return user;
  }

  public Optional<User> get(String id, String name) {
    return Optional.of(dynamoDBMapper.load(User.class, id, name));
  }

  public String deleteById(String id, String name) {
    dynamoDBMapper.delete(dynamoDBMapper.load(User.class, id, name));
    return "User "+ id +" deleted!";
  }

  public String update(User user) {
    dynamoDBMapper.save(user,
        new DynamoDBSaveExpression()
            .withExpectedEntry("id",
                new ExpectedAttributeValue(
                    new AttributeValue().withS(user.getId())
                ))
            .withExpectedEntry("name",
                new ExpectedAttributeValue(
                    new AttributeValue().withS(user.getName())
                )));
    return "User "+ user.getId() +" updated!";
  }
}