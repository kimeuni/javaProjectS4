show tables;

-- 찾아오는 길 주소 등록
create table mapS(
	idx int not null auto_increment primary key,	/* 고유번호 */
	place varchar(20) not null,						/* 장소명 */
	address varchar(150) not null,					/* 주소 */
	latitude double not null,						/* 위도 */
	longitude double not null,						/* 경도 */
	mDate datetime default now()					/* 등록한 날짜 */
);

select (select count(*) from userdelReasonS where titleCode = 'A0001') as cnt1,
	(select title from reasonTitleS where Code = 'A0001') as title1,
	(select count(*) from userdelReasonS where titleCode = 'A0002') as cnt2,
	(select title from reasonTitleS where Code = 'A0002') as title2,
	(select count(*) from userdelReasonS where titleCode = 'A0003') as cnt3,
	(select title from reasonTitleS where Code = 'A0003') as title3,
	(select count(*) from userdelReasonS where titleCode = 'A0004') as cnt4,
	(select title from reasonTitleS where Code = 'A0004') as title4,
	(select count(*) from userdelReasonS where titleCode = 'A0005') as cnt5,
	(select title from reasonTitleS where Code = 'A0005') as title5,
	(select count(*) from userdelReasonS where titleCode = 'A0006') as cnt6,
	(select title from reasonTitleS where Code = 'A0006') as title6,
	(select count(*) from userdelReasonS where titleCode = 'A0007') as cnt7,
	(select title from reasonTitleS where Code = 'A0007') as title7,
	(select count(*) from userdelReasonS where titleCode = 'A9999') as cnt8,
	(select title from reasonTitleS where Code = 'A9999') as title8
	from reasonTitleS limit 1;