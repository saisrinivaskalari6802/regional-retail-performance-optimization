# Error & Quality Check Notes

## SQL Review (Completed)
- All scripts use safe division (NULLIF) where appropriate.
- Regional performance aggregation correctly rolls daily → weekly.
- Retention cohort logic correctly flags any repeat purchase within 90 days of first purchase.
- Star schema transforms handle null store/sku filtering.
- No syntax errors; patterns are production-standard for SQL Server / Snowflake / BigQuery style engines (minor dialect differences may require DATE_TRUNC vs DATE_BUCKET adjustments).

## Potential Improvements (Optional)
- Add explicit CAST for decimal precision on margin and rates if source types vary.
- For very large fact tables, consider partitioning by sale_date and incremental merge instead of full rebuild.
- Guest transactions (null customer_id) are correctly excluded from retention metrics.

## Power BI / DAX
- All core measures use DIVIDE.
- Time intelligence requires a marked Date table.
- Campaign measures assume upstream attribution flagging.

## Dashboard Deliverable
A polished 7-slide PowerPoint simulation of the final dashboard pages has been created for portfolio use (KPI cards, charts, tables, recommendations). This is the practical shareable artifact when a live .pbix cannot be hosted.

No blocking errors found in the project logic or documentation.
