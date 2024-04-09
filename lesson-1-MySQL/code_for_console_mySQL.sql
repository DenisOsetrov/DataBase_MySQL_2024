-- Використовуємо базу даних "osetrov"
use osetrov;     # запуст бази даних. всі команди мають закінчуватись - ; !!!
                 # запуск команд Ctrl+Enter

-- Переглядаємо наявні таблиці
SHOW TABLES;

-- Створюємо таблицю "usersNew"
CREATE TABLE usersNew (
    id INT PRIMARY KEY AUTO_INCREMENT,  -- Унікальний ідентифікатор, автоматично збільшується
    name VARCHAR(255) NOT NULL,          -- Ім'я користувача, не може бути порожнім
    age INT NOT NULL,                     -- Вік користувача, не може бути порожнім
    gender VARCHAR(6) NOT NULL           -- Стать користувача, не може бути порожньою
);

-- Вставляємо дані в таблицю "usersNew"
INSERT INTO usersNew VALUES (null, 'Denis', 38, 'male');


-- Переглядаємо наявні бази даних
SHOW DATABASES;

-- Вибираємо всі рядки з таблиці "cars"
SELECT * FROM cars;

-- Вибираємо стовпці "id", "model", "year" з таблиці "cars"
SELECT id, model, year FROM cars;

-- Вибираємо всі рядки з таблиці "users", де ім'я = 'OLEG'
SELECT * FROM users WHERE name = 'OLEG';

-- Вибираємо всі рядки з таблиці "users", де ім'я не дорівнює 'OLEG'
SELECT * FROM users WHERE name != 'OLEG';

-- Вибираємо всі рядки з таблиці "users", де ім'я починається з 'o'
SELECT * FROM users WHERE name LIKE 'o%';

-- Вибираємо всі рядки з таблиці "users", де ім'я містить 'o'
SELECT * FROM users WHERE name LIKE '%o%';

-- Вибираємо всі рядки з таблиці "users", де ім'я містить чотири символи і другий символ є 'e'
SELECT * FROM users WHERE name LIKE '__e%';

-- Вибираємо всі рядки з таблиці "users", де вік = 30
SELECT * FROM users WHERE age = 30;

-- Вибираємо всі рядки з таблиці "users", де вік не дорівнює 30
SELECT * FROM users WHERE age != 30;

-- Вибираємо всі рядки з таблиці "users", де вік знаходиться в діапазоні від 20 до 30
SELECT * FROM users WHERE age BETWEEN 20 AND 30;

-- Вибираємо всі рядки з таблиці "users", де вік не знаходиться в діапазоні від 20 до 30
SELECT * FROM users WHERE age NOT BETWEEN 20 AND 30;

-- Вибираємо всі рядки з таблиці "users", де вік знаходиться між 20 та 30 або рівний 16 і ім'я починається з одного символу і містить 'a'
SELECT * FROM users WHERE age = 16 AND name LIKE '_a%';

-- Вибираємо всі рядки з таблиці "users", де вік є одним із вказаних значень
SELECT * FROM users WHERE age IN (20, 25, 30, 45, 14);

-- Вибираємо всі рядки з таблиці "users", де вік не є одним із вказаних значень
SELECT * FROM users WHERE age NOT IN (20, 25, 30, 45, 14);

-- Вибираємо всі рядки з таблиці "users", де довжина імені дорівнює 4
SELECT * FROM users WHERE LENGTH(name) = 4;

-- Вибираємо всі рядки з таблиці "users" і сортуємо за ім'ям у порядку зростання
SELECT * FROM users ORDER BY name asc;

-- Вибираємо всі рядки з таблиці "users" і сортуємо за ім'ям у порядку зростання (по замовчуванню)
SELECT * FROM users ORDER BY name;

-- Вибираємо всі рядки з таблиці "users" і сортуємо за ім'ям у порядку спадання
SELECT * FROM users ORDER BY name DESC;

-- Вибираємо всі рядки з таблиці "users" і сортуємо за віком у порядку спадання
SELECT * FROM users ORDER BY age DESC;

-- Вибираємо всі рядки з таблиці "users", сортуємо за віком у порядку спадання та обмежуємо кількість результатів (відміщенням рядків)
SELECT * FROM users ORDER BY age DESC LIMIT 2 OFFSET 6;

-- Вибираємо мінімальний вік з таблиці "users"
SELECT MIN(age) AS minAge FROM users;

-- Вибираємо максимальний вік з таблиці "users"
SELECT MAX(age) AS maxAge FROM users;

-- Обчислюємо суму віку користувачів
SELECT SUM(age) AS sumOfAge FROM users;

-- Обчислюємо середній вік користувачів
SELECT AVG(age) AS avgOfAge FROM users;

-- Підраховуємо кількість користувачів
SELECT COUNT(*) AS count FROM users;
-- переглянути наявність стовпців
DESCRIBE users;

-- Підраховуємо кількість користувачів для кожної статі, де вік менше або дорівнює 25, та групуємо за статтю
SELECT COUNT(*) AS count, gender FROM users WHERE age <= 25 GROUP BY gender;

-- Підраховуємо кількість автомобілів для кожної моделі, які випущені після 2020 року та мають кількість більше або рівну 2
SELECT COUNT(*) AS count, model FROM cars WHERE year > 2020 GROUP BY model HAVING count >= 2;

-- Створюємо таблицю "users"
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,  -- Унікальний ідентифікатор, автоматично збільшується
    name VARCHAR(20) NOT NULL,           -- Ім'я користувача, не може бути порожнім
    age INT NOT NULL,
    gender int not null -- Вік користувача, не може бути порожнім
);

-- Вставляємо дані в таблицю "users"
INSERT INTO users VALUES (null, 'Max', 15, 'male');

-- Вибираємо всі рядки з таблиці "users"
SELECT * FROM users;

-- Видаляємо рядок з таблиці "users", де id = 6
DELETE FROM users WHERE id = 6;

-- Оновлюємо дані в таблиці "users", змінюємо ім'я на 'Karina' для рядка з id = 5
UPDATE users SET name = 'Karina' WHERE id = 5;