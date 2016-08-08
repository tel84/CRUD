package base.service;

import base.model.User;

import java.util.List;


public interface UserService {
    public void addUser(User user);

    public void updateUser(User user);

    public void removeUser(int id);

    public User getUserById(int id);

    public List<User> listUsers();

    public List<User> findUsers(String name);

    public List<User> listUsersToPage(Integer numberPage, int itemsPerPage);

    public int countOfPage(int itemsPerPage);
}
