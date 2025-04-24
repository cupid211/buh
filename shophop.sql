drop database shop;
create  database  shop;
use shop;

create table if not exists positions(
id tinyint primary key not null auto_increment,
name varchar(30) not null);

create table if not exists employees (
id int not null primary key auto_increment,
fio varchar(50) not null,
login varchar(50) not null unique,
password varchar(30) not null, 
idPosition tinyint not null,
dateBirth date not null,
phoneNumb varchar(13) not null unique,
foreign key (idPosition) references positions(id));

create table if not exists money( -- вносят все, кроме уборщиков
id bigint not null primary key auto_increment,
idEmployee int not null,
mDate dateTime default now(), -- текущая дата
type boolean not null,
money double not null,
foreign key (idEmployee) references employees(id));

create table if not exists statistics( -- получают информацию бухгалетра, начальники отдела и директор 3 5 6
id bigint not null primary key auto_increment,
idEmployee int not null,
sDate dateTime  not null default now(),
sumExpenses double not null,-- расходы
sumIncome double not null,-- доходы
sum double not null,
foreign key (idEmployee) references employees(id));

insert into positions (name) values ("уборщик");
insert into positions (name) values ("стажер");
insert into positions (name) values ("бухгалтер");
insert into positions (name) values ("продавец");
insert into positions (name) values ("начальник отдела");
insert into positions (name) values ("директор");

insert into employees (fio, login, password, idPOsition, dateBirth, phoneNumb) values ("Глеб Пашко", "login1", "12345", 3, "2010-12-01", "+375447777777");
insert into employees (fio, login, password, idPOsition, dateBirth, phoneNumb) values ("Глеб Пашко1", "login2", "123456", 3, "2000-12-01", "+375447777776");
insert into employees (fio, login, password, idPOsition, dateBirth, phoneNumb) values ("Глеб Пашко2", "login3", "123457", 3, "2007-12-01", "+375447777775");
insert into employees (fio, login, password, idPOsition, dateBirth, phoneNumb) values ("Глеб Пашко3", "login4", "123458", 3, "2006-12-01", "+375447777774");
insert into employees (fio, login, password, idPOsition, dateBirth, phoneNumb) values ("Глеб Пашко4", "login5", "12345", 3,  "2010-12-01", "+375447777773");

insert into money (idEmployee, type, money) values (2, 1, 8.4 );
insert into money (idEmployee, type, money) values (3, 1, 10 );
insert into money (idEmployee, type, money) values (3, 0, 80 );
insert into money (idEmployee, type, money) values (4, 0, 1000.50 );
insert into money (idEmployee, type, money) values (2, 0, 6 );
insert into money (idEmployee, type, money) values (4, 1, 77 );
insert into money (idEmployee, type, money) values (3, 0, 10);

select sum(money) from money where type=0; -- Сумма
select avg(money) from money where type=1;-- Среднее
select count(idEmployee) from statistics where id=3 group by idEmployee; -- количество

select * from employees order by idPosition;-- по возрастанию
select * from employees order by idPosition desc; -- по убыванию

select employees.fio, type, money from money -- объединение нескольких таблиц
join employees on money.idEmployee=employees.id;
