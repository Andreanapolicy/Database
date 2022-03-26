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

SELECT pharmacy.name, `order`.date, `order`.quantity from medicine
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

# === 3. Выдать информацию по всем заказам лекарства “Кордерон” компании “Аргус” с указанием названий аптек, дат, объема заказов. ===
