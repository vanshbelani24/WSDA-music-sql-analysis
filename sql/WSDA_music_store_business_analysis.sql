-- =========================================================
-- Project: WSDA Music Store SQL Analysis
-- Objective: Analyze customer behavior, revenue trends, and product performance
-- Dataset: WSDA Music Database
-- Tools: SQLite
-- =========================================================

Query-1

/*	Query: Invoice Data Integrity Check
	Business Question: Are there invoices with zero or negative transaction values?
	Technique: Simple validation query used for identifying data quality issues.
*/
SELECT InvoiceId
FROM Invoice
WHERE Total <= 0;


Query-2

/*	Query: Monthly Revenue Month-over-Month Growth
	Business Question: How is total revenue trending over time and what is the monthly growth rate?
	Technique: Uses a CTE and LAG() window function to compare revenue with the previous month.
*/
WITH monthly_revenue AS (
    SELECT 
        strftime('%Y-%m', InvoiceDate) AS Month,
        SUM(Total) AS Revenue
    FROM Invoice
    GROUP BY Month
)

SELECT
    Month,
    Revenue,
    LAG(Revenue) OVER (ORDER BY Month) AS Prev_Revenue,
    ROUND(
        (Revenue - LAG(Revenue) OVER (ORDER BY Month)) 
        * 100.0 / LAG(Revenue) OVER (ORDER BY Month),
        2
    ) AS MoM_Growth_Percent
FROM monthly_revenue;


Query-3

/*	Query: Customer Lifetime Revenue Ranking
	Business Question: Which customers generate the highest lifetime revenue?
	Technique: Aggregates invoice totals per customer and ranks them using a window function.
*/
SELECT
	c.CustomerId, 
	c.FirstName|| ' ' || c.LastName AS Customer,
	SUM(i.Total) as "Lifetime Revenue",
	RANK() OVER (ORDER BY SUM(i.Total) DESC) AS Revenue_Rank
FROM Customer c
JOIN Invoice i
ON c.CustomerId = i.CustomerId
GROUP BY c.CustomerId
ORDER BY SUM(i.Total) DESC


Query-4

/*	Query: Customer Revenue Segmentation
	Business Question: How can customers be segmented based on their lifetime revenue?
	Technique: Uses CASE statements to classify customers into value tiers.
*/
SELECT 
	CustomerId,
	sum(Total) AS "Lifetime Revenue",
	CASE
		WHEN sum(Total)>= 40 THEN "High Value"
		WHEN sum(Total) BETWEEN 20 AND 39 THEN "Medium Value"
		ELSE "Low Value"
	END AS "Customer Segment"
FROM Invoice
GROUP BY CustomerId
ORDER BY "Lifetime Revenue" DESC;


Query-5

/*	Query: Above-Average Customer Spending
	Business Question: Which customers spend more than the average customer?
	Technique: Uses nested aggregation to compare customer spending against the global average.
*/
WITH avg_spend AS (
    SELECT AVG(customer_total) AS avg_value
    FROM (
        SELECT SUM(Total) AS customer_total
        FROM Invoice
        GROUP BY CustomerId
		HAVING CustomerId != 60
    )
)

SELECT 
    CustomerId,
    SUM(Total) AS Total_Spent
FROM Invoice
GROUP BY CustomerId
HAVING Total_Spent > (SELECT avg_value FROM avg_spend);


Query-6

/*	Query: Dormant Customer Identification
	Business Question: Which customers have not made a purchase in the last 6 months?
	Technique: Uses a CTE to calculate each customer's last purchase date and filters inactive customers.
*/
WITH last_purchase AS (
    SELECT 
        CustomerId,
        MAX(InvoiceDate) AS Last_Invoice_Date
    FROM Invoice
    GROUP BY CustomerId
)
SELECT 
    c.CustomerId,
    c.FirstName || ' ' || c.LastName AS Customer,
    lp.Last_Invoice_Date
FROM Customer c
JOIN last_purchase lp USING (CustomerId)
WHERE lp.Last_Invoice_Date < (
    SELECT DATE(MAX(InvoiceDate), '-6 months') FROM Invoice
);


Query-7

/*	Query: Non-Purchasing Registered Customers
	Business Question: Which customers are registered in the system but have never made a purchase?
	Technique: Uses a NOT EXISTS anti-join to find customers without matching records in the Invoice table.
*/
SELECT CustomerId
FROM Customer c
WHERE NOT EXISTS (
    SELECT 1 
    FROM Invoice i 
    WHERE i.CustomerId = c.CustomerId
);


Query-8

/*	Query: Frequently Purchased Track Pairs
	Business Question: Which pairs of tracks are commonly purchased together?
	Technique: Self-join on invoice lines to identify co-purchased tracks within the same transaction.
*/
SELECT 
    il1.TrackId AS Track_1,
    il2.TrackId AS Track_2,
    COUNT(*) AS Frequency
FROM InvoiceLine il1
JOIN InvoiceLine il2 
    ON il1.InvoiceId = il2.InvoiceId 
   AND il1.TrackId < il2.TrackId
GROUP BY Track_1, Track_2
ORDER BY Frequency DESC
LIMIT 10;


Query-9

/*	Query: Artist Revenue Efficiency
	Business Question: Which artists generate the highest revenue per track?
	Technique: Combines artist, album, track, and sales data to calculate revenue per track.
*/
SELECT
	ar.Name AS Artist,
	count(distinct t.TrackId) AS Tracks,
	sum(il.UnitPrice*il.Quantity) AS Renvenue,
	round(sum(il.UnitPrice*il.Quantity)/count(distinct t.TrackId),2) AS "Revenue Per Track"
FROM Artist ar
JOIN Album al USING (ArtistId)
JOIN Track t USING (AlbumId)
JOIN InvoiceLine il USING (TrackId)
GROUP BY ar.ArtistId
ORDER BY "Revenue Per Track" DESC;


Query-10

/*	Query: Country Order Behavior Analysis
	Business Question: Which countries have lower order counts but higher average order value?
	Technique: Groups invoices by country and filters countries with fewer transactions.
*/
SELECT 
    BillingCountry,
    COUNT(InvoiceId) AS Orders,
    AVG(Total) AS "Avg Order Value"
FROM Invoice
GROUP BY BillingCountry
HAVING Orders < 20
ORDER BY "Avg Order Value" DESC;


Query-11

/*	Query: Revenue Contribution of Top Customers
	Business Question: How much revenue is generated by the top 10 highest-spending customers?
	Technique: Uses a CTE to calculate customer revenue, then aggregates the revenue of the top customers.
*/
WITH customer_revenue AS (
    SELECT 
        CustomerId,
        SUM(Total) AS Revenue
    FROM Invoice
    GROUP BY CustomerId
    ORDER BY Revenue DESC
    LIMIT 10
)

SELECT 
    COUNT(*) AS Top_Customers,
    SUM(Revenue) AS Top_Revenue
FROM customer_revenue;
