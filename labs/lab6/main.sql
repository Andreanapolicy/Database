USE pharmacy;
SET NAMES UTF8;

# === 1. Добавить внешние ключи ===

ALTER TABLE dealer ADD FOREIGN KEY (id_company) REFERENCES company(id_company);

ALTER TABLE production ADD FOREIGN KEY (id_company) REFERENCES company(id_company);

ALTER TABLE production ADD FOREIGN KEY (id_medicine) REFERENCES medicine(id_medicine);

ALTER TABLE `order` ADD FOREIGN KEY (id_dealer) REFERENCES dealer(id_dealer);

ALTER TABLE `order` ADD FOREIGN KEY (id_pharmacy) REFERENCES pharmacy(id_pharmacy);

ALTER TABLE `order` ADD FOREIGN KEY (id_production) REFERENCES production(id_production);
