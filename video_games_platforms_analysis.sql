#### Which platforms have been globally successful?  ###
USE video_games;

-- Platforms that sold the most in each region
(SELECT 
    'Japan' AS region, platform_name, ROUND(SUM(jp_sales), 2) AS sales
FROM
    game_platform gp
        JOIN
    sales s ON gp.gp_id = s.gp_id
        LEFT JOIN
    platform p ON gp.platform_id = p.platform_id
GROUP BY platform_name
ORDER BY sales DESC
LIMIT 1)
UNION 
(SELECT 
    'NA' as region, platform_name, ROUND(SUM(na_sales), 2) AS sales
FROM
    game_platform gp
        JOIN
    sales s ON gp.gp_id = s.gp_id
        LEFT JOIN
     platform p ON gp.platform_id = p.platform_id
GROUP BY platform_name
ORDER BY sales DESC
LIMIT 1)
UNION
(SELECT 
    'EU' as region, platform_name, ROUND(SUM(eu_sales), 2) AS sales
FROM
    game_platform gp
        JOIN
    sales s ON gp.gp_id = s.gp_id
        LEFT JOIN
	platform p ON gp.platform_id = p.platform_id
GROUP BY platform_name
ORDER BY sales DESC
LIMIT 1);

-- Platforms that sold the most each year
WITH cte_plaform_year AS (
SELECT 
	a.year_of_release, 
    a.platform_name, 
    a.global_sales, 
    DENSE_RANK() OVER(PARTITION BY a.year_of_release ORDER BY a.global_sales DESC) as rank_sales
FROM (SELECT 
			MAX(gp.year_of_release) as year_of_release, 
			p.platform_name, 
			SUM(s.global_sales) as global_sales
	  FROM
			game_platform gp
        JOIN
			sales s ON gp.sale_id = s.sale_id
        LEFT JOIN
			platform p ON gp.platform_id = p.platform_id
      GROUP BY gp.year_of_release , p.platform_name
      ORDER BY gp.year_of_release) a)
SELECT 
	c.year_of_release,
    c.platform_name,
    c.global_sales
FROM cte_plaform_year c
WHERE c.rank_sales = 1;

-- Contribution of top 10 platforms to total global sales
SELECT 
    platform_name,
    SUM(global_sales) AS sales,
    CONCAT(ROUND((SUM(global_sales) / (SELECT SUM(global_sales) FROM sales)) * 100, 2), '%') AS percent_sales
FROM
    game_platform gp
        JOIN
    sales s ON gp.sale_id = s.sale_id
        LEFT JOIN
    platform p ON gp.platform_id = p.platform_id
GROUP BY platform_name
ORDER BY sales DESC
LIMIT 10;
