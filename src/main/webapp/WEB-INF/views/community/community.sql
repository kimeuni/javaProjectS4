show tables;

-- 커뮤니티 글 올리기
create table communityS(
	idx int not null auto_increment primary key,
	mid varchar(17) not null,
	content varchar(141) not null,
	imgs varchar(400) not null,
	cDate datetime default now(),
	region varchar(20) not null,
	
	foreign key (mid) references memberS (mid)
);

drop table communityS;