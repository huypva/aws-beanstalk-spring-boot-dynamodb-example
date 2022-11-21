package io.github.huypva.helloworld.entrypoint;

import io.github.huypva.helloworld.dataprovider.entity.User;
import io.github.huypva.helloworld.dataprovider.repository.UserRepository;
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
  private UserRepository userRepository;

  @GetMapping("/greet")
  public String greet(@RequestParam(name = "name") String name) {
    return "Hello " + name + "!";
  }


  @PostMapping("/save")
  public User saveUser(@RequestBody User user) {
    return userRepository.save(user);
  }

  @SneakyThrows
  @GetMapping("/find/{id}")
  public User findUser(@PathVariable(name = "id") String id, @RequestParam(name = "name") String name) {
    User user = userRepository.get(id, name).orElseThrow(() -> new Exception("User not found!"));
    return user;
  }

  @PostMapping("/delete/{id}")
  public String deleteUser(@PathVariable(name = "id") String id, @RequestParam(name = "name") String name) {
    return userRepository.deleteById(id, name);
  }

  @PostMapping("/update")
  public String updateUser(@RequestBody User user) {
    return userRepository.update(user);
  }

}
