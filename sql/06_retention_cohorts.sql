-- 06_retention_cohorts.sql
-- Simple 90-day retention by acquisition cohort and channel.

WITH first_purchase AS (
    SELECT
        customer_id,
        MIN(sale_date) AS first_sale_date,
        DATE_TRUNC('month', MIN(sale_date)) AS cohort_month
    FROM analytics.fact_sales
    WHERE customer_id IS NOT NULL
    GROUP BY 1
),
repeat_purchases AS (
    SELECT
        f.customer_id,
        f.cohort_month,
        c.acquisition_channel,
        MAX(CASE WHEN s.sale_date > f.first_sale_date
                  AND s.sale_date <= DATEADD(day, 90, f.first_sale_date)
                 THEN 1 ELSE 0 END) AS retained_90d
    FROM first_purchase f
    JOIN analytics.dim_customer c ON f.customer_id = c.customer_id
    LEFT JOIN analytics.fact_sales s ON f.customer_id = s.customer_id
    GROUP BY 1, 2, 3
)
SELECT
    cohort_month,
    acquisition_channel,
    COUNT(*) AS new_customers,
    SUM(retained_90d) AS retained_customers,
    SUM(retained_90d) * 1.0 / COUNT(*) AS retention_rate_90d
FROM repeat_purchases
GROUP BY 1, 2
ORDER BY cohort_month DESC, acquisition_channel;
