# запуск Ctrl+Enter в кінці рядка чи зелений > пуск!
use osetrov;

-- Вибрати унікальні пари значень імен та віку користувачів
select distinct name, age from users;

-- Вибрати середній вік користувачів та суму їх віку
select avg(age), sum(age) from users;

-- Вибрати середній вік користувачів у першому запиті та суму віку у другому, та об'єднати результати в 1 стовпці
select avg(age) from users
union
select sum(age) from users;

-- Показати структуру таблиці "cars"
describe cars;
                desc cars;    # скорочений запис

-- Вибрати ідентифікатор, модель, ціну та подвоєну ціну кожної машини
select id, model, price, price * 2 as doublePrice
from cars;

-- Об'єднати рядки у форматі 'My name is <ім'я> I`m <вік> gender - <стать>'
select concat('My name is ', name, ' I`m ', age, ' gender - ', gender) as strings
from users;

-- Вибрати всіх користувачів з ім'ям 'Ms Olha Female'
select * from users
where concat('Ms ', name, ' ', gender) = 'Ms Olha Female';




-- Вибрати всіх користувачів, де вік дорівнює ідентифікатору плюс 12
select *
from users
where age = id + 12;

-- Вибрати всіх користувачів, чиє ім'я починається з літери 'm' але є більшим за 'max' у порядку сортування
select *
from users
where name > 'max';

-- можна вказати номер стовпця, для сортування (від > до < - desc)...
    select *from cars order by 4 desc;

-- Вибрати ідентифікатор, ім'я у нижньому регістрі, вік та стать кожного користувача
select id, lower(name) as name, age, gender
from users;

-- Вибрати ідентифікатор, ім'я у верхньому регістрі, вік та стать кожного користувача
select id, upper(name) as name, age, gender
from users;


#      ////////////////////////////// join //////////////////////////////////////////

-- Обрати всіх клієнтів, заявки яких розміщені в Києві, приєднуючи таблиці client, application та department
select *
from client
         join application on client.idClient = application.Client_idClient
         join department on department.idDepartment = client.Department_idDepartment
where City = 'Kyiv';

-- Видалити таблицю "cars"
drop table cars;

-- Створити таблицю "cities" з колонками id та city
create table cities
(
    id   int primary key not null auto_increment,
    city varchar(20)     not null
);

-- Вставити значення 'Kyiv' у таблицю "cities"
insert into cities (city)
values ('Kyiv');

-- Створити таблицю "user" з колонками id, name, age та city_id
create table user
(
    id      int primary key not null auto_increment,
    name    varchar(20)     not null,
    age     int             not null,
    city_id int             null,
    foreign key (city_id) references cities (id)
);

-- Вибрати ідентифікатор, ім'я, вік та місто користувача з таблиці "user", приєднуючи її до таблиці "cities"
select user.id, user.name, age, c.city
from user
         join cities c on c.id = user.city_id
where city = 'lviv';

-- Вибрати всі записи з таблиці "user" з використанням лівого з'єднання з таблицею "cities"
select * from user left join cities c on c.id = user.city_id;

-- Вибрати всі записи з таблиці "user" з використанням правого з'єднання з таблицею "cities"
select * from user right join cities c on c.id = user.city_id;

-- Вибрати всі записи з таблиці "cars", ціна яких перевищує середню ціну всіх автомобілів
select * from cars where price> (select avg(price) from cars);

-- Вибрати всі записи з таблиці "client", чий вік є в списку віків з таблиці "users"
select * from client where Age in (select age from users);