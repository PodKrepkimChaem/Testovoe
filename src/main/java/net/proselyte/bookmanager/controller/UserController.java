package net.proselyte.bookmanager.controller;

import net.proselyte.bookmanager.model.User;
import net.proselyte.bookmanager.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
public class UserController {
    private UserService userService;

    @Autowired(required = true)
    @Qualifier(value = "userService")
    public void setBookService(UserService userService) {
        this.userService = userService;
    }

    @RequestMapping(value = "users/{page}", method = RequestMethod.GET)
    public String listUsers(@PathVariable("page") int page ,Model model){
        model.addAttribute("user", new User());
        List<User> listUsers = this.userService.listUsers();
        List<User> locListUsers = new ArrayList<User>();
        int count = 0;
        for (int i = page*5; i < listUsers.size(); i++) {
            if(count == 5)break;
            locListUsers.add(listUsers.get(i));
            count++;
        }
        model.addAttribute("page", page);
        model.addAttribute("pageCount", Math.ceil(listUsers.size()/5.f));
        model.addAttribute("listUsers", locListUsers);

        return "users";
    }

    @RequestMapping(value = "/users/add/{page}", method = RequestMethod.POST)
    public String addUser(@PathVariable("page") int page, @ModelAttribute("user") User user){
        user.setDate(new Date());
        if(user.getId() == 0){
            this.userService.addUser(user);
        }else {
            this.userService.updateUser(user);
        }

        return "redirect:/users/" + page;
    }

    @RequestMapping("/remove/{str}")
    public String removeUser(@PathVariable("str") String str){
        int id = Integer.parseInt(str.split("&")[0]);
        int page = Integer.parseInt(str.split("&")[1]);
        this.userService.removeUser(id);

        return "redirect:/users/" + page;
    }

    @RequestMapping("edit/{str}")
    public String editUser(@PathVariable("str") String str, Model model){
        int id = Integer.parseInt(str.split("&")[0]);
        int page = Integer.parseInt(str.split("&")[1]);

        List<User> listUsers = this.userService.listUsers();
        List<User> locListUsers = new ArrayList<User>();
        int count = 0;
        for (int i = page*5; i < listUsers.size(); i++) {
            if(count == 5)break;
            locListUsers.add(listUsers.get(i));
            count++;
        }
        model.addAttribute("user", this.userService.getUserById(id));
        model.addAttribute("page", page);
        model.addAttribute("pageCount", Math.ceil(listUsers.size()/5.f));
        model.addAttribute("listUsers", locListUsers);

        return "users";
    }

    @RequestMapping("userdata/{id}")
    public String userData(@PathVariable("id") int id, Model model){
        model.addAttribute("user", this.userService.getUserById(id));

        return "userdata";
    }

    @RequestMapping(value = "userSearch/{page}", method = RequestMethod.POST)
    public String userSearch(@PathVariable("page") int page, @RequestParam String name, Model model){
        model.addAttribute("listUsers", this.userService.getUserByName(name));
        model.addAttribute("page", page);
        return "usersearch";
    }
}
