show tables;

create table memberS(
	idx int not null auto_increment, 			/* 고유번호 */
	mid varchar(17) not null, 					/* 아이디 */
	pwd varchar(200) not null, 					/* 비밀번호 */
	name varchar(11) not null, 					/* 이름 */
	nickName varchar(13) not null, 				/* 닉네임 */
	address varchar(100) not null, 				/* 주소 */
	email varchar(60) not null, 				/* 이메일 */
	gender char(2) not null, 					/* 성별 (여자/남자) */
	profile varchar(100) default "no_img.png", 	/* 기본 프로필 */
	userDel char(1) default 'N', 				/* 회원 탈퇴 유무 (탈퇴:Y / 탈퇴x: N) */
	adminYN char(1) default 'N', 				/* 관리자 확인 (일반회월:N / 관리자:Y) */
	startDate datetime default now(), 			/* 계정 생성일 */
	lastDate datetime default now(), 			/* 마지막 접속일 */
	adYN char(1) not null default 'Y',			/* 이메일 광고 수신 유무 (광고o : Y / 광고x : N) */ 
	token varchar(10) not null default 'damoa', /* 카카오 유저, 일반 유저 확인(일반회원가입:damoa /카카오회원가입:kakao) */
	primary key(idx),
	unique key(mid)
);

-- 관리자 부여
insert into memberS values (default,'admin','1234','관리자','관리자','','axdc1234@naver.com','여자',default,default,'Y',default,default,'N');

drop table memberS;

desc memberS;

select * from memberS;