-- Q2: Revenue concentration by customer

SELECT
    c.customer_id,
    c.customer_name,                
    COUNT(l.load_id) AS total_loads,
    SUM(l.revenue) AS total_revenue,
    ROUND(SUM(l.revenue) * 100.0 / SUM(SUM(l.revenue)) OVER (), 2) AS pct_of_total_revenue
FROM customers c
JOIN loads l ON l.customer_id = c.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_revenue DESC;