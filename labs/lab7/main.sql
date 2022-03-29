USE university;
SET NAMES UTF8;

# === 1. Добавить внешние ключи ===

ALTER TABLE student ADD FOREIGN KEY (id_group) REFERENCES `group`(id_group);

ALTER TABLE lesson ADD FOREIGN KEY (id_teacher) REFERENCES teacher(id_teacher);

ALTER TABLE lesson ADD FOREIGN KEY (id_subject) REFERENCES subject(id_subject);

ALTER TABLE lesson ADD FOREIGN KEY (id_group) REFERENCES `group`(id_group);

ALTER TABLE mark ADD FOREIGN KEY (id_lesson) REFERENCES lesson(id_lesson);

ALTER TABLE mark ADD FOREIGN KEY (id_student) REFERENCES student(id_student);