# запуск Ctrl+Enter в кінці рядка чи зелений > пуск!
use osetrov;

# 1.Вибрати усіх клієнтів, чиє ім'я має менше ніж 6 символів.
select * from client where length(FirstName) < 6;


# 2.Вибрати львівські відділення банку.
select *
from department
where DepartmentCity = 'lviv';
# select * from client where City = 'Lviv' and Department_idDepartment = 2; # відкрив у Львові у львісському відділенні
#    -- через loin. До таб. client приєднали таб. department форент ключем ---
# select *from client
#     join osetrov.department d on d.idDepartment = client.Department_idDepartment
#         where Department_idDepartment = 2;


# 3.Вибрати клієнтів з вищою освітою та посортувати по прізвищу.
    select * from client
             where Education = 'high'
             order by LastName;

# 4.Виконати сортування у зворотньому порядку над таблицею Заявка і вивести 5 останніх елементів.
select *
from application
order by idApplication desc
limit 5;
#     select * from application order by Sum desc limit 5;

# 5.Вивести усіх клієнтів, чиє прізвище закінчується на OV чи OVA.
    select * from client
             where LastName like '%ov'
                or LastName like '%ova';

# 6.Вивести клієнтів банку, які обслуговуються київськими відділеннями.
        select idClient, FirstName, LastName, DepartmentCity
        from client
                 join department d on d.idDepartment = client.Department_idDepartment
        where DepartmentCity = 'Kyiv';


# 7.Знайти унікальні імена клієнтів.
    select distinct FirstName from client;
                    # або
    SELECT * FROM client
    WHERE FirstName IN (SELECT DISTINCT FirstName FROM client);
                    # або
    SELECT c1.*
            FROM client c1
                JOIN (
    SELECT FirstName, MAX(idClient) AS max_id
    FROM client
    GROUP BY FirstName
                    ) c2 ON c1.FirstName = c2.FirstName AND c1.idClient = c2.max_id;
#     пояснення:
                # У підзапиті ми обчислюємо максимальний idClient для кожного унікального імені клієнта. MAX(idClient) AS max_id - це агрегатна функція, яка обчислює максимальне значення idClient для кожної групи за ім'ям клієнта (FirstName).
                # Після того, як у підзапиті отримано максимальний idClient для кожного імені клієнта, ми об'єднуємо результати цього підзапиту з основною таблицею клієнтів (client). Ми робимо це через з'єднання (JOIN) за умовою, що значення FirstName співпадають, а також за умовою, що idClient в основній таблиці дорівнює максимальному idClient для кожного імені, який ми отримали в підзапиті.
                # Основний запит вибирає всі поля (*) з основної таблиці клієнтів (client) для кожного клієнта, чий idClient збігається з максимальним значенням idClient для відповідного імені, що було обчислено в підзапиті.


# 8.Вивести дані про клієнтів, які мають кредит більше ніж на 5000 гривень. / і впорядкували по зростанню
select distinct client.*
from client
         join application a on client.idClient = a.Client_idClient
where Sum > 5000;

        # виводимо клієнтів, які маєть кредити >5000, навіть якщо кредитів 2, а клієнт 1.
select *from client
join application a on client.idClient = a.Client_idClient
where Sum > 5000 order by Sum;


# 9.Порахувати кількість клієнтів усіх відділень та лише львівських відділень.
select count(*) as all_lviv
from client
         join department d on d.idDepartment = client.Department_idDepartment;

select count(*)
from client
         join department d2 on d2.idDepartment = client.Department_idDepartment
where DepartmentCity = 'lviv';
# or
select (select count(*)
        from client
                 join department d on d.idDepartment = client.Department_idDepartment) as all_count,
       (select count(*)
        from client
                 join department d on d.idDepartment = client.Department_idDepartment
        where DepartmentCity = 'lviv') as lviv_count;


SELECT
    COUNT(*) AS totalClients,
    SUM(Department_idDepartment = 2) AS clientsOfLvivDepartment
FROM client;


# 10.Знайти кредити, які мають найбільшу суму для кожного клієнта окремо. / + посортовано за сумою
    # c. - з таблиці - client, a. - з таб. - application
SELECT c.idClient, c.FirstName, c.LastName, a.Sum
FROM application a
         JOIN client c ON c.idClient = a.Client_idClient
WHERE a.Sum = (
    SELECT MAX(Sum)
    FROM application
    WHERE Client_idClient = c.idClient
) order by Sum;

select max(Sum) as max_credit, client.*
from client
         join application a on client.idClient = a.Client_idClient
group by idClient;


# пояснення
            # SELECT c.idClient, c.FirstName, c.LastName, a.Sum: Ця частина вказує, які поля ми хочемо вивести у результаті запиту. Ми обираємо id клієнта, його ім'я, прізвище та суму кредиту (Sum).
            # FROM application a JOIN client c ON c.idClient = a.Client_idClient: Ця частина вказує, з яких таблиць ми беремо дані. Ми використовуємо таблиці application (позначена як a) і client (позначена як c). Ми об'єднуємо їх за допомогою умови ON, яка вказує, що idClient з таблиці client повинен співпадати з Client_idClient з таблиці application.
            # WHERE a.Sum = (SELECT MAX(Sum) FROM application WHERE Client_idClient = c.idClient): Ця частина фільтрує результати за умовою. Ми обираємо тільки ті рядки, де сума кредиту з таблиці application для конкретного клієнта (Client_idClient = c.idClient) дорівнює максимальній сумі кредиту для цього клієнта.

