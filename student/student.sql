/*
 Navicat Premium Data Transfer

 Source Server         : 本地MySQL
 Source Server Type    : MySQL
 Source Server Version : 50736
 Source Host           : localhost:3306
 Source Schema         : student

 Target Server Type    : MySQL
 Target Server Version : 50736
 File Encoding         : 65001

 Date: 12/12/2023 08:59:46
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '账号',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '密码',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '名称',
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '角色',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '管理员' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (1, 'admin', 'admin', '管理员', 'ADMIN');

-- ----------------------------
-- Table structure for course
-- ----------------------------
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '课程名称',
  `no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '课程编号',
  `descr` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '课程描述',
  `times` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '课时',
  `teacher` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '任课老师',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '课程信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of course
-- ----------------------------
INSERT INTO `course` VALUES (1, '英语', 'CS1101', 'English easy', '24节', '陈晖洁');
INSERT INTO `course` VALUES (2, '数学', 'CS1102', 'Math easy', '24节', '诗怀雅');
INSERT INTO `course` VALUES (3, '语文', 'CS1103', 'Chinese easy', '24节', '林雨霞');

-- ----------------------------
-- Table structure for grade
-- ----------------------------
DROP TABLE IF EXISTS `grade`;
CREATE TABLE `grade`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `course_id` int(11) NULL DEFAULT NULL COMMENT '课程ID',
  `student_id` int(11) NULL DEFAULT NULL COMMENT '学生ID',
  `score` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '分数',
  `comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '评语',
  `feedback` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '学生反馈',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '学生成绩' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of grade
-- ----------------------------
INSERT INTO `grade` VALUES (2, 2, 17, '66.0', '菜就多练', '一般');
INSERT INTO `grade` VALUES (3, 2, 17, '4433.0', '蚁钳是蚁钳1', 'just so so');
INSERT INTO `grade` VALUES (5, 3, 1, '1.0', '1', NULL);

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '学号',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '密码',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '名称',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '手机号',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '邮箱',
  `sex` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '性别',
  `birth` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '生日',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '头像',
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 79 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '学生信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES (1, '123', '123', '张三', NULL, NULL, NULL, NULL, '', NULL);
INSERT INTO `student` VALUES (8, '678', '678', '678', NULL, NULL, NULL, NULL, 'http://localhost:9090/files/download?fileName=1702179677237_微信截图_20230521213702.png', 'STUDENT');
INSERT INTO `student` VALUES (9, '12345', 'admin', '12345', '12345', NULL, NULL, NULL, 'http://localhost:9090/files/download?fileName=1702169404740_5.png', 'STUDENT');
INSERT INTO `student` VALUES (17, '20231', 'admin', 'ikun', NULL, NULL, '男', NULL, 'http://localhost:9090/files/download?fileName=1702342364018_QQ浏览器截图20230630232919.png', 'STUDENT');
INSERT INTO `student` VALUES (59, '黄磊', '12345', '杨娜', NULL, NULL, NULL, NULL, NULL, 'STUDENT');
INSERT INTO `student` VALUES (60, '蒋超', '12345', '李明', NULL, NULL, NULL, NULL, NULL, 'STUDENT');
INSERT INTO `student` VALUES (61, '林涛', '12345', '郝娜', NULL, NULL, NULL, NULL, NULL, 'STUDENT');
INSERT INTO `student` VALUES (62, '薛刚', '12345', '侯超', NULL, NULL, NULL, NULL, NULL, 'STUDENT');
INSERT INTO `student` VALUES (63, '丁芳', '12345', '林涛', NULL, NULL, NULL, NULL, NULL, 'STUDENT');
INSERT INTO `student` VALUES (64, '张艳', '12345', '夏敏', NULL, NULL, NULL, NULL, NULL, 'STUDENT');
INSERT INTO `student` VALUES (65, '叶娜', '12345', '傅秀英', NULL, NULL, NULL, NULL, NULL, 'STUDENT');
INSERT INTO `student` VALUES (66, '史涛', '12345', '乔洋', NULL, NULL, NULL, NULL, NULL, 'STUDENT');
INSERT INTO `student` VALUES (67, '阎杰', '12345', '武静', NULL, NULL, NULL, NULL, NULL, 'STUDENT');
INSERT INTO `student` VALUES (68, '何霞', '12345', '龙秀兰', NULL, NULL, NULL, NULL, NULL, 'STUDENT');
INSERT INTO `student` VALUES (69, '秦秀英', '12345', '陆涛', NULL, NULL, NULL, NULL, NULL, 'STUDENT');
INSERT INTO `student` VALUES (70, '董磊', '12345', '余霞', NULL, NULL, NULL, NULL, NULL, 'STUDENT');
INSERT INTO `student` VALUES (71, '韩伟', '12345', '锺洋', NULL, NULL, NULL, NULL, NULL, 'STUDENT');
INSERT INTO `student` VALUES (72, '汤刚', '12345', '林洋', NULL, NULL, NULL, NULL, NULL, 'STUDENT');
INSERT INTO `student` VALUES (73, '邵秀英', '12345', '康洋', NULL, NULL, NULL, NULL, NULL, 'STUDENT');
INSERT INTO `student` VALUES (74, '孙强', '12345', '尹敏', NULL, NULL, NULL, NULL, NULL, 'STUDENT');
INSERT INTO `student` VALUES (75, '曹秀英', '12345', '夏霞', NULL, NULL, NULL, NULL, NULL, 'STUDENT');
INSERT INTO `student` VALUES (76, '毛平', '12345', '龚磊', NULL, NULL, NULL, NULL, NULL, 'STUDENT');
INSERT INTO `student` VALUES (77, '龚军', '12345', '尹洋', NULL, NULL, NULL, NULL, NULL, 'STUDENT');
INSERT INTO `student` VALUES (78, '熊静', '12345', '毛娜', NULL, NULL, NULL, NULL, NULL, 'STUDENT');

-- ----------------------------
-- Table structure for student_course
-- ----------------------------
DROP TABLE IF EXISTS `student_course`;
CREATE TABLE `student_course`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '课程名称',
  `no` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '课程编号',
  `student_id` int(11) NULL DEFAULT NULL COMMENT '学生ID',
  `course_id` int(11) NULL DEFAULT NULL COMMENT '课程ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '学生选课' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of student_course
-- ----------------------------
INSERT INTO `student_course` VALUES (6, '语文', 'CS1103', 1, 3);
INSERT INTO `student_course` VALUES (9, '数学', 'CS1102', 17, 2);

SET FOREIGN_KEY_CHECKS = 1;
