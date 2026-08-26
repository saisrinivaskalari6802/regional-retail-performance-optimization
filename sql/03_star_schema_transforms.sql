-- 03_star_schema_transforms.sql
-- Build clean star schema from staging.

-- Dim Store
CREATE OR REPLACE TABLE analytics.dim_store AS
SELECT
    store_id,
    UPPER(TRIM(region)) AS region,
    format,
    square_footage,
    open_date
FROM staging.dim_store;

-- Dim Product (simplified)
CREATE OR REPLACE TABLE analytics.dim_product AS
SELECT
    sku_id,
    category,
    subcategory,
    season,
    unit_cost,
    list_price
FROM staging.dim_product;

-- Dim Customer with derived fields
CREATE OR REPLACE TABLE analytics.dim_customer AS
SELECT
    c.customer_id,
    c.first_purchase_date,
    c.acquisition_channel,
    c.loyalty_tier,
    c.primary_region,
    DATEDIFF(day, c.first_purchase_date, CURRENT_DATE) AS customer_tenure_days
FROM staging.dim_customer c;

-- Fact Sales with derived margin and flags
CREATE OR REPLACE TABLE analytics.fact_sales AS
SELECT
    s.transaction_id,
    s.sale_date,
    s.store_id,
    s.customer_id,
    s.sku_id,
    s.units,
    s.net_revenue,
    s.discount_amount,
    s.cost,
    s.net_revenue - s.cost AS margin,
    s.channel,
    s.campaign_id,
    CASE WHEN s.campaign_id IS NOT NULL THEN 1 ELSE 0 END AS campaign_attributed_flag
FROM staging.fact_sales s
WHERE s.store_id IS NOT NULL
  AND s.sku_id IS NOT NULL;

-- Fact Campaign
CREATE OR REPLACE TABLE analytics.fact_campaign AS
SELECT *
FROM staging.fact_campaign;
