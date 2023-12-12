package com.example.service;

import com.example.entity.Account;
import com.example.entity.Admin;
import com.example.mapper.AdminMapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class AdminService {
    @Resource
    private AdminMapper adminMapper;
//    登录
    public Account login(Account account) throws CustomException {
        Account dbAdmin = adminMapper.selectByUsername(account.getUsername());
        if (dbAdmin == null){
//            没有用户
            throw new CustomException();
        }
//        比较密码
        if(!account.getPassword().equals(dbAdmin.getPassword())){
            throw new CustomException();
        }
//        登录成功
        return dbAdmin;
    }
}
