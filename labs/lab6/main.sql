USE pharmacy;
SET NAMES UTF8;

# === 1. Добавить внешние ключи ===

ALTER TABLE dealer ADD FOREIGN KEY (id_company) REFERENCES company(id_company);

ALTER TABLE production ADD FOREIGN KEY (id_company) REFERENCES company(id_company);

ALTER TABLE production ADD FOREIGN KEY (id_medicine) REFERENCES medicine(id_medicine);

ALTER TABLE `order` ADD FOREIGN KEY (id_dealer) REFERENCES dealer(id_dealer);

ALTER TABLE `order` ADD FOREIGN KEY (id_pharmacy) REFERENCES pharmacy(id_pharmacy);

ALTER TABLE `order` ADD FOREIGN KEY (id_production) REFERENCES production(id_production);

# === 2. Выдать информацию по всем заказам лекарства “Кордерон” компании “Аргус” с указанием названий аптек, дат, объема заказов. ===

SELECT pharmacy.name, `order`.date, `order`.quantity FROM medicine
    INNER JOIN production ON medicine.id_medicine = production.id_medicine
    INNER JOIN `order` ON production.id_production = `order`.id_production
    INNER JOIN company ON production.id_company = company.id_company
    INNER JOIN pharmacy ON `order`.id_pharmacy = pharmacy.id_pharmacy
WHERE
    medicine.name = 'Кордерон' AND
    company.name = 'Аргус';

#== Это для просмотра в контейнере ==
# SELECT pharmacy.name, `order`.date, `order`.quantity from medicine
#     INNER JOIN production ON medicine.id_medicine = production.id_medicine
#     INNER JOIN `order` ON production.id_production = `order`.id_production
#     INNER JOIN company ON production.id_company = company.id_company
#     INNER JOIN pharmacy ON `order`.id_pharmacy = pharmacy.id_pharmacy
# WHERE
#     medicine.id_medicine = 10 AND
#     company.id_company = 7;

# === 3. Дать список лекарств компании “Фарма”, на которые не были сделаны заказы до 25 января. ===

SELECT * FROM medicine
    LEFT JOIN production ON medicine.id_medicine = production.id_medicine
    LEFT JOIN `order` ON production.id_production = `order`.id_production
    LEFT JOIN company ON production.id_company = company.id_company
WHERE
    company.name = 'Фарма' AND
    `order`.date < '2020-01-25'
GROUP BY
    medicine.id_medicine;

#== Это для просмотра в контейнере ==
# SELECT medicine.name FROM medicine
#     LEFT JOIN production ON medicine.id_medicine = production.id_medicine
#     LEFT JOIN `order` ON production.id_production = `order`.id_production
#     LEFT JOIN company ON production.id_company = company.id_company
# WHERE
#     company.id_company = 8 AND
#     `order`.date < '2020-01-25'
# GROUP BY
#     medicine.id_medicine;

# === 4. Дать минимальный и максимальный баллы лекарств каждой фирмы, которая оформила не менее 120 заказов ===

SELECT company.name, MIN(rating), MAX(rating) FROM production
    INNER JOIN company ON production.id_company = company.id_company
    INNER JOIN `order` ON production.id_production = `order`.id_production
GROUP BY
    company.name
HAVING
    COUNT(`order`.id_order) >= 120;

# === 5. Дать списки сделавших заказы аптек по всем дилерам компании “AstraZeneca”. Если у дилера нет заказов, в названии аптеки проставить NULL ===

SELECT pharmacy.name, dealer.name, `order`.quantity FROM dealer
    LEFT JOIN company ON dealer.id_company = company.id_company
    LEFT JOIN `order` ON dealer.id_dealer = `order`.id_dealer
    LEFT JOIN pharmacy ON `order`.id_pharmacy = pharmacy.id_pharmacy
WHERE
    company.name = 'AstraZeneca';

# === 6. Уменьшить на 20% стоимость всех лекарств, если она превышает 3000, а длительность лечения не более 7 дней ===

UPDATE production
    LEFT JOIN medicine ON production.id_medicine = medicine.id_medicine
SET
    production.price = production.price * 0.8
WHERE
    production.price > 3000 AND
    medicine.cure_duration <= 7;