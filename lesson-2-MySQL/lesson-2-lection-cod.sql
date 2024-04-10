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

-- Вибрати ідентифікатор, ім'я у нижньому регістрі, вік та стать кожного користувача
select id, lower(name) as name, age, gender
from users;

-- Вибрати ідентифікатор, ім'я у верхньому регістрі, вік та стать кожного користувача
select id, upper(name) as name, age, gender
from users;