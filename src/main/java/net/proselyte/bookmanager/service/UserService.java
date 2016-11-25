package net.proselyte.bookmanager.service;

import net.proselyte.bookmanager.model.User;

import java.util.List;

/**
 * Created by NLO on 24.11.2016.
 */
public interface UserService {
    public void addUser(User user);

    public void updateUser(User user);

    public void removeUser(int id);

    public User getUserById(int id);

    public List<User> getUserByName(String name);

    public List<User> listUsers();
}
