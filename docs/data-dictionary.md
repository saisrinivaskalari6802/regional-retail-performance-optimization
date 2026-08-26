# Data Dictionary

## Core Fact Tables

### fact_sales
| Column | Type | Description |
|--------|------|-------------|
| transaction_id | VARCHAR | Unique transaction identifier |
| sale_date | DATE | Transaction date |
| store_id | VARCHAR | Store / location key |
| customer_id | VARCHAR | Loyalty / CRM customer key (nullable for guest) |
| sku_id | VARCHAR | Product key |
| units | INT | Units sold |
| net_revenue | DECIMAL | Revenue after discounts |
| discount_amount | DECIMAL | Discount applied |
| cost | DECIMAL | COGS |
| channel | VARCHAR | Store / Ecom / Marketplace |
| campaign_id | VARCHAR | Attributed campaign (nullable) |

### fact_campaign
| Column | Type | Description |
|--------|------|-------------|
| campaign_id | VARCHAR | Campaign key |
| activity_date | DATE | Spend / impression date |
| spend | DECIMAL | Media cost |
| impressions | BIGINT | Impressions |
| clicks | INT | Clicks |
| attributed_revenue | DECIMAL | Revenue attributed within window |
| channel | VARCHAR | Email / Paid Social / Search / etc. |

## Dimension Tables

### dim_customer
- customer_id, first_purchase_date, acquisition_channel, loyalty_tier, primary_region

### dim_product
- sku_id, category, subcategory, season, unit_cost, list_price

### dim_store
- store_id, region, format (flagship / outlet / suburban), square_footage, open_date

## Derived Fields (created in transforms)
- margin = net_revenue - cost
- days_since_last_purchase
- is_repeat_customer (within 90 days)
- campaign_attributed_flag (7-day post-click window)
- weeks_of_supply (inventory / average weekly units)
