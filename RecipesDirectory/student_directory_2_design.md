{{STUDENT DIRECTORY 2}} Two Tables Design Recipe Template

## 1. Extract nouns from the user stories or specification

```
# EXAMPLE USER STORY:
As a coach
So I can get to know all students
I want to see a list of students' names.

As a coach
So I can get to know all students
I want to see a list of cohorts' names.

As a coach
So I can get to know all students
I want to see a list of cohorts' starting dates.

As a coach
So I can get to know all students
I want to see a list of students' cohorts.
```

```
Nouns:

Students, name, cohort
Cohort, starting_date, students
```

## 2. Infer the Table Name and Columns

Put the different nouns in this table. Replace the example with your own nouns.



| Record                | Properties          |
| --------------------- | ------------------  |
| Cohort                | id, name, starting_date
| Student               | id, name, cohort_id

1. Name of the first table (always plural): `cohorts` 

    Column names: `id`, `name`, `starting_date`

2. Name of the second table (always plural): `students` 

    Column names: `id`, `name`, `cohort_id`

## 3. Decide the column types.

[Here's a full documentation of PostgreSQL data types](https://www.postgresql.org/docs/current/datatype.html).

Most of the time, you'll need either `text`, `int`, `bigint`, `numeric`, or `boolean`. If you're in doubt, do some research or ask your peers.

Remember to **always** have the primary key `id` as a first column. Its type will always be `SERIAL`.

```
# EXAMPLE:

Table: cohorts
id: SERIAL
name: text
starting_date: date

Table: students
id: SERIAL
name: text
cohort_id: int
```

## 4. Decide on The Tables Relationship

```
1. Can one cohort have many students? YES
2. Can one student have many cohort? NO

-> Therefore,
-> A cohort HAS MANY students
-> A student BELONGS TO a cohort

-> Therefore, the foreign key is on the students table.
Foreign key(students) = cohort_id
```

## 4. Write the SQL.

```sql

CREATE TABLE cohorts (
  id SERIAL PRIMARY KEY,
  name text,
  starting_date date
);

-- Then the table with the foreign key first.
CREATE TABLE students (
  id SERIAL PRIMARY KEY,
  name text,
  cohort_id int,
  constraint fk_cohort foreign key(cohort_id) references cohorts(id)
);

```

## 5. Create the tables.

```bash
psql -h 127.0.0.1 database_name < albums_table.sql
```
