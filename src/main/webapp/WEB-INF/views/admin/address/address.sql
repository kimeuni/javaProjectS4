show tables;

-- 찾아오는 길 주소 등록
create table mapS(
	idx int not null auto_increment primary key,
	place varchar(20) not null,
	address varchar(150) not null,
	latitude double not null,
	longitude double not null,
	mDate datetime default now()
);