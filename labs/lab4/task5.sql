DROP DATABASE IF EXISTS CarHotel;
CREATE DATABASE CarHotel;
# COLLATE Cyrillic_General_CI_AS;
USE CarHotel;

CREATE TABLE IF NOT EXISTS client (
    id_client INT PRIMARY KEY AUTO_INCREMENT,
    birthday DATETIME NOT NULL,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(100) NOT NULL,
    eye_color VARCHAR(50) NULL
);

CREATE TABLE IF NOT EXISTS cleaner (
    id_cleaner INT PRIMARY KEY AUTO_INCREMENT,
    birthday DATETIME NOT NULL,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(100) NOT NULL,
    eye_color VARCHAR(50) NULL
);

CREATE TABLE IF NOT EXISTS car (
    id_car INT PRIMARY KEY AUTO_INCREMENT,
    id_client INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    birthday DATE NOT NULL,
    price INT NOT NULL,
    FOREIGN KEY (id_client) REFERENCES client(id_client)
);

CREATE TABLE IF NOT EXISTS hotel_room (
    id_hotel_room INT PRIMARY KEY AUTO_INCREMENT,
    id_cleaner INT NOT NULL,
    create_date DATE NOT NULL,
    price INT NOT NULL,
    style_name VARCHAR(100) NOT NULL,
    number VARCHAR(50) NULL,
    FOREIGN KEY (id_cleaner) REFERENCES cleaner(id_cleaner)
);

CREATE TABLE IF NOT EXISTS booking_data (
    id_booking_data INT PRIMARY KEY AUTO_INCREMENT,
    id_client INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    pay REAL NOT NULL,
    FOREIGN KEY (id_client) REFERENCES client(id_client)
);

CREATE TABLE IF NOT EXISTS booking_store (
    id_hotel_room INT NOT NULL,
    id_booking_data INT NOT NULL,
    FOREIGN KEY (id_hotel_room) REFERENCES hotel_room(id_hotel_room),
    FOREIGN KEY (id_booking_data) REFERENCES booking_data(id_booking_data)
);

# ===== 1. Inserting =====

# cleaner

INSERT INTO cleaner
VALUE ('1', '2020-12-12', 'Василий', 'Успенская, д. 12', 'зеленый');

INSERT INTO cleaner
VALUE ('2', '1940-02-02', 'Илья', 'Крайовская, д. 12', 'карий');

INSERT INTO cleaner
VALUE ('3', '2001-08-04', 'Иван', 'Уличная, д. 12', 'синий');

INSERT INTO cleaner
VALUE ('4', '1998-11-06', 'Петр', 'Владимирская, д. 12', 'голубосерый');

# client

INSERT INTO client(birthday, name, address, eye_color)
VALUE ('2020-12-12', 'Александр', 'Успенская, д. 12', 'зеленый');

INSERT INTO client(birthday, name, address, eye_color)
VALUE ('1940-02-02', 'Владимир', 'Крайовская, д. 12', 'карий');

INSERT INTO client(birthday, name, address, eye_color)
VALUE ('2001-08-04', 'Петр', 'Уличная, д. 12', 'синий');

INSERT INTO client(birthday, name, address, eye_color)
VALUE ('2001-08-04', 'Вадим', 'Уличная, д. 23', 'синий');

INSERT INTO client(birthday, name, address, eye_color)
VALUE ('2001-08-04', 'Кирилл', 'Уличная, д. 23', 'синий');

INSERT INTO client(birthday, name, address, eye_color)
VALUE ('1998-11-06', 'Николай', 'Владимирская, д. 12', 'голубосерый');

# hotel_room

INSERT INTO hotel_room(id_cleaner, create_date, price, style_name, number)
VALUE ('1', '2002-12-12', '1235', 'Виницианский стиль', '203');

INSERT INTO hotel_room(id_cleaner, create_date, price, style_name, number)
VALUE ('3', '2012-12-12', '4300', 'Андреанский стиль', '506');

INSERT INTO hotel_room(id_cleaner, create_date, price, style_name, number)
VALUE ('1', '2022-12-12', '9949', 'Белый чай и как правильно его готовить', '777');

INSERT INTO hotel_room(id_cleaner, create_date, price, style_name, number)
VALUE ('2', '1989-12-12', '3', 'Как не готовить зеленый чай', '103');

# car

INSERT INTO car(id_client, birthday, name, price)
VALUE ('1', '1940-02-02', 'Урчатель', '20000');

INSERT INTO car(id_client, birthday, name, price)
VALUE ('2', '2004-02-02', 'Какушек', '30123');

INSERT INTO car(id_client, birthday, name, price)
VALUE ('3', '1980-02-02', 'Стонатель', '4123123');

INSERT INTO car(id_client, birthday, name, price)
VALUE ('4', '1937-02-02', 'Мамин соблазнитель', '11241');

INSERT INTO car(id_client, birthday, name, price)
VALUE ('1', '2001-02-02', 'Гиспофилиций', '31231');

# booking_data

INSERT INTO booking_data(id_client, start_date, end_date, pay)
VALUE ('1', '2002-02-02', '2002-02-03', '300');

