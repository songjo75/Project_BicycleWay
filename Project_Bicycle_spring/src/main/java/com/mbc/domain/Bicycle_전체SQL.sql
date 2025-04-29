-- [MySQL  root 에서 작업.]
create database bicycle;
create user 'bicycle'@'localhost' identified by '1212';
flush privileges;

grant all privileges on bicycle.* to 'bicycle'@'localhost';


-- [MySQL  ysj user 에서 작업.]
-- varchar(2) 는 오라클에서.   MySQL 은 varchar
-- number 는 오라클에서.    MySQL 은 int
-- sequence는 오라클에서.   MySQL 은 컬럼에 auto_increment

use bicycle;

-- 관리자 테이블 admin (관리자 등록)
drop table tbl_bicycle_admin;
create table tbl_bicycle_admin(
    id varchar(20) not null,
    password varchar(20) not null,
    name varchar(20) not null,
    email varchar(50) not null
);


insert into tbl_bicycle_admin values('admin', '1212', '관리자', 'abc@gmail.com');
select * from tbl_bicycle_admin;
commit;


-- 회원테이블
drop table tbl_bicycle_member;
create table tbl_bicycle_member(
    id varchar(20) unique not null,
    pw varchar(200) not null,
    name varchar(50) not null,
    tel varchar(20) not null,
    email varchar(50) not null,
    addr varchar(100) not null,
    rdate timestamp not null
);

-- 회원가입 화면 만들어서 넣자.   패스워드 암호화해서 넣어야 하니까.
--insert into tbl_bicycle_member values('member1', '1212', '김길동', '1111', 'member1@gmail.com', '서울', now());
--insert into tbl_bicycle_member values('member2', '1212', '박길동', '2222', 'member2@gmail.com', '서울', now());

select * from tbl_bicycle_member;
commit;



-- 자전거이용권 카테고리 데이블
drop table tbl_bicycle_category;
create table tbl_bicycle_category(
    cat_num int auto_increment primary key,
    code varchar(10) unique not null,
    cat_name varchar(50) not null    --  카테고리 ( 일이용권 / 기간이용권 ) 
);

select * from tbl_bicycle_category;


-- 자전거이용권(상품) 테이블
drop table tbl_bicycle_product;
create table tbl_bicycle_product(
    pnum int auto_increment primary key, 	-- 상품번호
    pname varchar(50) not null,    -- 이용권명  ( 1시간권/2시간권/3시간권/7일권/10일권/30일권 ) 
    pcategory_fk varchar(20) not null, -- 카테고리 ( 일이용권(DAY) / 기간이용권(PERIOD) ) 
 -- pcompany varchar(50),  	-- 출판사
    pimage varchar(50),        -- 상품이미지
    
    pqty int default 0, 	-- 수량
    price int default 0, -- 가격
 -- pspec varchar(20),         -- 상품사양(베스트, 신간)
    pcontent varchar(300),     -- 상품상세  
    point int default 0,  -- 상품별 포인트
    pinput_date date   ,         -- 등록 날짜
    
    foreign Key(pcategory_fk) references tbl_bicycle_category(code)
);

select * from tbl_bicycle_product;


-- 자전거종류 (소개를 위한) 테이블
drop table tbl_bicycle_kind;
create table tbl_bicycle_kind(
    kind_code varchar(50) primary key, 	-- 자전거 종류코드
    kind_name varchar(200) not null,    -- 자전거 종류명
    kind_image varchar(50),        -- 상품이미지
 --   kind_spec varchar(20),         -- 사양(베스트, 신규, 인기)
    content varchar(4000),     -- 상품상세  
    input_date date           -- 등록 날짜
);



-- 구매 테이블
drop table tbl_bicycle_buy;
create table tbl_bicycle_buy(
    buy_id int auto_increment primary key,
    id varchar(20) not null,
    pnum int not null,
    pname varchar(50) not null,
    pqty int default 1,
    price int,
    indate timestamp not null,
    
    foreign key (id) references tbl_bicycle_member(id)  on delete cascade ,
    foreign key (pnum) references tbl_bicycle_product(pnum) on delete cascade
);

select * from tbl_bicycle_buy;
