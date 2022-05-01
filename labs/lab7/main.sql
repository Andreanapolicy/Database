USE university;
SET NAMES UTF8;

# === 1. Добавить внешние ключи ===

ALTER TABLE student ADD FOREIGN KEY (id_group) REFERENCES `group`(id_group);

ALTER TABLE lesson ADD FOREIGN KEY (id_teacher) REFERENCES teacher(id_teacher);

ALTER TABLE lesson ADD FOREIGN KEY (id_subject) REFERENCES subject(id_subject);

ALTER TABLE lesson ADD FOREIGN KEY (id_group) REFERENCES `group`(id_group);

ALTER TABLE mark ADD FOREIGN KEY (id_lesson) REFERENCES lesson(id_lesson);

ALTER TABLE mark ADD FOREIGN KEY (id_student) REFERENCES student(id_student);

# === 2. Выдать оценки студентов по информатике если они обучаются данному предмету.
# Оформить выдачу данных с использованием view ===

CREATE OR REPLACE VIEW informatics_marks AS
    SELECT student.name, mark.mark from mark
        LEFT JOIN lesson ON mark.id_lesson = lesson.id_lesson
        LEFT JOIN student ON mark.id_student = student.id_student
        LEFT JOIN subject ON lesson.id_subject = subject.id_subject
    WHERE
        subject.name = 'Информатика';

#== Это для просмотра в контейнере ==
# CREATE OR REPLACE VIEW informatics_marks AS
#     SELECT student.name, mark.mark from mark
#         LEFT JOIN lesson ON mark.id_lesson = lesson.id_lesson
#         LEFT JOIN student ON mark.id_student = student.id_student
#         LEFT JOIN subject ON lesson.id_subject = subject.id_subject
#     WHERE
#         subject.id_subject = 2;

SELECT * FROM informatics_marks;

# === 3. Дать информацию о должниках с указанием фамилии студента и названия предмета.
# Должниками считаются студенты, не имеющие оценки по предмету, который ведется в группе.
# Оформить в виде процедуры, на входе идентификатор группы ===
DELIMITER $

DROP PROCEDURE IF EXISTS debtor_info$
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

# === 4. Дать среднюю оценку студентов по каждому предмету для тех предметов,
# по которым занимается не менее 35 студентов ===

SELECT subject.name, AVG(mark.mark) from subject
    INNER JOIN lesson ON subject.id_subject = lesson.id_subject
    INNER JOIN `group` ON lesson.id_group = `group`.id_group
    INNER JOIN mark ON lesson.id_lesson = mark.id_lesson
    INNER JOIN student ON `group`.id_group = student.id_group
GROUP BY
    subject.name
HAVING
    COUNT(student.id_student) >= 35;

# === 5. Дать оценки студентов специальности ВМ по всем проводимым предметам с указанием группы, фамилии, предмета,
# даты. При отсутствии оценки заполнить значениями NULL поля оценки ===

SELECT lesson.date, mark.mark, student.name, subject.name FROM student
    LEFT JOIN `group` ON student.id_group = `group`.id_group
    LEFT JOIN lesson ON `group`.id_group = lesson.id_subject
    LEFT JOIN mark ON lesson.id_lesson = mark.id_lesson
    LEFT JOIN subject ON lesson.id_subject = subject.id_subject
WHERE
    `group`.name = 'ВМ';

#== Это для просмотра в контейнере ==
# SELECT lesson.date, mark.mark, student.name, subject.name FROM student
#     LEFT JOIN `group` ON student.id_group = `group`.id_group
#     LEFT JOIN lesson ON `group`.id_group = lesson.id_subject
#     LEFT JOIN mark ON lesson.id_lesson = mark.id_lesson
#     LEFT JOIN subject ON lesson.id_subject = subject.id_subject
# WHERE
#     `group`.id_group = 3;

# === 6. Всем студентам специальности ПС, получившим оценки меньшие 5 по предмету
# БД до 12.05, повысить эти оценки на 1 балл ===

UPDATE mark
    INNER JOIN student ON mark.id_student = student.id_student
    INNER JOIN `group` ON student.id_group = `group`.id_group
    INNER JOIN lesson ON `group`.id_group = lesson.id_group
    INNER JOIN subject ON lesson.id_subject = subject.id_subject
SET
    mark.mark = mark.mark + 1
WHERE
    mark.mark < 5 AND
    subject.name = 'БД' AND
    `group`.name = 'ПС' AND
    lesson.date < '2019-05-12';

#== Это для просмотра в контейнере ==
# UPDATE mark
#     INNER JOIN student ON mark.id_student = student.id_student
#     INNER JOIN `group` ON student.id_group = `group`.id_group
#     INNER JOIN lesson ON `group`.id_group = lesson.id_group
#     INNER JOIN subject ON lesson.id_subject = subject.id_subject
# SET
#     mark.mark = mark.mark + 1
# WHERE
#     mark.mark < 5 AND
#     subject.id_subject = 1 AND
#     `group`.id_group = 1 AND
#     lesson.date < '2019-05-12';

# === 7. Добавить необходимые индексы ===

# == group ==
CREATE INDEX group_name_idx
    ON `group`(name ASC);

# == lesson ==
CREATE INDEX lesson_date_idx
    ON lesson(date ASC);

# == mark ==
CREATE INDEX mark_mark_idx
    ON mark(mark ASC);

# == subject ==
CREATE INDEX subject_name_idx
    ON subject(name ASC);