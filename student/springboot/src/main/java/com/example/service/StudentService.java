package com.example.service;

import cn.hutool.core.util.ObjectUtil;
import com.example.common.RoleEnum;
import com.example.entity.Account;
import com.example.entity.Student;
//import com.example.mapper.AdminMapper;
import com.example.mapper.StudentMapper;
//import org.springframework.context.annotation.ComponentScan;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

//@ComponentScan(basePackages = {"com.example.service","com.example.service.StudentService"})
@Service
public class StudentService {
    @Resource
    private StudentMapper studentMapper;

    //    登录
    public Account login(Account account) throws CustomException {
        Account dbStudent = studentMapper.selectByUsername(account.getUsername());
        if (dbStudent == null) {
//            没有用户
            throw new CustomException();
        }
//        比较密码
        if (!account.getPassword().equals(dbStudent.getPassword())) {
            throw new CustomException();
        }
//        登录成功
        return dbStudent;
    }
//学生注册
    public void register(Account account) throws CustomException {
        Student student = new Student();
        student.setUsername(account.getUsername());
        student.setPassword(account.getPassword());
        student.setName(account.getName());
        this.add(student);
    }

    //新增
    public void add(Student student) throws CustomException {
        Student dbStudent = studentMapper.selectByUsername(student.getUsername());
        if (dbStudent != null) {//已有同名账号，不允许输入
            throw new CustomException("账号已存在");
        }
        if (ObjectUtil.isEmpty(student.getName())) {
            student.setName(student.getUsername());
        }
        student.setRole(RoleEnum.STUDENT.name());
        studentMapper.insert(student);
    }

    public void deleteById(Integer id) {
        studentMapper.deleteById(id);
    }

    public void updateById(Student student) {
        studentMapper.updateById(student);
    }
    //数据的分页
    public PageInfo<Student> selectPage(Integer pageNum,Integer pageSize,Student student) {
        PageHelper.startPage(pageNum,pageSize);
        List<Student> studentList=studentMapper.selectAll(student);
        return PageInfo.of(studentList);
    }
}
