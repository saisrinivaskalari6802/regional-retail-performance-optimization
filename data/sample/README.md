# Sample data

Synthetic retail data that matches `docs/data-dictionary.md`. Safe to share publicly (no real customer or company data).

| File | Rows | Purpose |
|------|------|---------|
| dim_store.csv | 20 | Store master (4 regions) |
| dim_product.csv | 50 | Product catalog |
| dim_customer.csv | 300 | Loyalty / acquisition attributes |
| fact_sales.csv | ~3,900 | Transactions Jan 2025 – Jun 2026 |
| fact_campaign.csv | 192 | Weekly campaign spend and attributed revenue |
| fact_inventory.csv | 400 | On-hand snapshot 2026-06-30 |

Load these into staging, then run `sql/03_star_schema_transforms.sql` (adjust schema names to your engine).

Regional bias is baked in: Northeast and West have higher AOV; Southeast and Midwest are lower — consistent with the case-study narrative.
