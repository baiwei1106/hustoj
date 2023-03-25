SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for compileinfo
-- ----------------------------
DROP TABLE IF EXISTS `compileinfo`;
CREATE TABLE `compileinfo`  (
  `solution_id` int NOT NULL DEFAULT 0,
  `error` text NULL,
  PRIMARY KEY (`solution_id`) USING BTREE
) ENGINE = InnoDB ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for custominput
-- ----------------------------
DROP TABLE IF EXISTS `custominput`;
CREATE TABLE `custominput`  (
  `solution_id` int NOT NULL DEFAULT 0,
  `input_text` text NULL,
  PRIMARY KEY (`solution_id`) USING BTREE
) ENGINE = InnoDB ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for problem
-- ----------------------------
DROP TABLE IF EXISTS `problem`;
CREATE TABLE `problem`  (
  `problem_id` int NOT NULL AUTO_INCREMENT,
  `spj` int NOT NULL DEFAULT 0,
  `time_limit` decimal(10, 3) NOT NULL DEFAULT 0.000,
  `memory_limit` int NOT NULL DEFAULT 0,
  PRIMARY KEY (`problem_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1000 ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for runtimeinfo
-- ----------------------------
DROP TABLE IF EXISTS `runtimeinfo`;
CREATE TABLE `runtimeinfo`  (
  `solution_id` int NOT NULL DEFAULT 0,
  `error` text NULL,
  PRIMARY KEY (`solution_id`) USING BTREE
) ENGINE = InnoDB ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sim
-- ----------------------------
DROP TABLE IF EXISTS `sim`;
CREATE TABLE `sim`  (
  `s_id` int NOT NULL,
  `sim_s_id` int NULL DEFAULT NULL,
  `sim` int NULL DEFAULT NULL,
  PRIMARY KEY (`s_id`) USING BTREE
) ENGINE = InnoDB ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for solution
-- ----------------------------
DROP TABLE IF EXISTS `solution`;
CREATE TABLE `solution`  (
  `solution_id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `problem_id` int NOT NULL DEFAULT 0,
  `contest_id` int NOT NULL DEFAULT 0,
  `user_id` int NOT NULL DEFAULT 0,
  `time` int NOT NULL DEFAULT 0,
  `memory` int NOT NULL DEFAULT 0,
  `result` smallint NOT NULL DEFAULT 0,
  `language` int UNSIGNED NOT NULL DEFAULT 0,
  `judgetime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `pass_rate` decimal(4, 3) UNSIGNED NOT NULL DEFAULT 0.000,
  `judger` char(16) NOT NULL DEFAULT 'LOCAL',
  PRIMARY KEY (`solution_id`) USING BTREE,
  INDEX `uid`(`user_id` ASC) USING BTREE,
  INDEX `pid`(`problem_id` ASC) USING BTREE,
  INDEX `res`(`result` ASC) USING BTREE,
  INDEX `cid`(`contest_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1000 ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for source_code
-- ----------------------------
DROP TABLE IF EXISTS `source_code`;
CREATE TABLE `source_code`  (
  `solution_id` int NOT NULL,
  `source` text NOT NULL,
  PRIMARY KEY (`solution_id`) USING BTREE
) ENGINE = InnoDB ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