INSERT INTO booking_data(id_client, start_date, end_date, pay)
VALUE ('2', '2002-02-02', '2002-02-03', '300');

INSERT INTO booking_data(id_client, start_date, end_date, pay)
VALUE ('1', '2002-02-04', '2002-02-05', '300');

INSERT INTO booking_data(id_client, start_date, end_date, pay)
VALUE ('3', '2012-02-02', '2013-02-03', '300');

INSERT INTO booking_data(id_client, start_date, end_date, pay)
VALUE ('4', '2014-02-02', '2014-02-03', '300');

# booking_store

INSERT INTO booking_store(id_hotel_room, id_booking_data)
VALUE ('1', '1');

INSERT INTO booking_store(id_hotel_room, id_booking_data)
VALUE ('2', '1');

INSERT INTO booking_store(id_hotel_room, id_booking_data)
VALUE ('3', '2');

INSERT INTO booking_store(id_hotel_room, id_booking_data)
VALUE ('4', '3');

# ===== 2. Deleting =====
# == All records ==
DELETE FROM booking_store;

INSERT INTO booking_store(id_hotel_room, id_booking_data)
VALUE ('1', '1');

INSERT INTO booking_store(id_hotel_room, id_booking_data)
VALUE ('2', '1');

INSERT INTO booking_store(id_hotel_room, id_booking_data)
VALUE ('3', '2');

INSERT INTO booking_store(id_hotel_room, id_booking_data)
VALUE ('4', '3');

# == only for hotel room 1 and 2 ==

DELETE FROM booking_store WHERE id_hotel_room = 1;

DELETE FROM booking_store WHERE id_hotel_room = 2;

# ===== 3. Update =====
# == all records ==
UPDATE car SET name = 'Быстритель 20к';
# == one name with price 20k ==
UPDATE car SET name = 'Самый быстрый из быстрейших' WHERE price = '20000';
# == one name and date car with price 4123123 ==
UPDATE car SET name = 'Лакшери', birthday = '2022-03-02' WHERE price = '4123123';

# ===== 4. Select =====
# == only client names and eye color ==
SELECT name, eye_color FROM client;
# == all clients ==
SELECT * FROM client;
# == only clients with blue eyes ==
SELECT * FROM client WHERE eye_color = 'синий';

# ===== 5. Select order by =====
# == asc + limit ==
SELECT * FROM car ORDER BY price ASC LIMIT 2;
# == desc ==
SELECT * FROM car ORDER BY price DESC;
# == price and birthday + limit ==
SELECT * FROM car ORDER BY birthday, price DESC LIMIT 3;
# == price and birthday ==
SELECT * FROM car ORDER BY birthday, price DESC LIMIT 3;

# ===== 6. Dates =====
# == where ==
SELECT * FROM client WHERE birthday = '1940-02-02';
# == where in range ==
SELECT * FROM client WHERE birthday BETWEEN '1940-02-02' AND '1998-11-06';
# == get only year ==
SELECT name, YEAR(birthday) AS birthday FROM client;

# ===== 7. Aggregation =====
# == records count ==
SELECT COUNT(*) FROM client;
# == unique records count ==
SELECT COUNT(DISTINCT id_client) FROM client;
# == unique records ==
SELECT DISTINCT eye_color FROM client;
# == max record by price ==
SELECT MAX(price) FROM car;
# == min record by price ==
SELECT MIN(price) FROM car;
# == count + group by ==
SELECT COUNT(eye_color) FROM client GROUP BY eye_color;

# ===== 8. SELECT + GROUP BY + HAVING =====
# == Get max car price, that more then 30k ==
SELECT * FROM car GROUP BY id_car HAVING MAX(price) > 30000;
# == get hotel rooms with price more than 300 ==
SELECT * FROM hotel_room GROUP BY id_hotel_room HAVING MAX(price) > 300;
# == get hotel rooms with price more only 300 ==
SELECT * FROM booking_data GROUP BY id_booking_data HAVING MAX(pay) = 300;

# ===== 8. SELECT + GROUP BY + HAVING =====
# == Get max car price, that more then 30k ==
SELECT * FROM car GROUP BY id_car HAVING MAX(price) > 30000;
# == get hotel rooms with price more than 300 ==
SELECT * FROM hotel_room GROUP BY id_hotel_room HAVING MAX(price) > 300;
# == get hotel rooms with price more only 300 ==
SELECT * FROM booking_data GROUP BY id_booking_data HAVING MAX(pay) = 300;

# ===== 9. JOINS =====
# == LEFT JOIN ==
SELECT * FROM car LEFT JOIN client c on car.id_client = c.id_client WHERE price > 20000;
# == RIGHT JOIN ==
SELECT * FROM car RIGHT JOIN client c on car.id_client = c.id_client WHERE price > 20000;
# == LEFT JOIN 3 tables ==
SELECT price, c.name, start_date, end_date FROM car LEFT JOIN client c on car.id_client = c.id_client LEFT JOIN booking_data bd on c.id_client = bd.id_client WHERE price > 20000;
# == INNER JOIN ==
SELECT * FROM booking_data INNER JOIN booking_store bs on booking_data.id_booking_data = bs.id_booking_data;

