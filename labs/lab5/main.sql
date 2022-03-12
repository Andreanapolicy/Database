USE Hotel;
# === 1. Добавить внешние ключи ===

ALTER TABLE booking ADD FOREIGN KEY (id_client) REFERENCES client(id_client);

ALTER TABLE room ADD FOREIGN KEY (id_hotel) REFERENCES hotel(id_hotel);

ALTER TABLE room ADD FOREIGN KEY (id_room_category) REFERENCES room_category(id_room_category);

ALTER TABLE room_in_booking ADD FOREIGN KEY (id_booking) REFERENCES booking(id_booking);

ALTER TABLE room_in_booking ADD FOREIGN KEY (id_room) REFERENCES room(id_room);

# === 2. Выдать информацию о клиентах гостиницы “Космос”, проживающих в номерах категории “Люкс” на 1 апреля 2019г ===


