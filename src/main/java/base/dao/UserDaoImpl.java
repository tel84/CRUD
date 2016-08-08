package base.dao;

import base.model.User;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import java.util.List;


@Repository
public class UserDaoImpl implements UserDao {
    private Logger logger = LoggerFactory.getLogger(UserDaoImpl.class);

    private SessionFactory sessionFactory;

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    @Override
    public void addUser(User user) {
        Session session = sessionFactory.getCurrentSession();
        session.persist(user);
        logger.info("User successfully saved. User details: " + user);
    }

    @Override
    public void updateUser(User user) {
        Session session = sessionFactory.getCurrentSession();
        session.update(user);
        logger.info("User successfully update. User details: " + user);
    }

    @Override
    @SuppressWarnings("unchecked")
    public void removeUser(int id) {
        Session session = sessionFactory.getCurrentSession();
        User user = (User)session.load(User.class, new Integer(id));
        if (user != null)
            session.delete(user);
        logger.info("User successfully removed. User details: " + user);
    }

    @Override
    public User getUserById(int id) {
        Session session = sessionFactory.getCurrentSession();
        User user = (User)session.load(User.class, new Integer(id));
        logger.info("User successfully loaded. User details: " + user);
        return user;
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<User> listUsers() {
        Session session = sessionFactory.getCurrentSession();
        List<User> userList = (List<User>)session.createQuery("from User").list();

        for(User user: userList){
            logger.info("User list: " + user);
        }
        return userList;
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<User> findUsers(String name) {
        Session session = sessionFactory.getCurrentSession();
        String s = "from User where name = '" + name + "'";
        List<User> userList = (List<User>)session.createQuery(s).list();

        return userList;
    }

    @Override
    @SuppressWarnings("unchecked")
    public int countOfPage(int itemsPerPage) {
        List<User> userList = listUsers();
        int result = userList.size()/itemsPerPage;
        if(userList.size() % itemsPerPage == 0)
            return result;
        else return result + 1;
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<User> listUsersToPage(Integer numberPage, int itemsPerPage) {
        Session session = sessionFactory.getCurrentSession();
        int startItem = ((numberPage == null ? 1 : numberPage) - 1) * itemsPerPage;
        Query q = session.createQuery("from User");
        q.setFirstResult(startItem);
        q.setMaxResults(itemsPerPage);
        List<User> userList = q.list();

        for (User user : userList) {
            logger.info("User list for page №" + numberPage + ": " + user);
        }
        return userList;
    }

}
