--- Data Analysis Part-1 Q-1

CREATE VIEW "Small Transactions" AS
SELECT
    ch.name AS "Cardholder Name",
    c.cardholder_id AS "Cardholder ID",
    COUNT(t.id) AS "Transaction Count",
    SUM(t.amount) AS "Total Amount Spent",
    MIN(t.date) AS "First Transaction Date",
    MAX(t.date) AS "Last Transaction Date"
FROM
    "Transaction" AS t
INNER JOIN
    "Credit Card" AS c ON c.card = t.card
INNER JOIN
    "Card holder" AS ch ON ch.id = c.cardholder_id
WHERE
    t.amount < 2
GROUP BY
    "Cardholder Name", "Cardholder ID"
ORDER BY
    "Cardholder Name";
	
--- Data Analysis Part-1 Q-2

--- Transactions Between 7am and 9am

CREATE VIEW "Large Transactions 7-9" AS
SELECT
    t.id AS "Transaction ID",
    t.amount AS "Transaction Amount",
    t.date AS "Transaction Date",
    ch.name AS "Cardholder Name",
	mc.name AS "Merchant Category"
FROM
    "Transaction" AS t
INNER JOIN
    "Credit Card" AS c ON c.card = t.card
INNER JOIN
    "Card holder" AS ch ON ch.id = c.cardholder_id
INNER JOIN
    merchant AS m ON t.id_merchant = m.id
INNER JOIN
    "Merchant Category" AS mc on mc.id = m.id_merchant_category
WHERE
    EXTRACT(HOUR FROM t.date) >= 7
    AND EXTRACT(HOUR FROM t.date) < 9
ORDER BY
    t.amount DESC
LIMIT 100;


--- Transactions in the rest of the Day (excluding the time between 7am and 9am)
CREATE VIEW "Large Transactions excluding 7-9" AS
SELECT
    t.id AS "Transaction ID",
    t.amount AS "Transaction Amount",
    t.date AS "Transaction Date",
    ch.name AS "Cardholder Name",
    mc.name AS "Merchant Category"
FROM
    "Transaction" AS t
INNER JOIN
    "Credit Card" AS c ON c.card = t.card
INNER JOIN
    "Card holder" AS ch ON ch.id = c.cardholder_id
INNER JOIN
    merchant AS m ON t.id_merchant = m.id
INNER JOIN
    "Merchant Category" AS mc on mc.id = m.id_merchant_category
WHERE
    EXTRACT(HOUR FROM t.date) <= 7
    OR EXTRACT(HOUR FROM t.date) > 9
ORDER BY
    t.amount DESC
LIMIT 100;


--- Data Anlysis Part-1 Q-3

CREATE VIEW "Merchants Small Transactions" AS 
SELECT
    m.name AS "Merchant Name",
    mc.name AS "Merchant Category",
    COUNT(t.id) AS "Transaction Count",
    SUM(t.amount) AS "Total Transaction Amount"
FROM
    "Transaction" AS t
INNER JOIN
    "Credit Card" AS c ON c.card = t.card
INNER JOIN
    "Card holder" AS ch ON ch.id = c.cardholder_id
INNER JOIN
    "merchant" AS m ON t.id_merchant = m.id
INNER JOIN
    "Merchant Category" AS mc ON mc.id = m.id_merchant_category
WHERE
    t.amount < 2  
GROUP BY
    "Merchant Name", "Merchant Category"
ORDER BY
    "Transaction Count" DESC
LIMIT 5;


--- Data Analysis Part-2 Q-1
CREATE VIEW "Cardholder 2 & 18" AS
SELECT c.cardholder_id AS "Cardholder ID", SUM(t.amount) AS "Amount", t.date AS "Transaction Date"
FROM "Transaction" AS t
INNER JOIN "Credit Card" AS c ON c.card = t.card
WHERE c.cardholder_id = 2 OR c.cardholder_id = 18
GROUP BY "Cardholder ID", "Transaction Date"
ORDER BY c.cardholder_id


--- Data Analysis Part-2 Q-2
CREATE VIEW "Cardholder 25 Jan-Jun 2018" AS
SELECT c.cardholder_id AS "Cardholder ID", SUM(t.amount) AS "Amount", t.date AS "Transaction Date"
FROM "Transaction" AS t
INNER JOIN "Credit Card" AS c ON c.card = t.card
WHERE c.cardholder_id = 25
  AND t.date >= '2018-01-01' 
  AND t.date <= '2018-06-30'
GROUP BY "Cardholder ID", "Transaction Date"
ORDER BY "Transaction Date"



