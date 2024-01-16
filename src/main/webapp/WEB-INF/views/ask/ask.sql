show tables;

-- 1:1 질문 등록
create table askS(
	idx int not null auto_increment primary key,	/* 고유번호 */
	mid varchar(17) not null,						/* 등록한 사람 아이디 */
	title varchar(41) not null,						/* 제목 */
	content varchar(301) not null,					/* 내용 */
	imgs varchar(300),								/* 이미지 */
	category varchar(50) not null,					/* 유형(카테고리) */
	askDate datetime default now(),					/* 질문한 날짜 */
	status char(4) not null default '답변대기',		/* 현재상태 (답변대기/답변완료) */
	reportShop varchar(17) not null default '',		/* 신고하는 상점 mid */
	
	foreign key(mid) references memberS (mid)
);

drop table askS;
select *,timestampdiff(hour,askDate,now()) as hour_diff,datediff(now(),askDate) as date_diff,
		(select datediff(now(),ansDate) from answerS an where ask.idx = an.askIdx) as ans_date_diff
		 from askS ask where status = '답변완료'
-- 1:1 질문 답변
create table answerS(
	idx int not null auto_increment primary key,	/* 고유번호 */
	askIdx int not null,							/* 질문 등록 idx */
	content text not null,							/* 답변 내용 */
	ansDate datetime default now(),					/* 답변한 날짜 */
	
	foreign key(askIdx) references askS (idx)
);

select *,timestampdiff(hour,askDate,now()) as hour_diff,datediff(now(),askDate) as date_diff from askS where status = '답변완료'