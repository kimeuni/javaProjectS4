show tables;

-- 회원 테이블
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
	userDel char(1) default 'N', 				/* 회원 탈퇴 유무 (탈퇴:Y / 탈퇴x: N / 누적 신고로인형 계정 비활성화 : R) */
	adminYN char(1) default 'N', 				/* 관리자 확인 (일반회월:N / 관리자:Y) */
	startDate datetime default now(), 			/* 계정 생성일 */
	lastDate datetime default now(), 			/* 마지막 접속일 */
	adYN char(1) not null default 'Y',			/* 이메일 광고 수신 유무 (광고o : Y / 광고x : N) */ 
	token varchar(10) not null default 'damoa', /* 카카오 유저, 일반 유저 확인(일반회원가입:damoa /카카오회원가입:kakao) */
	totReportCnt int default 0;
	primary key(idx),
	unique key(mid)
);

-- 관리자 부여
insert into memberS values (default,'admin','1234','관리자','관리자','','axdc1234@naver.com','여자',default,default,'Y',default,default,'N');
select *,count(*) as cnt from memberS group by email ;

drop table memberS;

desc memberS;

select * from memberS;

-- 계정 탈퇴 타이틀 추가 테이블
create table reasonTitleS(
	code char(5) not null primary key, 	/* 타이틀 코드 */
	title varchar(30) not null,			/* 탈퇴 타이틀 */
	displayNone char(1) default 'Y'		/* 보이는 유무 (보임 : Y / 안보임 : N) */
);

insert into reasonTitleS values('A0001','찾는 물품이 없어요',default);
insert into reasonTitleS values('A0002','물품이 안 팔려요',default);
insert into reasonTitleS values('A0003','비매너 사용자를 만났어요',default);
insert into reasonTitleS values('A0004','새 상점을 만들고 싶어요',default);
insert into reasonTitleS values('A0005','개인정보를 삭제하고 싶어요',default);
insert into reasonTitleS values('A0006','이용이 불편하고 장애가 많아요',default);
insert into reasonTitleS values('A0007','사용 빈도가 낮아요',default);
insert into reasonTitleS values('A9999','기타',default);

desc reasonTitleS;

select * from reasonTitleS;

-- 계정 탈퇴 이유
create table userDelReasonS(
	idx int not null auto_increment primary key,			/* 고유번호 */
	titleCode char(5) not null,								/* 타이틀 코드(외래키 설정) */
	reason varchar(51) not null,							/* 탈퇴 이유 (타이틀이 '기타'이면 여기에 작성한 이유가 들어가고, 다른 타이틀이면 타이틀 값과 동일하게 들어감) */
	rDate datetime default now(),
	foreign key(titleCode) references reasonTitleS (code)
);

desc userDelReasonS;
select * from userReportS;
select * from userDelReasonS;

drop table userDelReasonS;

insert into userDelReasonS values(default,'A0009','삭제테스트',default);

-- 유저 신고 처리 DB
create table userReportS(
	idx int not null auto_increment primary key,	/* 고유번호 */
	mid varchar(17) not null,						/* 아이디 */
	part varchar(20) not null,						/* 분류(ask:문의 / used:중고거래 / reply: 댓글) */
	partIdx int not null,							/* 분류 idx */
	rDate datetime default now(),					/* 신고 처리 날짜 */
	reason varchar(301) default '',					/* 신고 이유 */
	
	foreign key(mid) references memberS (mid)
);