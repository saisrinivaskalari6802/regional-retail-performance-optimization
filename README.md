# Regional Retail Performance & Campaign Effectiveness Optimization

**Portfolio Project | Data Analytics | SQL + Power BI + Excel**

End-to-end analytics engagement for a national multi-brand apparel retailer (180+ stores + e-commerce). The project delivered a governed reporting layer and interactive dashboards that reduced manual reporting effort, improved visibility into regional performance gaps, and supported marketing budget and inventory decisions.

---

## Business Context

Store-level revenue growth had slowed while marketing spend increased. Leadership lacked a unified, timely view of regional sales performance, campaign contribution, customer retention, and inventory alignment. Prior reporting was fragmented across POS, CRM, and campaign platforms and produced with multi-day lag.

**Primary goals**
- Cut reporting cycle time and manual effort
- Surface regional performance and campaign ROI drivers
- Enable self-service analysis for merchandising and marketing stakeholders
- Support actionable decisions on budget allocation and assortment

**Key KPIs**
- Revenue (region / channel / category)
- Average Order Value (AOV)
- Conversion rate & CAC
- Campaign ROAS / ROI
- 90-day customer retention
- Inventory sell-through % and weeks of supply

---

## Project Structure

```
├── README.md
├── docs/
│   ├── business-requirements.md
│   ├── data-dictionary.md
│   ├── measure-catalog.md
│   └── executive-summary.md
├── sql/
│   ├── 01_staging_extracts.sql
│   ├── 02_data_quality_checks.sql
│   ├── 03_star_schema_transforms.sql
│   ├── 04_regional_performance.sql
│   ├── 05_campaign_attribution.sql
│   └── 06_retention_cohorts.sql
├── analysis/
│   └── key-insights-notes.md
└── dashboard/
    └── powerbi-overview.md
```

---

## Technical Approach

1. **Data sources** – POS/ERP sales, CRM/loyalty, digital campaign platforms, inventory snapshots, store master.
2. **Extraction & staging** – Parameterized SQL pulls with CTEs and window functions.
3. **Cleaning & quality** – Null handling, region standardization, referential integrity checks, revenue reconciliation against finance extracts.
4. **Modeling** – Star schema (fact_sales, fact_campaign, dim_customer, dim_product, dim_store) with derived fields (margin, days_since_last_purchase, attributed flags).
5. **Analysis layer** – Regional aggregations, campaign lift, RFM-style segmentation, retention cohorts, anomaly flags.
6. **Visualization** – Power BI workspace with executive summary, drill-through pages, DAX measures, row-level security by region, and scheduled refresh.
7. **Governance** – Data dictionary, measure catalog, lineage notes, and parallel-run validation against legacy reports.

---

## Key Outcomes (Pilot)

- Manual reporting effort reduced ~40%
- Reporting latency reduced from 7–10 days to next-business-day
- Discrepancies lowered substantially through automated quality checks
- Marketing and merchandising teams used the dashboards for budget reallocation and assortment adjustments in lagging regions

---

## How to Explore This Repo

- Start with `docs/executive-summary.md` for the business narrative and results.
- Review `sql/` for the transformation and analysis logic (realistic patterns used in consulting environments).
- See `docs/data-dictionary.md` and `docs/measure-catalog.md` for definitions.
- `dashboard/powerbi-overview.md` describes the report pages and DAX approach.

This repository is designed as a portfolio demonstration of end-to-end analytics work typical of a Data Analyst engagement in retail / marketing analytics.

---

**Author:** Sai Srinivas Chowdary Kalari  
**Tools:** SQL (CTEs, Window Functions, Joins), Power BI (DAX, Star Schema), Excel (Power Query), Data Quality & Stakeholder Communication
