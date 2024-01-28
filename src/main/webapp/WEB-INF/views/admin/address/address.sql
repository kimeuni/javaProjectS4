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