# 11. Визначити кількість заявок на кредит для кожного клієнта.
select count(*), idClient, FirstName, LastName
from client
         join application a on client.idClient = a.Client_idClient
group by idClient;

SELECT c.idClient, c.FirstName, c.LastName, COUNT(a.idApplication) AS TotalApplications
FROM client c
         LEFT JOIN application a ON c.idClient = a.Client_idClient
         GROUP BY c.idClient, c.FirstName, c.LastName order by TotalApplications;

# або запис без c.
SELECT idClient, FirstName, LastName, COUNT(idApplication) AS TotalApplications
FROM client
         LEFT JOIN application ON idClient = Client_idClient
         GROUP BY idClient, FirstName, LastName;
# пояснення. У цьому запиті ми об'єднуємо таблиці client і application за допомогою операції LEFT JOIN по полю Client_idClient. Потім ми використовуємо GROUP BY для групування результатів за полями idClient, FirstName та LastName з таблиці client. І, нарешті, ми використовуємо COUNT(a.idApplication) для підрахунку кількості заявок на кредит для кожного клієнта.
# або так:
        # Почнемо з таблиці client і виконаємо LEFT JOIN з таблицею application по полю idClient з client та Client_idClient з application. Це дозволить нам об'єднати дані з обох таблиць.
        # Після об'єднання ми будемо мати набір даних, що містить інформацію про кожного клієнта разом з відповідними заявками на кредит, які вони подали.
        # Далі використовуємо GROUP BY для групування цих даних за кожним унікальним клієнтом. Це означає, що всі заявки на кредит для кожного клієнта будуть об'єднані разом.
        # Нарешті, ми використовуємо COUNT(idApplication) для підрахунку кількості заявок на кредит для кожного клієнта.


# 12. Визначити найбільший та найменший кредити.
select min(Sum) as minSum, max(Sum) as maxSum from application;

# 13. Порахувати кількість кредитів для клієнтів,які мають вищу освіту.
select count(*), idClient, FirstName, LastName, Education
from client
         join application a on client.idClient = a.Client_idClient
where Education = 'high'
group by idClient;


SELECT c.idClient, c.FirstName, c.LastName, c.Education, COUNT(a.idApplication) AS TotalCredits
FROM client c
         JOIN application a ON c.idClient = a.Client_idClient
WHERE c.Education = 'high'
GROUP BY c.idClient, c.FirstName, c.LastName, c.Education;

# або скорочений варіант
SELECT idClient, FirstName, LastName, Education, COUNT(idApplication) AS TotalCredits
FROM client
         JOIN application ON idClient = Client_idClient
WHERE Education = 'high'
GROUP BY idClient; # групуємо по id, бо воно унікальне і буде 1 раз!


# 14. Вивести дані про клієнта, в якого середня сума кредитів найвища.
select avg(Sum) as avgMax, client.*
from client
         join application a on client.idClient = a.Client_idClient
group by idClient
order by avgMax desc
limit 1;


SELECT idClient, FirstName, LastName, AVG(Sum) AS avgSum
FROM client
         JOIN application ON idClient = Client_idClient
GROUP BY idClient, FirstName, LastName
ORDER BY avgSum DESC
LIMIT 1;



# 15. Вивести відділення, яке видало в кредити найбільше грошей
select sum(Sum) as sum, idDepartment, DepartmentCity
from department
         join client c on department.idDepartment = c.Department_idDepartment
         join application a on c.idClient = a.Client_idClient
group by idDepartment
order by sum desc
limit 1;


SELECT DepartmentCity, idDepartment, SUM(Sum) AS totalSum
FROM application
         JOIN client ON Client_idClient = idClient
         JOIN department ON idDepartment = Department_idDepartment
GROUP BY idDepartment
ORDER BY totalSum DESC
LIMIT 1;


# 16. Вивести відділення, яке видало найбільший кредит.
select DepartmentCity, idDepartment, max(Sum) from department
join client on idDepartment = Department_idDepartment
join application on idClient = Client_idClient
group by idDepartment limit 1;

select max(Sum) as max_sum, department.*
from department
         join client c on department.idDepartment = c.Department_idDepartment
         join application a on c.idClient = a.Client_idClient
group by idDepartment
order by max_sum desc
limit 1;


# 17. Усім клієнтам, які мають вищу освіту, встановити усі їхні кредити у розмірі 6000 грн.
update application join client c on c.idClient = Client_idClient
set Sum = 6000
where Education = 'high';


# 18. Усіх клієнтів київських відділень пересилити до Києва.






# 19. Видалити усі кредити, які є повернені.
#
# 20. Видалити кредити клієнтів, в яких друга літера прізвища є голосною.
#
# 21.Знайти львівські відділення, які видали кредитів на загальну суму більше ніж 5000
#
# 22.Знайти клієнтів, які повністю погасили кредити на суму більше ніж 5000
#
# 23.Знайти максимальний неповернений кредит.
#
# 24.Знайти клієнта, сума кредиту якого найменша
#
# 25.Знайти кредити, сума яких більша за середнє значення усіх кредитів
#
# 26. Знайти клієнтів, які є з того самого міста, що і клієнт, який взяв найбільшу кількість кредитів
#
# 27. Місто клієнта з найбільшою кількістю кредитів


