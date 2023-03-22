CREATE TABLE "user" (
  "id" SERIAL PRIMARY KEY,
  "name" varchar,
  "email" varchar
);

CREATE TABLE "address" (
  "id" SERIAL PRIMARY KEY,
  "user_id" int,
  "street" varchar,
  "number" int,
  "city" varchar,
  "state" varchar,
  "country" varchar
);

ALTER TABLE "address" ADD FOREIGN KEY ("user_id") REFERENCES "user" ("id");