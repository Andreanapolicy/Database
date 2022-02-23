CREATE DATABASE BookShop
COLLATE Cyrillic_General_CI_AS;

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

CREATE TABLE IF NOT EXISTS lending_data (
    id_book INT NOT NULL,
    id_lending_data INT NOT NULL,
    FOREIGN KEY (id_book) REFERENCES book(id_book),
    FOREIGN KEY (id_lending_data) REFERENCES lending_data(id_lending_data)
);