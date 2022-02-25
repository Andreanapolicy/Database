DROP DATABASE IF EXISTS CarHotel;
CREATE DATABASE CarHotel;
# COLLATE Cyrillic_General_CI_AS;
USE CarHotel;

CREATE TABLE IF NOT EXISTS client (
    id_client INT PRIMARY KEY AUTO_INCREMENT,
    birthday DATE NOT NULL,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(100) NOT NULL,
    eye_color VARCHAR(50) NULL
);

CREATE TABLE IF NOT EXISTS cleaner (
    id_cleaner INT PRIMARY KEY AUTO_INCREMENT,
    birthday DATE NOT NULL,
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

# cleaner

INSERT INTO cleaner(birthday, name, address, eye_color)
VALUE ('2020-12-12', 'Василий', 'Успенская, д. 12', 'зеленый');

INSERT INTO cleaner(birthday, name, address, eye_color)
VALUE ('1940-02-02', 'Илья', 'Крайовская, д. 12', 'карий');

INSERT INTO cleaner(birthday, name, address, eye_color)
VALUE ('2001-08-04', 'Иван', 'Уличная, д. 12', 'синий');

INSERT INTO cleaner(birthday, name, address, eye_color)
VALUE ('1998-11-06', 'Петр', 'Владимирская, д. 12', 'голубосерый');

# client

INSERT INTO client(birthday, name, address, eye_color)
VALUE ('2020-12-12', 'Александр', 'Успенская, д. 12', 'зеленый');

INSERT INTO client(birthday, name, address, eye_color)
VALUE ('1940-02-02', 'Владимир', 'Крайовская, д. 12', 'карий');

INSERT INTO client(birthday, name, address, eye_color)
VALUE ('2001-08-04', 'Петр', 'Уличная, д. 12', 'синий');

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
VALUE ('1', '1940-02-02', 'Урчатель', '2');

INSERT INTO car(id_client, birthday, name, price)
VALUE ('2', '2004-02-02', 'Какушек', '3');

INSERT INTO car(id_client, birthday, name, price)
VALUE ('3', '1980-02-02', 'Стонатель', '4');

INSERT INTO car(id_client, birthday, name, price)
VALUE ('4', '1937-02-02', 'Мамин соблазнитель', '1');

INSERT INTO car(id_client, birthday, name, price)
VALUE ('1', '2001-02-02', 'Гиспофилиций', '3');

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
