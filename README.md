# WSDA Music Store – SQL Business Analysis

## Project Overview
This project analyzes the **WSDA Music Store dataset** using SQL to uncover insights about customer behavior, revenue generation, and purchasing patterns.

The objective of the analysis is to simulate how a data analyst would support **business decision-making** by identifying revenue drivers, high-value customers, purchasing trends, and potential growth opportunities.

All analysis was performed using SQLite and focuses on transforming raw transactional data into meaningful business insights.

---

## Business Questions Addressed

The analysis focuses on answering several key business questions:

- How is revenue trending over time and what is the monthly growth rate?
- Which customers generate the highest lifetime revenue?
- How can customers be segmented based on their purchasing value?
- Which customers are inactive or at risk of churn?
- How concentrated is revenue among top customers?
- Which artists generate the most revenue relative to their catalog size?
- Which tracks are frequently purchased together?
- Are there countries with fewer transactions but higher average order value?
- Are there any data integrity issues within the invoice records?

---

## Key SQL Techniques Demonstrated

This project applies several important SQL concepts used in real-world analytics:

- Joins across relational tables
- Window functions (RANK, LAG)
- Common Table Expressions (CTEs)
- Subqueries
- Aggregations (SUM, AVG, COUNT)
- CASE statements for customer segmentation
- Anti-joins using NOT EXISTS
- Time-series analysis
- Data validation queries

---

## Project Structure
wsda-music-sql-analysis

**data/**  
Contains the SQLite database used for the analysis.

**sql/**  
Contains all SQL queries used to perform the business analysis.

**results/**  
Contains all outputs of the SQL queries.

**project_environment/**  
The DB Browser project file that stores the development environment.

---

## Example Analyses Included

**Customer Lifetime Revenue Ranking**  
Ranks customers by total spending to identify high-value customers.

**Customer Revenue Segmentation**  
Segments customers into value tiers based on lifetime revenue.

**Monthly Revenue Trend Analysis**  
Calculates month-over-month revenue growth using window functions.

**Dormant Customer Identification**  
Detects customers who have not made a purchase in the last 6 months.

**Track Pair Purchase Analysis**  
Identifies tracks that are frequently purchased together.

**Artist Revenue Efficiency**  
Measures revenue generated per track for each artist.

---

## Sample Query Output

Below is an example of the customer lifetime revenue ranking generated from the SQL analysis.

<img width="1920" height="1080" alt="Customer Revenue Ranking" src="https://github.com/user-attachments/assets/1db357d2-e210-427b-942b-7d423e9d991e" />


---

## Key Insights

Based on the SQL analysis of the WSDA Music Store dataset, several interesting patterns emerged:

• **Revenue Concentration**  
A small group of high-value customers contributes a disproportionately large share of total revenue, highlighting the importance of customer retention strategies.

• **Customer Segmentation Opportunity**  
Customers can be segmented into high, medium, and low value tiers based on lifetime spending, enabling more targeted marketing and loyalty programs.

• **Dormant Customers Identified**  
Several customers have not made a purchase in over six months, suggesting potential re-engagement opportunities.

• **Product Affinity Patterns**  
Certain tracks are frequently purchased together, indicating potential for recommendation systems or bundled promotions.

• **Artist Revenue Efficiency Differences**  
Some artists generate significantly higher revenue per track, indicating stronger audience demand or catalog performance.

• **Geographic Purchasing Patterns**  
Some countries have relatively fewer orders but higher average order value, suggesting market-specific purchasing behavior.

---

## Tools Used

- SQL
- SQLite
- DB Browser for SQLite

---

## Dataset

This project uses the **WSDA Music Store dataset**, a relational database representing a digital music store containing information about:

- Customers
- Invoices
- Artists
- Albums
- Tracks
- Purchases

The dataset provides a realistic environment for practicing **relational data analysis and SQL querying**.

---

## Author

**Vansh Belani**  
Aspiring Data Analyst

If you found this project interesting or have feedback, feel free to connect with me on LinkedIn.
