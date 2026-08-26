# Executive Summary

## Situation
A national apparel retailer faced slowing regional revenue growth and rising marketing costs without a unified, timely view of performance drivers. Reporting lagged and required significant manual effort.

## Approach
Integrated POS, CRM, campaign, and inventory data into a governed star schema. Built SQL transformation and quality layer, then delivered a Power BI workspace with executive and operational views. Focused on regional performance, campaign attribution (7-day window), retention cohorts, and inventory alignment for high-margin SKUs.

## Key Findings
- Three regions accounted for the majority of the revenue shortfall; primary drivers were lower AOV and weaker repeat purchase rates rather than foot traffic alone.
- Paid social delivered strong ROAS in urban formats but underperformed in suburban stores; email remained consistently efficient across regions.
- Loyalty-acquired customers showed materially higher 90-day retention than pure digital acquisition cohorts.
- High contribution-margin SKUs were under-indexed in inventory investment in lagging regions.

## Recommendations
1. Reallocate a portion of paid social budget toward proven high-ROAS email and loyalty segments in underperforming regions.
2. Adjust open-to-buy and safety stock for top contribution-margin SKUs in the three lagging regions.
3. Apply simple RFM-based targeting rules for upcoming campaign waves.
4. Replace ad-hoc Excel packs with a standing weekly performance review using the new dashboard.

## Impact (Pilot Window)
- ~40% reduction in manual reporting effort
- Reporting cycle time reduced to next business day
- Improved data reliability through automated reconciliation
- Direct use by merchandising and marketing for budget and assortment decisions

Full technical documentation, SQL logic, and measure definitions are available in this repository.
