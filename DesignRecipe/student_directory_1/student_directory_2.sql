DROP TABLE IF EXISTS "public"."cohorts";
 
CREATE SEQUENCE IF NOT EXISTS cohorts_id_seq;

CREATE TABLE "public"."cohorts" (
  "id" SERIAL PRIMARY KEY,
  "name" text,
  "starting_date" date
);

DROP TABLE IF EXISTS "public"."students";

CREATE SEQUENCE IF NOT EXISTS students_id_seq;

CREATE TABLE "public"."students" (
  "id" SERIAL PRIMARY KEY,
  "name" text,
  "cohort_id" int,
  constraint fk_cohort foreign key(cohort_id) references cohorts(id)
);

INSERT INTO "public"."cohorts" ("name", "starting_date") VALUES
('June 2022', '2022-06-21'),
('July 2022', '2022-07-21'),
('August 2022', '2022-08-21'),
('September 2022', '2022-09-21'),
('October 2022', '2022-10-21'),
('November 2022', '2022-11-21');

INSERT INTO "public"."students" ("name", "cohort_id") VALUES
('Tay', 1),
('Ev', 2),
('Peter', 3),
('John', 4),
('Valery', 1),
('Amphibia', 2),
('Treehorse', 2);