-- 04_regional_performance.sql
-- Feeds the Executive page: weekly revenue, AOV, units per transaction.
--
-- How to read the output
--   AOV = revenue / transactions. If AOV is low and transactions are not,
--   the region has a mix/offer problem, not a traffic problem.
--   units_per_txn falling with AOV often means customers trade down, not walk away.
--
-- Grain: region x channel x week.
-- Join: fact_sales to dim_store for region (never use free-text region on the fact).

WITH sales_agg AS (
    SELECT
        d.region,
        s.sale_date,
        s.channel,
        SUM(s.net_revenue) AS revenue,
        SUM(s.units) AS units,
        SUM(s.margin) AS margin,
        COUNT(DISTINCT s.transaction_id) AS transactions,
        COUNT(DISTINCT s.customer_id) AS customers
    FROM analytics.fact_sales s
    JOIN analytics.dim_store d ON s.store_id = d.store_id
    GROUP BY 1, 2, 3
),
metrics AS (
    SELECT
        region,
        channel,
        DATE_TRUNC('week', sale_date) AS week_start,
        SUM(revenue) AS revenue,
        SUM(units) AS units,
        SUM(margin) AS margin,
        SUM(transactions) AS transactions,
        SUM(customers) AS customers,
        SUM(revenue) * 1.0 / NULLIF(SUM(transactions), 0) AS aov,
        SUM(units) * 1.0 / NULLIF(SUM(transactions), 0) AS units_per_txn
    FROM sales_agg
    GROUP BY 1, 2, 3
)
SELECT *
FROM metrics
ORDER BY region, week_start DESC;
