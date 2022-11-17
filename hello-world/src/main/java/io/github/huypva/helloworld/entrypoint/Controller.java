package io.github.huypva.helloworld.entrypoint;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author huypva
 */
@RestController
public class Controller {

  @GetMapping("/greet")
  public String greet(@RequestParam(name = "name") String name) {
    return "Hello " + name + "!";
  }
}
