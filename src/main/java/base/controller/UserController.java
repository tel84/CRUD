package base.controller;

import base.model.User;
import base.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;


@Controller
public class UserController {

    private UserService userService;
    private int currentPage = 1;
    @Autowired(required = true)
    @Qualifier(value = "userService")
    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    @RequestMapping(value = "users", method = RequestMethod.GET)
    public String listUsers(Integer page, Model model) {
        model.addAttribute("user", new User());
        if (page == null || page < 1)
           page = currentPage;
        currentPage = page;
        model.addAttribute("countOfPages", this.userService.countOfPage(5));
        model.addAttribute("currentPage", page);
        model.addAttribute("listUsers", this.userService.listUsersToPage(page, 5));
        return "users";
    }

    @RequestMapping("edit/{id}")
    public String editUser(@PathVariable("id") int id, Integer page, Model model) {
        model.addAttribute("user", this.userService.getUserById(id));
        if (page == null || page < 1)
            page = currentPage;
        currentPage = page;
        model.addAttribute("countOfPages", this.userService.countOfPage(5));
        model.addAttribute("currentPage", page);
        model.addAttribute("listUsers", this.userService.listUsersToPage(page, 5));
        return "users";
    }

    @RequestMapping(value = "/users/add", method = RequestMethod.POST)
    public String addUser(@ModelAttribute("user") User user) {
        if (user.getId() == 0) {
            this.userService.addUser(user);
        } else {
            this.userService.updateUser(user);
        }
        return "redirect:/users";
    }

    @RequestMapping("/remove/{id}")
    public String removeUser(@PathVariable("id") int id) {
        this.userService.removeUser(id);
        return "redirect:/users";
    }

     @RequestMapping(value = "/users/find", method = RequestMethod.GET)
    public String findUser(@RequestParam("name") String name, Model model ) {
         model.addAttribute("listUsers",this.userService.findUsers(name));
        return "findresult";
    }
}
