package com.example.controller;

import com.example.entity.Course;
import com.example.entity.StudentCourse;
import com.example.exception.Result;
import com.example.service.StudentCourseService;
import com.github.pagehelper.PageInfo;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

@RestController
@RequestMapping("/studentCourse")
public class StudentCourseController {
    @Resource
    StudentCourseService studentCourseService;
    //学生选课
    @PostMapping("/add")
    public Result add( @RequestBody StudentCourse studentCourse){
        studentCourseService.add(studentCourse);
        return Result.success();
    }
    //删除选课
    @DeleteMapping("/delete/{id}")
    public Result delete(@PathVariable Integer id){
        studentCourseService.deleteById(id);
        return Result.success();
    }
    //分页接口
    @GetMapping("/selectPage")
    public Result selectPage(@RequestParam(defaultValue = "1") Integer pageNum,
                             @RequestParam(defaultValue = "5") Integer pageSize,
                             StudentCourse studentCourse){//@RequestParam String name
        PageInfo<StudentCourse> pageInfo =studentCourseService.selectPage(pageNum,pageSize,studentCourse);
        return Result.success(pageInfo);
    }
}
