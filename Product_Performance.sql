-- Top-selling products and categories:
SELECT category, itempurchased, SUM(purchaseamountusd) AS TotalPerCategory
FROM customershoppingtrends
GROUP BY category, itempurchased
ORDER BY SUM(purchaseamountusd) DESC

-- Number of sales and total revenue by season
-- SPRING = 999, $58,679
-- FALL = 975, $60,018
-- WINTER = 971, $58607
-- SUMMER = 955, $55,777
SELECT 
	season, 
	COUNT(*) AS NumberofSales, 
	SUM(purchaseamountusd) AS TotalSales
FROM customershoppingtrends
GROUP BY season
ORDER BY COUNT(*) DESC, SUM(purchaseamountusd) DESC

-- Seasonal sales by category
-- Clothing saw the highest sales in Spring, Accesories in Fall, Footwear in Spring, Outerwear in Fall
-- Clothing had the highest sales overall in all Seasons
SELECT season, category, SUM(purchaseamountusd) AS SeasonalSalesPerCategory
FROM customershoppingtrends
GROUP BY season, category
ORDER BY SUM(purchaseamountusd) DESC

-- Products with the highest and lowest review ratings
-- Product names are too vague to draw relevant conclusions
SELECT itempurchased, reviewrating
FROM customershoppingtrends
ORDER BY reviewrating DESC
LIMIT 10

SELECT itempurchased, reviewrating
FROM customershoppingtrends
ORDER BY reviewrating ASC
LIMIT 10

-- Do discounts affect customer reviews?
-- No, discounts do not affect review ratings. Similar case for promo codes
SELECT itempurchased, reviewrating, discountapplied
FROM customershoppingtrends
ORDER BY reviewrating DESC
LIMIT 10

SELECT itempurchased, reviewrating, discountapplied
FROM customershoppingtrends
ORDER BY reviewrating ASC
LIMIT 10

