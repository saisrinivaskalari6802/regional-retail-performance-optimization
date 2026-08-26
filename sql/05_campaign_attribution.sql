-- 05_campaign_attribution.sql
-- Campaign performance with simple attributed ROAS.
-- Attribution window: 7-day post-click (applied upstream in source or staging).

SELECT
    c.campaign_id,
    c.channel,
    DATE_TRUNC('week', c.activity_date) AS week_start,
    SUM(c.spend) AS total_spend,
    SUM(c.impressions) AS impressions,
    SUM(c.clicks) AS clicks,
    SUM(c.attributed_revenue) AS attributed_revenue,
    SUM(c.attributed_revenue) * 1.0 / NULLIF(SUM(c.spend), 0) AS roas,
    SUM(c.clicks) * 1.0 / NULLIF(SUM(c.impressions), 0) AS ctr
FROM analytics.fact_campaign c
GROUP BY 1, 2, 3
ORDER BY week_start DESC, total_spend DESC;

-- Channel-level summary for executive view
SELECT
    channel,
    SUM(spend) AS spend,
    SUM(attributed_revenue) AS attributed_revenue,
    SUM(attributed_revenue) * 1.0 / NULLIF(SUM(spend), 0) AS roas
FROM analytics.fact_campaign
GROUP BY 1
ORDER BY roas DESC;
