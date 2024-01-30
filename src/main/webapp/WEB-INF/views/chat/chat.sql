show tables;

-- 채팅 이모티콘
create table emoticonS(
	idx int not null auto_increment primary key,
	img varchar(50) not null,
	eDate datetime default now()
);
select * from chatGroupS where (mid1 = 'admin' or mid2 = 'admin') and (mid1 = 'axdc1234' or mid2 = 'axdc1234')
-- 채팅 그룹
create table chatGroupS(
	idx int not null auto_increment primary key,
	usedIdx int not null default 0,
	mid1 varchar(17) not null,
	mid2 varchar(17) not null
);

drop table chatGroupS;

-- 채팅
create table chatS(
	idx int not null auto_increment primary key,
	chatIdx int not null,
	mid1 varchar(17) not null,
	mid2 varchar(17) not null,
	emoticon varchar(50) default 0,
	chat varchar(101),
	alarm char(1) default 'Y',
	chatDate datetime default now(),
	whoChatMid varchar(17) not null,
	
	foreign key (chatIdx) references chatGroupS (idx)
);

select * from chatS where idx > (select max(idx) - 30 from chatS) 
		and (mid1 = 'axdc1234' or mid2 = 'axdc1234') and (mid1 = 'admin' or mid2 = 'admin') order by idx;

select * from chatS where idx > 0 and (mid1 = 'axdc1234' or mid2 = 'axdc1234') and (mid1 = 'admin' or mid2 = 'admin') order by idx

drop table chatS;
select cg.*,(select imgs from usedS u where cg.usedIdx = u.idx) as imgs,
		(select title from usedS u where cg.usedIdx = u.idx) as title,
		(select money from usedS u where cg.usedIdx = u.idx) as money,
		(select nickName from memberS mem where mem.mid = cg.mid1) as nickName1,
		(select nickName from memberS mem where mem.mid = cg.mid2) as nickName2,
		(select lastDate from memberS mem where mem.mid = cg.mid1) as lastDate1,
		(select lastDate from memberS mem where mem.mid = cg.mid2) as lastDate2
		from chatGroupS cg where usedIdx = 12
		and (cg.mid1 = 'axdc1234' or cg.mid2 = 'axdc1234') and (cg.mid1 = 'admin' or cg.mid2 = 'admin') group by cg.idx;
		
		
		select lk.*,usd.title,usd.imgs, (select count(*) from likeS lks where usd.idx = lks.usedIdx and alarm = 'Y') as likeCnt
		from usedS usd, likeS lk where usd.mid = 'axdc1234' and usd.idx = lk.usedIdx group by usd.idx