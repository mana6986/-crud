package com.example.test1.dao;

import com.example.test1.mapper.UserMapper;
import com.example.test1.model.Board;
import com.example.test1.model.Comment;
import com.example.test1.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    @Override
    public Map<String, Boolean> checkFields(String name, String email, String phone) {
        Map<String, Boolean> response = new HashMap<>();
        response.put("nameUnique", userMapper.countByName(name) == 0);
        response.put("emailUnique", userMapper.countByEmail(email) == 0);
        response.put("phoneUnique", userMapper.countByPhone(phone) == 0);
        return response;
    }

    @Override
    public void save(User user) {
        userMapper.insertUser(user);
    }

    @Override
    public int countByEmail(String email) {
        return userMapper.countByEmail(email);
    }
    @Override
    public int getIdPassCheck(String email, String password) {
        // 여기서는 매퍼를 통해 실제로 데이터베이스에 접근하여 사용자 인증을 수행합니다.
        // 예를 들어, 이메일과 비밀번호가 일치하는 사용자의 수를 반환하거나 다른 방법으로 구현할 수 있습니다.
        return userMapper.getIdPassCheck(email, password);
    }
    @Override
    public User findByEmail(String email) {
        // 여기서 실제로 데이터베이스나 다른 저장소에서 이메일을 기반으로 사용자 정보를 가져오는 코드를 작성합니다.
        return userMapper.findByEmail(email);
    }
    
    @Override
    public boolean isNameUnique(String name) {
        return userMapper.checkByName(name) == 0;
    }
    @Override
    public String getUserNameByEmail(String email) {
        User user = userMapper.findByEmail(email);
        return (user != null) ? user.getName() : null;
    }
}
    
