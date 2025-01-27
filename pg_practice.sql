-- 問題1. postgresqlでpracticeデータベースを生成するSQL文を記述してください。
CREATE DATABASE practice;


-- 問題2. postgresqlでpracticeデータベースのusersテーブルを生成するSQL文を記述してください。
CREATE TYPE gender as ENUM('Man','Woman','Other');

CREATE TABLE users (
  id SERIAL NOT NULL ,
  name VARCHAR(255) NOT NULL default '',
  age INTEGER NOT NULL DEFAULT 0,
  gender gender NOT NULL DEFAULT('Other'),
  PRIMARY KEY (id));


-- 問題3. postgresqlでpracticeデータベースのjobsテーブルを生成するSQL文を記述してください。
CREATE TABLE jobs(
    id SERIAL NOT NULL,
    user_id INTEGER NOT NULL,
    name CHARACTER(255) NOT NULL DEFAULT '会社員',
    PRIMARY KEY(id),
    FOREIGN KEY(user_id) REFERENCES users(id)
)
;