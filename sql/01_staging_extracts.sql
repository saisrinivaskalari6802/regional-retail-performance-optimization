-- 01_staging_extracts.sql
-- Parameterized extracts from source systems into staging.
-- Designed for daily incremental loads with full history backfill option.

-- Example: Sales extract (last 18 months or incremental)
WITH sales_base AS (
    SELECT
        t.transaction_id,
        t.sale_date,
        t.store_id,
        t.customer_id,
        t.sku_id,
        t.units,
        t.net_revenue,
        t.discount_amount,
        t.cost,
        t.channel,
        t.campaign_id
    FROM source.pos_transactions t
    WHERE t.sale_date >= DATEADD(month, -18, CURRENT_DATE)
      AND t.sale_date < CURRENT_DATE
)
SELECT *
FROM sales_base;

-- Campaign activity extract
SELECT
    campaign_id,
    activity_date,
    spend,
    impressions,
    clicks,
    attributed_revenue,
    channel
FROM source.campaign_platform
WHERE activity_date >= DATEADD(month, -18, CURRENT_DATE);

-- Customer dimension snapshot
SELECT
    customer_id,
    first_purchase_date,
    acquisition_channel,
    loyalty_tier,
    primary_region
FROM source.crm_customers;

-- Store master
SELECT store_id, region, format, square_footage, open_date
FROM source.store_master;
