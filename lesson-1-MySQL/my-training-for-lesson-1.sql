use osetrov;

select * from users;

select * from users where name = 'Max';

select *from users where name like 'o%';
select * from users where name like 'm%';

select * from users where name like 'p%';
select *from users where age >10;
select * from users where name like '%o%';
select * from users where name like '__e%';

select * from users where name like '_l%';

select * from users where age=30;
select * from users where age>=20;
select * from users where age<=20;
select * from users where age>30;
select * from users where age!=20;

select *from users where age between 20 and 30;
select * from users where age not between 20 and 30;

select * from users where name = 'Oleg' or name = 'olha' and age = 20;

# входження в список - перелічення
select * from users where age in (24, 30,45);
select * from users where age not in (20, 22,24);

select * from users where length(name) = 3;

# сортування, по замовчуванню - по id.
select * from users;
select * from users  order by age;
# select * from users  order by age asc;
select * from users  order by age desc ;

# виводимо частину
select * from users limit 2;
select * from users limit 2 offset 2; # беремо 2 пропустивши 2ю
select * from users order by id desc limit 5;

# sum(), avg(), count(), min(), max().
# агрегатні функції. Агрегатні функції - це функції, які використовуються для обчислення значень на основі даних у
# стовпцях. Вони використовуються разом з операціями групування, такими як GROUP BY, для обчислення результатів для
# кожної групи. Ці агрегатні функції можуть бути використані окремо або разом з операціями групування.

#  COUNT: Використовується для підрахунку кількості рядків у виборці.
SELECT COUNT(*) FROM users;

# SUM: Обчислює суму значень у виборці.
SELECT SUM(price) FROM cars;

# AVG: Обчислює середнє значення у виборці.
SELECT AVG(age) FROM users;

# MIN: Знаходить мінімальне значення у виборці.
SELECT MIN(price) FROM cars;

# MAX: Знаходить максимальне значення у виборці.
SELECT MAX(price) FROM cars;

select max(age) from users; # відповідь - 50, а у json піде {'max(age)': 50}
select max(age) as maxAge from users; # {'maxAge': 50}

select count(*) from users where name = 'oleg';

# групування
select count(*) as count, gender from users group by gender;
select max(age) as ageMax, gender from users group by gender;

select max(age) from users ; # 50
SELECT name, age FROM users WHERE age = (SELECT MAX(age) FROM users);
# або
        SELECT name, age
        FROM users ORDER BY age DESC
        LIMIT 1;

select count(*) as count, model from cars where year > 2020 group by model having count >= 2;

# create , delete, update
CREATE TABLE users2024 (
                       id INT PRIMARY KEY AUTO_INCREMENT,
                       name VARCHAR(50),
                       age INT
);

insert into users2024 (id, name, age) values (null, 'Sem', 35);

delete from users2024 where id = 1;

update users2024 set name = 'Anatolij' where id = 1;
