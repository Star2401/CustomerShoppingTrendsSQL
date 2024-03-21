-- Group Customers by Age Group to analyze age distribution
SELECT
	CASE
		WHEN age <= 24 THEN 'Youth or Gen Z'
		WHEN age BETWEEN 25 AND 39 THEN 'Millenials'
		WHEN age BETWEEN 40 AND 54 THEN 'Gen X'
		WHEN age BETWEEN 55 AND 74 THEN 'Baby Boomers'
		ELSE 'Seniors'
	END AS customeragegroup,
	COUNT (*) AS customercount
FROM customershoppingtrends
GROUP BY customeragegroup
ORDER BY COUNT (*) DESC
-- Baby Boomers have the largest portion of the company's customer base

-- Total & Average spend by gender
SELECT 
	GENDER, 
	SUM(PURCHASEAMOUNTUSD) AS TOTAL_SPEND, 
	ROUND(AVG(PURCHASEAMOUNTUSD), 2) AS AVERAGE_SPEND
FROM CUSTOMERSHOPPINGTRENDS
GROUP BY GENDER

-- Frequency of Purchases Total & Proportion of customer per frequency of purchase 
WITH Total_Customers AS (
    SELECT COUNT(*) AS Total
    FROM CustomerShoppingTrends
)
SELECT
    FrequencyOfPurchases,
    COUNT(*) AS Number_Of_Customers,
    ROUND((COUNT(*)::NUMERIC / (SELECT Total FROM Total_Customers)::NUMERIC) * 100::NUMERIC, 2) AS Proportion_Of_Customers
FROM CustomerShoppingTrends
GROUP BY FrequencyOfPurchases
ORDER BY Number_Of_Customers DESC;

-- Categories purchased by Gender
WITH gender_purchases AS (
    SELECT
        Gender,
        Category,
        COUNT(*) AS total_purchases
    FROM
        CustomerShoppingTrends
    GROUP BY
        Gender, Category
),
total_purchases_by_gender AS (
    SELECT
        Gender,
        COUNT(*) AS total
    FROM
        CustomerShoppingTrends
    GROUP BY
        Gender
)
SELECT
    gp.Gender,
    gp.Category,
    gp.total_purchases,
    ROUND((gp.total_purchases::NUMERIC / tpg.total) * 100, 2) AS percentage_of_gender_total
FROM
    gender_purchases gp
JOIN
    total_purchases_by_gender tpg ON gp.Gender = tpg.Gender
ORDER BY
    gp.Gender, gp.Category;

-- Number of customers that purchased with a subscription vs. without
-- 2847 with no subscription, 1053 with subscription
SELECT subscriptionstatus, COUNT(*) purchase_count
FROM customershoppingtrends
GROUP BY subscriptionstatus


-- Average purchase amount per subscription status
-- No subscription = $59.87, Subscription = $59.49
SELECT subscriptionstatus,
	   ROUND(AVG(purchaseamountusd), 2) AS Average_purchase_amount
FROM customershoppingtrends
GROUP BY subscriptionstatus