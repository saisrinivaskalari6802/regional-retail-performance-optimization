# Load order

1. dim_store, dim_product, dim_customer
2. fact_sales, fact_campaign, fact_inventory
3. sql/02_data_quality_checks.sql
4. sql/03_star_schema_transforms.sql (point sources at these CSVs / staging tables)
5. sql/04 through sql/07 for analysis views
