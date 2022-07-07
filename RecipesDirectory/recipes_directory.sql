DROP TABLE IF EXISTS "public"."recipes";
CREATE SEQUENCE IF NOT EXISTS recipes_id_seq;

CREATE TABLE "public"."recipes" (
  "id" SERIAL PRIMARY KEY,
  "title" text,
  "cooking_time" int,
  "rating" int
);

INSERT INTO "public"."recipes" ("title", "cooking_time", "rating") VALUES
('Spaghetti', 10, 5),
('Sushi', 30, 5),
('French fries', 15, 3),
('Moqueca', 35, 4),
('Nachos', 25, 4);