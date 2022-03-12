USE Hotel;
SET NAMES UTF8;
# === 1. Добавить внешние ключи ===

ALTER TABLE booking ADD FOREIGN KEY (id_client) REFERENCES client(id_client);

ALTER TABLE room ADD FOREIGN KEY (id_hotel) REFERENCES hotel(id_hotel);

ALTER TABLE room ADD FOREIGN KEY (id_room_category) REFERENCES room_category(id_room_category);

ALTER TABLE room_in_booking ADD FOREIGN KEY (id_booking) REFERENCES booking(id_booking);

ALTER TABLE room_in_booking ADD FOREIGN KEY (id_room) REFERENCES room(id_room);

# === 2. Выдать информацию о клиентах гостиницы “Космос”, проживающих в номерах категории “Люкс” на 1 апреля 2019г ===

select client.id_client, client.name from client
    LEFT JOIN booking ON client.id_client = booking.id_client
    LEFT JOIN room_in_booking ON room_in_booking.id_booking = booking.id_booking
    LEFT JOIN room ON room.id_room = room_in_booking.id_room
    LEFT JOIN room_category ON room_category.id_room_category = room.id_room_category
    LEFT JOIN hotel ON hotel.id_hotel = room.id_hotel
WHERE
    hotel.name = 'Космос' AND
    room_category.name = 'Люкс' AND
    room_in_booking.checkin_date < '2019-04-1' AND
    room_in_booking.checkout_date >= '2019-04-1';

# === 3. Дать список свободных номеров всех гостиниц на 22 апреля ===

select id_hotel, number from room
    LEFT JOIN room_in_booking ON room.id_room = room_in_booking.id_room
WHERE
    room_in_booking.checkin_date < '2019-04-22' AND
    room_in_booking.checkout_date < '2019-04-22';

# === 4. Дать список последних проживавши х клиентов по всем комнатам гостиницы “Космос”, выехавшим в апреле с указанием даты выезда ===

