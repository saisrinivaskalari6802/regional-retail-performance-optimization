-- 07_inventory_alignment.sql
-- Sell-through and weeks of supply for high-margin SKUs in lagging regions.

WITH weekly_units AS (
    SELECT
        d.region,
        s.sku_id,
        DATE_TRUNC('week', s.sale_date) AS week_start,
        SUM(s.units) AS units_sold,
        SUM(s.margin) AS margin
    FROM analytics.fact_sales s
    JOIN analytics.dim_store d ON s.store_id = d.store_id
    GROUP BY 1, 2, 3
),
avg_weekly AS (
    SELECT
        region,
        sku_id,
        AVG(units_sold) AS avg_weekly_units,
        SUM(margin) AS margin_18m
    FROM weekly_units
    GROUP BY 1, 2
),
on_hand AS (
    SELECT
        d.region,
        i.sku_id,
        SUM(i.on_hand_units) AS on_hand_units
    FROM analytics.fact_inventory i
    JOIN analytics.dim_store d ON i.store_id = d.store_id
    GROUP BY 1, 2
)
SELECT
    a.region,
    a.sku_id,
    p.category,
    p.subcategory,
    a.margin_18m,
    a.avg_weekly_units,
    o.on_hand_units,
    CASE
        WHEN a.avg_weekly_units = 0 THEN NULL
        ELSE o.on_hand_units * 1.0 / a.avg_weekly_units
    END AS weeks_of_supply,
    CASE
        WHEN (a.avg_weekly_units + COALESCE(o.on_hand_units, 0)) = 0 THEN NULL
        ELSE a.avg_weekly_units * 1.0 / (a.avg_weekly_units + COALESCE(o.on_hand_units, 0))
    END AS sell_through_proxy
FROM avg_weekly a
JOIN analytics.dim_product p ON a.sku_id = p.sku_id
LEFT JOIN on_hand o ON a.region = o.region AND a.sku_id = o.sku_id
WHERE a.region IN ('Southeast', 'Midwest')
ORDER BY a.margin_18m DESC;
