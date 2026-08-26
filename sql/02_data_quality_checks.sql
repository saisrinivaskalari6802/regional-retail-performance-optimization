-- 02_data_quality_checks.sql
-- Automated quality checks run after staging loads.
-- Failures are logged and alerted before transformation proceeds.

-- 1. Row count and freshness
SELECT
    'fact_sales_staging' AS table_name,
    COUNT(*) AS row_count,
    MIN(sale_date) AS min_date,
    MAX(sale_date) AS max_date
FROM staging.fact_sales;

-- 2. Null rate on critical keys
SELECT
    SUM(CASE WHEN store_id IS NULL THEN 1 ELSE 0 END) * 1.0 / COUNT(*) AS null_store_pct,
    SUM(CASE WHEN sku_id IS NULL THEN 1 ELSE 0 END) * 1.0 / COUNT(*) AS null_sku_pct,
    SUM(CASE WHEN net_revenue IS NULL THEN 1 ELSE 0 END) * 1.0 / COUNT(*) AS null_revenue_pct
FROM staging.fact_sales;

-- 3. Referential integrity – sales vs store master
SELECT COUNT(*) AS orphan_store_rows
FROM staging.fact_sales s
LEFT JOIN staging.dim_store d ON s.store_id = d.store_id
WHERE d.store_id IS NULL;

-- 4. Revenue reconciliation sample (vs finance extract)
SELECT
    DATE_TRUNC('month', sale_date) AS month,
    SUM(net_revenue) AS staging_revenue
FROM staging.fact_sales
GROUP BY 1
ORDER BY 1;

-- 5. Duplicate transaction check
SELECT transaction_id, COUNT(*) AS cnt
FROM staging.fact_sales
GROUP BY transaction_id
HAVING COUNT(*) > 1;
