# Power BI Dashboard Overview

## Workspace Structure
- **Executive Summary** – KPI cards, sparklines, regional heatmap, top/bottom performers.
- **Regional Performance** – Revenue, AOV, units, margin by region / store / channel with week selector.
- **Campaign Effectiveness** – Spend, attributed revenue, ROAS, CTR by channel and campaign; trend lines.
- **Customer Retention** – Cohort retention curves and acquisition channel quality.
- **Inventory Alignment** – Sell-through and weeks of supply for priority SKUs / categories, focused on lagging regions.

## Design Principles
- Consistent color language (performance vs target).
- Clear hierarchy: summary → drill-through.
- Tooltips with definitions and last-refresh timestamp.
- Bookmarks for common views (e.g., “Underperforming Regions”, “High-ROAS Channels”).
- Row-level security by region for business users.

## Key DAX Patterns Used
- Time intelligence via dedicated Date table.
- DIVIDE for safe division (AOV, ROAS, retention rates).
- CALCULATE + FILTER for campaign attribution windows and cohort logic.
- Dynamic ranking of regions and campaigns.

## Refresh & Governance
- Hybrid import + DirectQuery where needed for performance.
- Scheduled daily refresh after source loads complete.
- Measure catalog and data dictionary linked in the workspace for users.

This structure supported both weekly leadership stand-ups and self-service exploration by merchandising and marketing analysts.
