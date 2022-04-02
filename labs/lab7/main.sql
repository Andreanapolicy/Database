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

# === 3. Дать информацию о должниках с указанием фамилии студента и названия предмета. Должниками считаются студенты,
# не имеющие оценки по предмету, который ведется в группе. Оформить в виде процедуры, на входе идентификатор группы ===
DELIMITER $

DROP PROCEDURE IF EXISTS debtor_info;
CREATE PROCEDURE debtor_info(IN group_id INT)
BEGIN
    SELECT student.name, subject.name FROM student
        LEFT JOIN `group` ON student.id_group = `group`.id_group
        LEFT JOIN lesson ON lesson.id_group = `group`.id_group
        LEFT JOIN mark ON mark.id_lesson = lesson.id_lesson AND mark.id_student = student.id_student
        LEFT JOIN subject ON student.name = subject.name
    WHERE
        student.id_group = group_id
    GROUP BY
        student.name, subject.name
    HAVING
            COUNT(mark.mark) = 0;
END$

DELIMITER ;

CALL debtor_info(1);

# === 4. Дать среднюю оценку студентов по каждому предмету для тех предметов, по которым занимается не менее 35 студентов ===

SELECT subject.name, AVG(mark.mark) from subject
    INNER JOIN lesson ON subject.id_subject = lesson.id_subject
    INNER JOIN `group` ON lesson.id_group = `group`.id_group
    INNER JOIN mark ON lesson.id_lesson = mark.id_lesson
    INNER JOIN student ON `group`.id_group = student.id_group
GROUP BY
    subject.name
HAVING
    COUNT(student.id_student) >= 35;