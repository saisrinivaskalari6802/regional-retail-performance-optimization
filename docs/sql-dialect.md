# SQL dialect notes

Scripts are written for an analytics warehouse style (Snowflake / BigQuery / SQL Server mixed functions). Map as needed:

| Script function | Snowflake | PostgreSQL | SQL Server |
|-----------------|-----------|------------|------------|
| DATE_TRUNC('week', d) | DATE_TRUNC | DATE_TRUNC | DATETRUNC(week, d) |
| DATEADD(day, n, d) | DATEADD | d + n * INTERVAL '1 day' | DATEADD |
| DATEDIFF(day, a, b) | DATEDIFF | b - a | DATEDIFF |
| CREATE OR REPLACE TABLE | supported | CREATE TABLE ... (or CREATE OR REPLACE from PG 15+) | CREATE OR ALTER / drop-and-create |
| CURRENT_DATE | CURRENT_DATE | CURRENT_DATE | CAST(GETDATE() AS date) |

Quality checks in `02_data_quality_checks.sql` should be run after every load. Fail the pipeline if orphan store keys or duplicate transaction IDs appear.
