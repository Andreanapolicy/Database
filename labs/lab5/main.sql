USE Hotel;
SET NAMES UTF8;
# === 1. Добавить внешние ключи ===

ALTER TABLE booking ADD FOREIGN KEY (id_client) REFERENCES client(id_client);

ALTER TABLE room ADD FOREIGN KEY (id_hotel) REFERENCES hotel(id_hotel);

ALTER TABLE room ADD FOREIGN KEY (id_room_category) REFERENCES room_category(id_room_category);

ALTER TABLE room_in_booking ADD FOREIGN KEY (id_booking) REFERENCES booking(id_booking);

ALTER TABLE room_in_booking ADD FOREIGN KEY (id_room) REFERENCES room(id_room);

# === 2. Выдать информацию о клиентах гостиницы “Космос”, проживающих в номерах категории “Люкс” на 1 апреля 2021г ===

select client.id_client, client.name from client
    LEFT JOIN booking ON client.id_client = booking.id_client
    LEFT JOIN room_in_booking ON room_in_booking.id_booking = booking.id_booking
    LEFT JOIN room ON room.id_room = room_in_booking.id_room
    LEFT JOIN room_category ON room_category.id_room_category = room.id_room_category
    LEFT JOIN hotel ON hotel.id_hotel = room.id_hotel
WHERE
    hotel.id_hotel = 1 AND
    room_category.id_room_category = 5 AND
    room_in_booking.checkin_date <= '2021-04-1' AND
    room_in_booking.checkout_date > '2021-04-1';

# === 3. Дать список свободных номеров всех гостиниц на 22 апреля ===

select room.id_room, id_hotel, number from room
    LEFT JOIN room_in_booking ON room.id_room = room_in_booking.id_room
WHERE
    room_in_booking.checkin_date < '2021-04-22' AND
    room_in_booking.checkout_date < '2021-04-22' OR
    room_in_booking.checkout_date IS NULL
ORDER BY 1;

# === 4. Дать количество проживающих в гостинице "Космос" на 23 марта по каждой категории номеров ===

select COUNT(*), room_category.name from room_category
    LEFT JOIN room ON room_category.id_room_category = room.id_room_category
    LEFT JOIN hotel ON room.id_hotel = hotel.id_hotel
    LEFT JOIN room_in_booking ON room.id_room = room_in_booking.id_room
WHERE
    hotel.id_hotel = 1 AND
    room_in_booking.checkin_date <= '2021-03-23' AND
    room_in_booking.checkin_date > '2021-03-23'
GROUP BY
    room_category.id_room_category, room_category.name;

# === 5. Дать список последних проживавших клиентов по всем комнатам гостиницы “Космос”, выехавших в апреле с указанием даты выезда ===

select client.name, room_in_booking.checkout_date from client
    LEFT JOIN booking ON client.id_client = booking.id_client
    LEFT JOIN room_in_booking ON booking.id_booking = room_in_booking.id_booking
    LEFT JOIN room ON room_in_booking.id_room = room.id_room
    LEFT JOIN hotel ON room.id_hotel = hotel.id_hotel
WHERE
    hotel.id_hotel = 1 AND
    MONTH(room_in_booking.checkout_date) = 4;

# === 6. Продлить на 2 дня дату проживания в гостинице “ Космос ” всем клиентам комнат категории “Бизнес”, которые заселились 10 мая. ===

UPDATE room_in_booking
    INNER JOIN room ON room_in_booking.id_room = room.id_room
    INNER JOIN hotel ON room.id_hotel = hotel.id_hotel
    INNER JOIN room_category ON room.id_room_category = room_category.id_room_category
SET checkout_date = DATE_ADD(checkout_date, INTERVAL 2 DAY )
WHERE
    hotel.id_hotel = 1 AND
    room_category.id_room_category = 3 AND
    room_in_booking.checkin_date = '2021-05-10';

# === 7. Найти все "пересекающиеся " варианты проживания. ===

select * from room_in_booking AS first_room_in_booking
    INNER JOIN room_in_booking AS second_room_in_booking ON first_room_in_booking.id_room = second_room_in_booking.id_room
WHERE
    first_room_in_booking.id_room_in_booking != second_room_in_booking.id_room_in_booking AND
    first_room_in_booking.checkin_date <= second_room_in_booking.checkin_date AND
    first_room_in_booking.checkout_date >= second_room_in_booking.checkout_date;

# === 8. Создать бронирование в транзакции ===

START TRANSACTION;
    INSERT INTO booking(id_client, booking_date) VALUES(1, NOW());
    INSERT INTO room_in_booking(id_booking, id_room, checkin_date, checkout_date)
        VALUES((SELECT id_booking from booking ORDER BY id_booking DESC LIMIT 1), 1, '2022-03-17', '2022-03-18');
COMMIT;

# === 9. Добавить необходимые индексы для всех таблиц ===
# == client ==
CREATE INDEX client_name_idx
ON client(name ASC);

CREATE INDEX client_id_client_idx
ON client(id_client ASC);

# == hotel ==
CREATE INDEX hotel_name_id_hotel_idx
ON hotel(name ASC, id_hotel ASC);

# == room ==
CREATE INDEX room_id_room_idx
ON room(id_room ASC);

CREATE INDEX room_id_room_id_hotel_idx
ON room(id_room ASC, id_hotel ASC);

CREATE INDEX room_id_room_id_hotel_id_room_category_idx
ON room(id_room ASC, id_hotel ASC, id_room_category ASC);

# == room_category ==
CREATE INDEX room_category_id_room_category_name_idx
ON room_category(id_room_category ASC, name ASC);

# == booking ==
CREATE INDEX booking_id_client_id_booking_idx
ON booking(id_booking ASC, id_client ASC);

# == room_in_booking ==

CREATE INDEX room_in_booking_id_room_id_booking_checkin_checkout_date_idx
ON room_in_booking(id_room ASC, id_booking ASC, checkin_date ASC, checkout_date ASC);

CREATE INDEX room_in_booking_id_room_checkin_date_checkout_date_idx
ON room_in_booking(id_room ASC, checkin_date ASC, checkout_date ASC);

CREATE INDEX room_in_booking_id_room_id_booking_checkout_date_idx
ON room_in_booking(id_room ASC, id_booking ASC, checkout_date ASC);

CREATE INDEX room_in_booking_id_room_checkin_date_idx
ON room_in_booking(id_room ASC, checkin_date ASC);