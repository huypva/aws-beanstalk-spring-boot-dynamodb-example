package io.github.huypva.helloworld.dataprovider.repository;

import com.amazonaws.services.dynamodbv2.datamodeling.DynamoDBMapper;
import com.amazonaws.services.dynamodbv2.datamodeling.DynamoDBSaveExpression;
import com.amazonaws.services.dynamodbv2.model.AttributeValue;
import com.amazonaws.services.dynamodbv2.model.ExpectedAttributeValue;
import io.github.huypva.helloworld.dataprovider.entity.Book;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * @author huypva
 */

public class BookRepository {

  @Autowired
  private DynamoDBMapper dynamoDBMapper;

  public Book save(Book book) {
    dynamoDBMapper.save(book);
    return book;
  }

  public Optional<Book> get(String bookId) {
    return Optional.of(dynamoDBMapper.load(Book.class, bookId));
  }

  public String deleteById(String bookId) {
    dynamoDBMapper.delete(dynamoDBMapper.load(Book.class, bookId));
    return "Book Id : "+ bookId +" Deleted!";
  }

  public String update(String bookId, Book customer) {
    dynamoDBMapper.save(customer,
        new DynamoDBSaveExpression()
            .withExpectedEntry("customerId",
                new ExpectedAttributeValue(
                    new AttributeValue().withS(bookId)
                )));
    return bookId;
  }
}