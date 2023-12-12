package com.example.controller;

import com.example.entity.Course;
import com.example.exception.Result;
import com.example.service.CourseService;
import com.github.pagehelper.PageInfo;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

@RestController
@RequestMapping("/course")
public class CourseController {
    @Resource
    private CourseService courseService;
//定义和处理HTTP GET请求
    //分页接口
    @GetMapping("/selectPage")
    public Result selectPage(@RequestParam(defaultValue = "1") Integer pageNum,
                             @RequestParam(defaultValue = "5") Integer pageSize,
                             Course course){//@RequestParam String name
        PageInfo<Course> pageInfo =courseService.selectPage(pageNum,pageSize,course);
        return Result.success(pageInfo);
    }
    //新增接口
    @PostMapping("/add")
    public Result add(@RequestBody Course course){
        courseService.add(course);
        return Result.success();
    }
    //更新接口
    @PutMapping("/update")
    public Result update(@RequestBody Course course){
        courseService.updateById(course);
        return Result.success();
    }
//    删除接口
    @DeleteMapping("/delete/{id}")
    public Result delete(@PathVariable Integer id){
        courseService.deleteById(id);
        return Result.success();
    }
}
