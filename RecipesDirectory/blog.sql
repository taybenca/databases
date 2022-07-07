DROP TABLE IF EXISTS "public"."posts";
CREATE SEQUENCE IF NOT EXISTS posts_id_seq;

CREATE TABLE "public"."posts" (
  "id" SERIAL PRIMARY KEY,
  "title" text,
  "content" text
);


DROP TABLE IF EXISTS "public"."comments";
CREATE SEQUENCE IF NOT EXISTS comments_id_seq;

CREATE TABLE "public"."comments" (
  "id" SERIAL PRIMARY KEY,
  "content" text,
  "author_name" text,
  "post_id" int,
  constraint fk_post foreign key(post_id) references posts(id)
);


INSERT INTO "public"."posts" ("title", "content") VALUES
('About life', 'The life is good'),
('Summer', 'People are not happier during the summer'),
('Coding', 'People who codes are happy');

INSERT INTO "public"."comments" ("content", "author_name", "post_id") VALUES
('Very nice post', 'Anna', 2),
('I disagree', 'John', 2),
('Nice', 'Henri', 1),
('Cool', 'Charles', 3),
('I am not sure about it', 'Chris', 2),
('I loved that', 'Maria', 3);