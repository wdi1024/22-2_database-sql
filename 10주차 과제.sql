'''
※ 다음의 요구사항에 따라 테이블을 생성하는 SQL문을 작성하세요.
개요 : 개인의 차량을 공유할 수 있는 어플리케이션을 개발하여 차량을 등록하고 고객들이 대여할 수 있도록 하는 서비스를 할 계획이다.
요구사항:
① 차량을 공유하고자 하는 사람(Owner)은 공유자ID(oid), 전화번호(tel), 이메일주소(o_mail)를 등록한다.
② 등록한 차량(Cars)은 차량ID(cid), 공유자ID(oid), 차량번호(number), 차량종류(category), 승차인원(capacity), 시간당대여비용(h_price)를 가진다.
③ 고객(Customer)은 고객ID(cid), 고객이름(c_name), 고객주소(c_address), 고객전화번호(c_tel), 운전면허번호(license), 가장 최근에 대여한 날짜(recent_date) 및 차량종류(category)를 등록한다.
④ 고객은 원하는 차량을 대여할 수 있다. 대여(rent)를 하게 되면 대여시작일(s_date), 대여시간(hours), 차량ID(cid), 고객ID(cid), 청구요금(t_price), 요구사항(needs)를 등록한다. 청구요금은 대여시간에 시간당대여비용(10,000원)을 곱한 값이다.
'''

DROP DATABASE IF EXISTS  test;
DROP USER IF EXISTS  test@localhost;
create user test@localhost identified WITH mysql_native_password  by 'test';
create database test;
grant all privileges on test.* to madang@localhost with grant option;
commit;

use test;

CREATE TABLE Owner(
	oid INTEGER NOT NULL,
    tel VARCHAR(20),
    e_mail VARCHAR(30),
    PRIMARY KEY (oid));
CREATE TABLE Cars(
	caid INTEGER NOT NULL,
    oid INTEGER,
    number VARCHAR(30),
    category VARCHAR(20),
    capacity INTEGER,
    h_price FLOAT,
    PRIMARY KEY (caid),
	FOREIGN KEY (oid) REFERENCES Owner(oid) ON DELETE CASCADE);
CREATE TABLE Customer(
	cuid INTEGER NOT NULL,
    c_name VARCHAR(20),
    c_address VARCHAR(40),
    c_tel VARCHAR(20),
    license VARCHAR(20) NOT NULL UNIQUE,
    recent_date DATE,
    category VARCHAR(20),
    PRIMARY KEY (cuid));
CREATE TABLE Rent(
	s_date DATE NOT NULL,
    hours INTEGER,
    caid INTEGER,
    cuid INTEGER,
    t_price INTEGER DEFAULT(hours*10000),
    needs VARCHAR(40),
    PRIMARY KEY (s_date, cuid),
	FOREIGN KEY (caid) REFERENCES Cars(caid),
    FOREIGN KEY (cuid) REFERENCES Customer(cuid) ON DELETE CASCADE);