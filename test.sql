/*
 Navicat Premium Data Transfer

 Source Server         : local
 Source Server Type    : MySQL
 Source Server Version : 100422
 Source Host           : localhost:3306
 Source Schema         : test

 Target Server Type    : MySQL
 Target Server Version : 100422
 File Encoding         : 65001

 Date: 28/03/2022 12:35:37
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for crud
-- ----------------------------
DROP TABLE IF EXISTS `crud`;
CREATE TABLE `crud`  (
  `StudentID` int(11) NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `LastName` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `State` int(5) NULL DEFAULT NULL,
  `MIddleName` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`StudentID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of crud
-- ----------------------------
INSERT INTO `crud` VALUES (1, NULL, NULL, 1, NULL);
INSERT INTO `crud` VALUES (2, 'uop', 'ioig', NULL, 'jgf');
INSERT INTO `crud` VALUES (3, 'seen', 'seeb', NULL, 'senn');
INSERT INTO `crud` VALUES (4, NULL, NULL, NULL, NULL);
INSERT INTO `crud` VALUES (5, NULL, NULL, NULL, NULL);
INSERT INTO `crud` VALUES (6, NULL, NULL, NULL, NULL);
INSERT INTO `crud` VALUES (7, NULL, NULL, NULL, NULL);
INSERT INTO `crud` VALUES (8, NULL, NULL, NULL, NULL);
INSERT INTO `crud` VALUES (9, NULL, NULL, NULL, NULL);
INSERT INTO `crud` VALUES (10, NULL, NULL, NULL, NULL);
INSERT INTO `crud` VALUES (11, NULL, NULL, NULL, NULL);
INSERT INTO `crud` VALUES (12, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for event
-- ----------------------------
DROP TABLE IF EXISTS `event`;
CREATE TABLE `event`  (
  `EventID` int(11) NOT NULL AUTO_INCREMENT,
  `EventName` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `EventDetails` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`EventID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of event
-- ----------------------------
INSERT INTO `event` VALUES (1, 'First Event', 'Some event there is');

-- ----------------------------
-- Table structure for joined
-- ----------------------------
DROP TABLE IF EXISTS `joined`;
CREATE TABLE `joined`  (
  `studentjoinID` int(11) NOT NULL AUTO_INCREMENT,
  `StudentID` int(25) NULL DEFAULT NULL,
  `EventID` int(25) NULL DEFAULT NULL,
  `Status` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`studentjoinID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of joined
-- ----------------------------
INSERT INTO `joined` VALUES (2, 3300, 1, '1');
INSERT INTO `joined` VALUES (16, 201, 1, '1');

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student`  (
  `StudentID` int(11) NOT NULL AUTO_INCREMENT,
  `FullName` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `Status` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `Contact` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `Image` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`StudentID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20131010 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES (201, 'Student1', '1', '0910492101', '201.png');
INSERT INTO `student` VALUES (999, 'admin', '2', 'admin', 'admin.png');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `UserID` int(25) NOT NULL AUTO_INCREMENT,
  `StudentID` varchar(11) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `Password` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `Status` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`UserID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (25, '201', '1234', '1');
INSERT INTO `user` VALUES (27, '999', '1234', '2');

SET FOREIGN_KEY_CHECKS = 1;
