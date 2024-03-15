package com.example.test1.dao;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.example.test1.model.Board;
import com.example.test1.model.Comment;
import com.example.test1.model.User;

public interface UserService {
    Map<String, Boolean> checkFields(String name, String email, String phone);
    void save(User user);
    int countByEmail(String email);
//    User findByEmailAndPassword(String email, String password);
    int getIdPassCheck(String email, String password);
    User findByEmail(String email);
    boolean isNameUnique(String name);
    String getUserNameByEmail(String email);
    
}
