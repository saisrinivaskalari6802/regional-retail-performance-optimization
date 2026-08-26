# Measure Catalog (Power BI / DAX)

## Core Revenue & Transaction Measures
- **Total Revenue** = SUM(fact_sales[net_revenue])
- **Total Units** = SUM(fact_sales[units])
- **AOV** = DIVIDE([Total Revenue], DISTINCTCOUNT(fact_sales[transaction_id]))
- **Units per Transaction** = DIVIDE([Total Units], DISTINCTCOUNT(fact_sales[transaction_id]))
- **Gross Margin $** = SUM(fact_sales[net_revenue] - fact_sales[cost])
- **Gross Margin %** = DIVIDE([Gross Margin $], [Total Revenue])

## Time Intelligence
- **Revenue YoY %** = DIVIDE([Total Revenue] - [Total Revenue PY], [Total Revenue PY])
- **Revenue vs Prior Period** (dynamic via date table)

## Campaign Measures
- **Total Spend** = SUM(fact_campaign[spend])
- **Attributed Revenue** = SUM(fact_campaign[attributed_revenue])
- **ROAS** = DIVIDE([Attributed Revenue], [Total Spend])
- **CAC (proxy)** = DIVIDE([Total Spend], DISTINCTCOUNT of new customers in period)

## Customer & Retention
- **Active Customers** = DISTINCTCOUNT(fact_sales[customer_id])
- **90-Day Retention Rate** = Customers with ≥2 purchases within 90 days / New customers in cohort
- **Repeat Revenue Share** = Revenue from repeat customers / Total Revenue

## Inventory
- **Sell-Through %** = Units sold / (Units sold + Ending on-hand)
- **Weeks of Supply** = On-hand units / Average weekly units sold (trailing 4–8 weeks)

All measures follow consistent filter context and are documented for hand-over.
