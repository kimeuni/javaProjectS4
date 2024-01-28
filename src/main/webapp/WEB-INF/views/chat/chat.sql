show tables;

-- 채팅 이모티콘
create table emoticonS(
	idx int not null auto_increment primary key,
	img varchar(50) not null,
	eDate datetime default now()
);

-- 채팅 그룹
create table chatGroupS(
	idx int not null auto_increment primary key,
	usedIdx int not null default 0,
	usedMid varchar(17) not null,
	myMid varchar(17) not null
);

-- 채팅
create table chatS(
	idx int not null auto_increment primary key,
	chatIdx int not null,
	usedMid varchar(17) not null,
	myMid varchar(17) not null,
	chat varchar(101),
	emoticon varchar(50),
	alarm char(1) default 'Y',
	chatDate datetime default now(),
	whoChatMid varchar(17) not null,
	
	foreign key (chatIdx) references chatGroupS (idx)
);
