package io.github.huypva.helloworld.entrypoint;

import io.github.huypva.helloworld.dataprovider.entity.Book;
import io.github.huypva.helloworld.dataprovider.repository.BookRepository;
import java.util.List;
import lombok.SneakyThrows;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author huypva
 */
@RestController
public class Controller {

  @Autowired
  private BookRepository bookRepository;

  @GetMapping("/greet")
  public String greet(@RequestParam(name = "name") String name) {
    return "Hello " + name + "!";
  }


  @PostMapping("/save")
  public Book saveBook(@RequestBody Book book) {
    return bookRepository.save(book);
  }

  @SneakyThrows
  @GetMapping("/find/{id}")
  public Book findBook(@PathVariable String booId) {
    Book book = bookRepository.get(booId).orElseThrow(() -> new Exception("Book not available"));
    return book;
  }
}
