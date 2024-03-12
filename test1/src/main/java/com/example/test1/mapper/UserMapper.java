package com.example.test1.mapper;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.example.test1.model.Comment;
import com.example.test1.model.User;

@Mapper
public interface UserMapper {
	List<User> checkFields(HashMap<String, Object> map);
    void insertUser(User user);
    int countByName(String name);
    int countByEmail(String email);
    int countByPhone(String phone);
//    User findByEmailAndPassword(String email, String password);
    int getIdPassCheck(@Param("email") String email, @Param("password") String password);
    
        int checkByName(String name);
        User findByEmail(String email);
        // 다른 필요한 메서드들도 여기에 추가 가능합니다.
        String getUserNameByEmail(@Param("email") String email);
    }
