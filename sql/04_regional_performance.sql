-- 04_regional_performance.sql
-- Core regional performance view used by the dashboard and weekly stand-ups.

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
