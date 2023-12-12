package com.example.controller;

import com.example.entity.Student;
import com.example.exception.Result;
import com.example.service.CustomException;
import com.example.service.StudentService;
import com.github.pagehelper.PageInfo;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

@RestController
@RequestMapping("/student")
public class StudentController {
    @Resource
    StudentService studentService;
    //新增
    @PostMapping("/add")
    public Result add(@RequestBody Student student) throws CustomException {
        studentService.add(student);
        return Result.success();
    }
    //删除
    @DeleteMapping("/delete/{id}")
    public Result delete(@PathVariable Integer id) throws CustomException {
        studentService.deleteById(id);
        return Result.success();
    }
    //更新
    @PutMapping("/update")
    public Result update(@RequestBody Student student) throws CustomException {
        studentService.updateById(student);
        return Result.success();
    }
    //查询
    @GetMapping("/selectPage")
    public Result selectPage(@RequestParam(defaultValue = "1")Integer pageNum,
                             @RequestParam(defaultValue = "10")Integer pageSize,
                             Student student) throws CustomException {
        PageInfo<Student> pageInfo =studentService.selectPage(pageNum,pageSize, student);
        return Result.success(pageInfo);
    }
}
