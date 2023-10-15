-- Drop tables if they exist

DROP TABLE IF EXISTS Transaction CASCADE;
DROP TABLE IF EXISTS "Credit Card" CASCADE;
DROP TABLE IF EXISTS "Card holder" CASCADE;
DROP TABLE IF EXISTS Merchant CASCADE;
DROP TABLE IF EXISTS "Merchant Category" CASCADE;

-- Create tables

CREATE TABLE "Merchant Category" (
    id serial PRIMARY KEY,
    name VARCHAR(20)
);

CREATE TABLE Merchant (
    id serial PRIMARY KEY,
    name VARCHAR(50),
    id_merchant_category int REFERENCES "Merchant Category"(id)
);

CREATE TABLE "Card holder" (
    id serial PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE "Credit Card" (
    card VARCHAR(20) PRIMARY KEY,
    cardholder_id int REFERENCES "Card holder"(id)
);

CREATE TABLE "Transaction" (
    id serial PRIMARY KEY,
    date Timestamp,
    amount float,
    card VARCHAR(20) REFERENCES "Credit Card"(card),
    id_merchant int REFERENCES Merchant(id)
);