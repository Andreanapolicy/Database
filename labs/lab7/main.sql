USE university;
SET NAMES UTF8;

# === 1. Добавить внешние ключи ===

ALTER TABLE student ADD FOREIGN KEY (id_group) REFERENCES `group`(id_group);

ALTER TABLE lesson ADD FOREIGN KEY (id_teacher) REFERENCES teacher(id_teacher);

ALTER TABLE lesson ADD FOREIGN KEY (id_subject) REFERENCES subject(id_subject);

ALTER TABLE lesson ADD FOREIGN KEY (id_group) REFERENCES `group`(id_group);

ALTER TABLE mark ADD FOREIGN KEY (id_lesson) REFERENCES lesson(id_lesson);

ALTER TABLE mark ADD FOREIGN KEY (id_student) REFERENCES student(id_student);

# === 2. Выдать оценки студентов по информатике если они обучаются данному предмету. Оформить выдачу данных с использованием view ===

CREATE OR REPLACE VIEW informatics_marks AS
    SELECT student.name, mark.mark from mark
        LEFT JOIN lesson ON mark.id_lesson = lesson.id_lesson
        LEFT JOIN student ON mark.id_student = student.id_student
        LEFT JOIN subject ON lesson.id_subject = subject.id_subject
    WHERE
        subject.name = 'Информатика';

#== Это для просмотра в контейнере ==
# CREATE VIEW informatics_marks AS
#     SELECT student.name, mark.mark from mark
#         LEFT JOIN lesson ON mark.id_lesson = lesson.id_lesson
#         LEFT JOIN student ON mark.id_student = student.id_student
#         LEFT JOIN subject ON lesson.id_subject = subject.id_subject
#     WHERE
#         subject.id_subject = 2;

SELECT * FROM informatics_marks;