package com.example.mapper;

import com.example.entity.Course;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface CourseMapper{
    @Select("select * from course where name like concat('%',#{name},'%') and no like concat('%',#{no},'%')"+"and teacher like concat('%',#{teacher},'%') order by id desc")
    List<Course> selectAll(Course course);

    @Insert("insert into course(name,no,descr,times,teacher) values(#{name},#{no},#{descr},#{times},#{teacher})")
    void insert(Course course);
    @Update("update course set name = #{name},no= #{no},descr = #{descr},times = #{times},teacher= #{teacher} where id = #{id}")
    void updateById(Course course);
    @Delete("delete from course where id = #{id}")
    void deleteById(Integer id);
}
