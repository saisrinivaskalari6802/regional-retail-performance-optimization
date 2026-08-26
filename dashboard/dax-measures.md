# Complete DAX Measure Catalog

All measures assume a proper Date table related to fact_sales[sale_date] and fact_campaign[activity_date].

## Core Measures

```dax
Total Revenue = SUM(fact_sales[net_revenue])

Total Units = SUM(fact_sales[units])

Total Transactions = DISTINCTCOUNT(fact_sales[transaction_id])

AOV = DIVIDE([Total Revenue], [Total Transactions])

Units per Transaction = DIVIDE([Total Units], [Total Transactions])

Gross Margin $ = SUMX(fact_sales, fact_sales[net_revenue] - fact_sales[cost])

Gross Margin % = DIVIDE([Gross Margin $], [Total Revenue])
```

## Time Intelligence

```dax
Total Revenue PY = CALCULATE([Total Revenue], SAMEPERIODLASTYEAR('Date'[Date]))

Revenue YoY % = DIVIDE([Total Revenue] - [Total Revenue PY], [Total Revenue PY])

Total Revenue Prior Period = CALCULATE([Total Revenue], DATEADD('Date'[Date], -1, MONTH))
```

## Campaign Measures

```dax
Total Spend = SUM(fact_campaign[spend])

Attributed Revenue = SUM(fact_campaign[attributed_revenue])

ROAS = DIVIDE([Attributed Revenue], [Total Spend])

CTR = DIVIDE(SUM(fact_campaign[clicks]), SUM(fact_campaign[impressions]))
```

## Customer & Retention

```dax
Active Customers = DISTINCTCOUNT(fact_sales[customer_id])

// Example pattern for retention (requires cohort logic or pre-aggregated table)
Retention Rate 90d = 
DIVIDE(
    CALCULATE(
        DISTINCTCOUNT(fact_sales[customer_id]),
        FILTER(
            fact_sales,
            fact_sales[is_repeat_90d] = 1
        )
    ),
    [Active Customers]
)
```

## Notes on Implementation
- Prefer DIVIDE over / to avoid divide-by-zero errors.
- Use SUMX for row-context calculations involving multiple columns.
- Campaign attribution window (7-day) is applied upstream in SQL; measures consume the pre-flagged data.
- Row-level security filters on dim_store[region] for regional users.
