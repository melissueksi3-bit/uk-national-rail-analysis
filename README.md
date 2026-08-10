# UK National Rail — Sales & Punctuality Dashboard

An exploratory Power BI dashboard analysing **31,653 National Rail ticket sales**
(January–April 2024) to surface insights on revenue, on-time performance, and
passenger demand across the UK network.

> Built as a portfolio project. Data: *UK Train Rides* sample dataset from
> Maven Analytics (mock National Rail ticket data).
> 
## Dashboard
![UK National Rail Power BI Dashboard](rail%20data%20dashboard.PNG)
---

## The brief
Acting as a BI Developer for National Rail, I built a dashboard to help the
operations team understand **where revenue comes from, when passengers travel,
and how reliably trains run** — so the business can make data-driven decisions
about scheduling, pricing, and performance.

## Questions I set out to answer
1. Which routes and stations generate the most revenue and journeys?
2. When are the peak travel times across the day and week?
3. What is the on-time vs delayed/cancelled rate, and which stations perform worst?
4. What are the main causes of delays, and how much revenue is exposed to refunds?
5. How do ticket type and class relate to revenue?

## Key findings
- **£741,921** total revenue across **31,653** journeys and **65 routes** (avg fare **£23.44**).
- **86.8%** of journeys ran on time; **7.2%** delayed and **5.9%** cancelled.
- **London Kings Cross → York** is the top route by revenue (**£183k**), followed by
  **Liverpool Lime Street → London Euston** (**£113k**).
- Demand peaks at the **06:00–08:00** and **16:00–18:00** commuter windows.
- **Weather** is the leading delay cause, then **signal failures** and **staffing**.
- **£38,702** of revenue was exposed to refund requests (~3.5% of journeys).
- **Advance** tickets drive the most revenue (**£309k**), ahead of Off-Peak and Anytime.

*(Full recommendations are documented in the dashboard's insights panel.)*

## Tools & skills
- **Power BI** — Power Query (cleaning), data modelling, DAX measures, dashboard design
- **SQL** — exploratory queries (see `rail_analysis_queries.sql`)
- **Excel** — initial data profiling

## Data cleaning notes
- Standardised inconsistent delay-reason labels (e.g. "Signal Failure" / "Signal failure",
  "Weather" / "Weather Conditions", "Staffing" / "Staff Shortage").
- Filled missing `Railcard` values as **None** and blank delay reasons as **N/A**.
- Derived fields: departure hour, day of week, month, and a combined route field.

## Repo contents
| File | Description |
|------|-------------|
| `railway_cleaned.csv` | Cleaned dataset used in the dashboard |
| `rail_analysis_queries.sql` | SQL queries answering the business questions |
| `Rail_Dashboard.pbix` | Power BI file *(add once built)* |
| `dashboard.png` | Screenshot of the final dashboard *(add once built)* |

## How to view
Open `Rail_Dashboard.pbix` in Power BI Desktop (free), or view the screenshot above.

---
*Author: Melis Su Eksi · [LinkedIn](#) · Data © Maven Analytics (sample dataset).*
