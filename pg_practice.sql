-- 問題1. postgresqlでpracticeデータベースを生成するSQL文を記述してください。
CREATE DATABASE practice;


-- 問題2. postgresqlでpracticeデータベースのusersテーブルを生成するSQL文を記述してください。
CREATE TABLE users (
  id SERIAL NOT NULL ,
  name CHARACTER(255) NOT NULL DEFAULT COMMENT'氏名',
  age INTEGER NOT NULL DEFAULT (0, '年齢'),
  gender ENUM('Man','Woman','Other') NOT NULL DEFAULT('Other','性別'),
  PRIMARY KEY (id));


-- 問題3. postgresqlでpracticeデータベースのjobsテーブルを生成するSQL文を記述してください。
CREATE TABLE jobs (
  id SERIAL NOT NULL,
  user_id INTEGER NOT NULL,
  name CHARACTER(255) NOT NULL DEFAULT ('会社員','仕事名'),
  PRIMARY KEY (`id`),
  FOREIGN KEY `fk_user_id` (`user_id`) REFERENCES `users`(`id`)
) ;