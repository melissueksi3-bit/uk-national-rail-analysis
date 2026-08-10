/* ============================================================
   UK National Rail — SQL Analysis
   Dataset: railway_cleaned.csv  (load into a table called `railway`)
   Tool: works in SQLite, PostgreSQL, or MySQL with minor tweaks.
   Purpose: answer the 5 business questions with SQL, then rebuild
            the same answers visually in Power BI.
   ============================================================ */

/* ---------- KPI headline numbers ---------- */
SELECT
    COUNT(*)                         AS total_journeys,
    ROUND(SUM(Price), 0)             AS total_revenue,
    ROUND(AVG(Price), 2)             AS avg_ticket_price,
    COUNT(DISTINCT Departure_Station || ' - ' || Arrival_Destination) AS routes
FROM railway;

/* ---------- Q1. Top 10 routes by revenue ---------- */
SELECT
    Departure_Station || ' -> ' || Arrival_Destination AS route,
    COUNT(*)              AS journeys,
    ROUND(SUM(Price), 0)  AS revenue
FROM railway
GROUP BY route
ORDER BY revenue DESC
LIMIT 10;

/* ---------- Q1b. Top departure stations by revenue ---------- */
SELECT Departure_Station,
       COUNT(*)             AS journeys,
       ROUND(SUM(Price), 0) AS revenue
FROM railway
GROUP BY Departure_Station
ORDER BY revenue DESC
LIMIT 10;

/* ---------- Q2. Peak travel times (by departure hour) ---------- */
/* SQLite: substr(Departure_Time,1,2). Postgres: EXTRACT(HOUR FROM Departure_Time) */
SELECT CAST(substr(Departure_Time, 1, 2) AS INT) AS dep_hour,
       COUNT(*) AS journeys
FROM railway
GROUP BY dep_hour
ORDER BY dep_hour;

/* ---------- Q3. On-time performance (overall) ---------- */
SELECT Journey_Status,
       COUNT(*)                                   AS journeys,
       ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 1) AS pct
FROM railway
GROUP BY Journey_Status
ORDER BY journeys DESC;

/* ---------- Q3b. Worst on-time % by departure station (min 200 journeys) ---------- */
SELECT Departure_Station,
       COUNT(*) AS journeys,
       ROUND(100.0 * SUM(CASE WHEN Journey_Status = 'On Time' THEN 1 ELSE 0 END) / COUNT(*), 1) AS on_time_pct
FROM railway
GROUP BY Departure_Station
HAVING COUNT(*) >= 200
ORDER BY on_time_pct ASC
LIMIT 8;

/* ---------- Q4. Delay reasons + refund exposure ---------- */
SELECT Reason_for_Delay,
       COUNT(*) AS occurrences
FROM railway
WHERE Journey_Status IN ('Delayed', 'Cancelled')
GROUP BY Reason_for_Delay
ORDER BY occurrences DESC;

/* Refund value at risk (revenue tied to tickets where a refund was requested) */
SELECT COUNT(*)             AS refund_requests,
       ROUND(SUM(Price), 0) AS value_at_risk
FROM railway
WHERE Refund_Request = 'Yes';

/* ---------- Q5. Revenue by ticket type and class ---------- */
SELECT Ticket_Type,
       Ticket_Class,
       COUNT(*)             AS journeys,
       ROUND(SUM(Price), 0) AS revenue
FROM railway
GROUP BY Ticket_Type, Ticket_Class
ORDER BY revenue DESC;

/* ---------- Bonus. Revenue by month ---------- */
SELECT substr(Date_of_Journey, 1, 7) AS month,
       ROUND(SUM(Price), 0)          AS revenue
FROM railway
GROUP BY month
ORDER BY month;
