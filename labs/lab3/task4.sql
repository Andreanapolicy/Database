DROP DATABASE BookShop;
CREATE DATABASE BookShop;
# COLLATE Cyrillic_General_CI_AS;
USE BookShop;
CREATE TABLE IF NOT EXISTS author (
    id_author INT PRIMARY KEY AUTO_INCREMENT,
    birthday DATE NOT NULL,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(100) NOT NULL,
    eye_color VARCHAR(50) NULL
);

CREATE TABLE IF NOT EXISTS reader (
    id_reader INT PRIMARY KEY AUTO_INCREMENT,
    birthday DATE NOT NULL,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(100) NOT NULL,
    eye_color VARCHAR(50) NULL
);

CREATE TABLE IF NOT EXISTS duck (
    id_duck INT PRIMARY KEY AUTO_INCREMENT,
    id_reader INT NOT NULL,
    birthday DATE NOT NULL,
    name VARCHAR(50) NOT NULL,
    rating INT NOT NULL,
    FOREIGN KEY (id_reader) REFERENCES reader(id_reader)
);

CREATE TABLE IF NOT EXISTS book (
    id_book INT PRIMARY KEY AUTO_INCREMENT,
    id_author INT NOT NULL,
    creation_date DATE NOT NULL,
    price REAL NOT NULL,
    name VARCHAR(100) NULL,
    FOREIGN KEY (id_author) REFERENCES author(id_author)
);

CREATE TABLE IF NOT EXISTS lending_data (
    id_lending_data INT PRIMARY KEY AUTO_INCREMENT,
    id_reader INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    pay REAL NOT NULL,
    FOREIGN KEY (id_reader) REFERENCES reader(id_reader)
);

CREATE TABLE IF NOT EXISTS lending_store (
    id_book INT NOT NULL,
    id_lending_data INT NOT NULL,
    FOREIGN KEY (id_book) REFERENCES book(id_book),
    FOREIGN KEY (id_lending_data) REFERENCES lending_data(id_lending_data)
);

# Authors

INSERT INTO author(birthday, name, address, eye_color)
VALUE ('2020-12-12', 'Александр', 'Успенская, д. 12', 'зеленый');

INSERT INTO author(birthday, name, address, eye_color)
VALUE ('1940-02-02', 'Владимир', 'Крайовская, д. 12', 'карий');

INSERT INTO author(birthday, name, address, eye_color)
VALUE ('2001-08-04', 'Петр', 'Уличная, д. 12', 'синий');

INSERT INTO author(birthday, name, address, eye_color)
VALUE ('1998-11-06', 'Николай', 'Владимирская, д. 12', 'голубосерый');

# Books

INSERT INTO book(id_author, creation_date, price, name)
VALUE ('1', '2002-12-12', '1235', 'Зеленый чай и как правильно его готовить');

INSERT INTO book(id_author, creation_date, price, name)
VALUE ('1', '2012-12-12', '4300', 'Черный чай и как правильно его готовить');

INSERT INTO book(id_author, creation_date, price, name)
VALUE ('1', '2022-12-12', '9949', 'Белый чай и как правильно его готовить');

INSERT INTO book(id_author, creation_date, price, name)
VALUE ('2', '1989-12-12', '3', 'Как не готовить зеленый чай');

# Readers

INSERT INTO reader(birthday, name, address, eye_color)
VALUE ('2020-12-12', 'Василий', 'Успенская, д. 12', 'зеленый');

INSERT INTO reader(birthday, name, address, eye_color)
VALUE ('1940-02-02', 'Илья', 'Крайовская, д. 12', 'карий');

INSERT INTO reader(birthday, name, address, eye_color)
VALUE ('2001-08-04', 'Иван', 'Уличная, д. 12', 'синий');

INSERT INTO reader(birthday, name, address, eye_color)
VALUE ('1998-11-06', 'Петр', 'Владимирская, д. 12', 'голубосерый');

# Ducks

INSERT INTO duck(id_reader, birthday, name, rating)
VALUE ('1', '1940-02-02', 'Урчатель', '2');

INSERT INTO duck(id_reader, birthday, name, rating)
VALUE ('2', '2004-02-02', 'Какушек', '3');

INSERT INTO duck(id_reader, birthday, name, rating)
VALUE ('3', '1980-02-02', 'Стонатель', '4');

INSERT INTO duck(id_reader, birthday, name, rating)
VALUE ('4', '1937-02-02', 'Мамин соблазнитель', '1');

INSERT INTO duck(id_reader, birthday, name, rating)
VALUE ('1', '2001-02-02', 'Гиспофилиций', '3');

# Lending data

INSERT INTO lending_data(id_reader, start_date, end_date, pay)
VALUE ('1', '2002-02-02', '2002-02-03', '300');

INSERT INTO lending_data(id_reader, start_date, end_date, pay)
VALUE ('2', '2002-02-02', '2002-02-03', '300');

INSERT INTO lending_data(id_reader, start_date, end_date, pay)
VALUE ('1', '2002-02-04', '2002-02-05', '300');

INSERT INTO lending_data(id_reader, start_date, end_date, pay)
VALUE ('3', '2012-02-02', '2013-02-03', '300');

INSERT INTO lending_data(id_reader, start_date, end_date, pay)
VALUE ('4', '2014-02-02', '2014-02-03', '300');

# Lending store

INSERT INTO lending_store(id_book, id_lending_data)
VALUE ('1', '1');

INSERT INTO lending_store(id_book, id_lending_data)
VALUE ('2', '1');

INSERT INTO lending_store(id_book, id_lending_data)
VALUE ('3', '2');

INSERT INTO lending_store(id_book, id_lending_data)
VALUE ('4', '3');
