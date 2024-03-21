-- Average purchase amounts with vs. without discount codes; With vs. without promo codes
SELECT
    'Discount Applied' AS Condition,
    ROUND(AVG(PurchaseAmountUSD), 2) AS AveragePurchaseAmount
FROM CustomerShoppingTrends
WHERE DiscountApplied = 'Yes'
UNION
SELECT
    'No Discount Applied' AS Condition,
    ROUND(AVG(PurchaseAmountUSD), 2)
FROM CustomerShoppingTrends
WHERE DiscountApplied = 'No'
UNION
SELECT
    'Promo Code Used' AS Condition,
    ROUND(AVG(PurchaseAmountUSD), 2)
FROM CustomerShoppingTrends
WHERE PromoCodeUsed = 'Yes'
UNION
SELECT
    'No Promo Code Used' AS Condition,
    ROUND(AVG(PurchaseAmountUSD), 2)
FROM CustomerShoppingTrends
WHERE PromoCodeUsed = 'No';

-- Purchase frequency with vs. without discount codes; With vs. without promo codes
WITH Purchase_Frequency AS (
    SELECT
        CustomerID,
        DiscountApplied,
        PromoCodeUsed,
        COUNT(*) AS PurchaseCount
    FROM CustomerShoppingTrends
    GROUP BY CustomerID, DiscountApplied, PromoCodeUsed
)
SELECT
    'Discount Applied' AS Condition,
    AVG(PurchaseCount) AS AverageFrequency
FROM Purchase_Frequency
WHERE DiscountApplied = 'Yes'
UNION
SELECT
    'No Discount Applied' AS Condition,
    AVG(PurchaseCount)
FROM Purchase_Frequency
WHERE DiscountApplied = 'No'
UNION
SELECT
    'Promo Code Used' AS Condition,
    AVG(PurchaseCount)
FROM Purchase_Frequency
WHERE PromoCodeUsed = 'Yes'
UNION
SELECT
    'No Promo Code Used' AS Condition,
    AVG(PurchaseCount)
FROM Purchase_Frequency
WHERE PromoCodeUsed = 'No';

-- Highest sales volume and revenue by location
-- Top 5 states: Montana, California, Idaho, Illinois, Alabama
SELECT 
	location, 
	COUNT(*) AS Number_of_sales,
	SUM(purchaseamountusd) AS Total_Revenue
FROM customershoppingtrends
GROUP BY location
ORDER BY Number_of_sales DESC
LIMIT 5

-- Popularity of shipping types & Impact on sales
-- "Free Shipping" was the most popular shipping method and had the highest revenue.
-- "Express" shipping wasn't as popular but had the 2nd highest revenue.

SELECT shippingtype, 
	   COUNT(*) AS Number_of_transactions, 
	   SUM(purchaseamountusd) AS Total_revenue
  FROM customershoppingtrends
 GROUP BY shippingtype
 ORDER BY Number_of_transactions DESC, Total_revenue