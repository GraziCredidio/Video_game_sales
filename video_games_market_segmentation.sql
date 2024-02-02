### Market Segmentation ###
USE video_games;

-- Top 20 sellers of all times (game)
SELECT 
    g.game_name, 
    SUM(s.global_sales) AS global_sales
FROM
    game_platform gp
        JOIN
    sales s ON gp.gp_id = s.gp_id
        LEFT JOIN
    game g ON gp.game_id = g.game_id
GROUP BY g.game_name
ORDER BY global_sales DESC
LIMIT 10;

-- Top 10 global vs the rank of the game in each region
SELECT 
    a.game_name, 
    a.publisher,
    a.genre,
    DENSE_RANK() OVER(ORDER BY a.na_sales DESC) as rank_na,
    DENSE_RANK() OVER(ORDER BY a.eu_sales DESC) as rank_eu,
    DENSE_RANK() OVER(ORDER BY a.jp_sales DESC) as rank_jp,
	a.global_sales,
	CONCAT(ROUND(a.na_sales / a.global_sales *100, 2), '%') AS perc_na_sales,
    CONCAT(ROUND(a.eu_sales / a.global_sales *100, 2), '%') AS perc_eu_sales,
    CONCAT(ROUND(a.jp_sales / a.global_sales *100, 2), '%') AS perc_jp_sales
FROM (SELECT g.game_name, 
	g.genre,
    pu.publisher,
    SUM(s.global_sales) AS global_sales,
    SUM(s.na_sales) AS na_sales,
	SUM(s.eu_sales) AS eu_sales,
	SUM(s.jp_sales) AS jp_sales
    FROM
    game_platform gp
        JOIN
    sales s ON gp.gp_id = s.gp_id
        LEFT JOIN
    game g ON gp.game_id = g.game_id
		LEFT JOIN
	publisher pu ON gp.publisher_id = pu.publisher_id
GROUP BY g.game_name, g.genre, pu.publisher) a
ORDER BY global_sales DESC
LIMIT 10;

###  Regional market trends (EU, NA, JP sales) in terms of genres and platforms ###
-- amount sold by each region 
SELECT 
    SUM(na_sales) AS na_sales,
    SUM(eu_sales) AS eu_sales,
    SUM(jp_sales) AS jp_sales,
    SUM(other_sales) AS other_sales,
    SUM(global_sales) AS global_sales
FROM
    sales s;

-- percentage of contribution of each region on global sales (all times)
SELECT 
    ROUND((SUM(na_sales) / SUM(global_sales)), 2) * 100 AS na_sales_percent,
    ROUND((SUM(eu_sales) / SUM(global_sales)), 2) * 100 AS eu_sales_percent,
    ROUND((SUM(jp_sales) / SUM(global_sales)), 2) * 100 AS jp_sales_percent,
    ROUND((SUM(other_sales) / SUM(global_sales)),
            2) * 100 AS other_sales_percent,
    TRUNCATE((SUM(global_sales) / SUM(global_sales)),
		2) * 100 AS global_sales_percent,
	ROUND(SUM(na_sales), 2) AS na_sales,
    ROUND(SUM(eu_sales), 2) AS eu_sales,
    ROUND(SUM(jp_sales), 2) AS jp_sales,
    ROUND(SUM(other_sales), 2) AS jp_sales,
    ROUND(SUM(global_sales), 2) AS global_sales
FROM
    sales;
    
# top 20 sellers of each region (NA, JP, EU, Others)
SET @region_sales = 'other_sales'; -- Change accordingly
SET @q = CONCAT('SELECT game_name, SUM(', @region_sales, ') as sales 
				FROM sales s
						JOIN
					game_platform gp ON gp.gp_id = s.gp_id
						LEFT JOIN
					game g ON gp.game_id = g.game_id
				GROUP BY game_name
				ORDER BY sales DESC
				LIMIT 20;');
PREPARE stmt1 FROM @q;
EXECUTE stmt1;

-- Most popular genres of each region (sales)
(SELECT 
    'Japan' AS region, genre, ROUND(SUM(jp_sales), 2) AS sales
FROM
    game_platform gp
        JOIN
    sales s ON gp.gp_id = s.gp_id
        LEFT JOIN
    game g ON gp.game_id = g.game_id
GROUP BY g.genre
ORDER BY sales DESC
LIMIT 1)
UNION 
(SELECT 
    'NA' as region, genre, ROUND(SUM(na_sales), 2) AS sales
FROM
    game_platform gp
        JOIN
    sales s ON gp.gp_id = s.gp_id
        LEFT JOIN
    game g ON gp.game_id = g.game_id
GROUP BY genre
ORDER BY sales DESC
LIMIT 1)
UNION
(SELECT 
    'EU' as region, genre, ROUND(SUM(eu_sales), 2) AS sales
FROM
    game_platform gp
        JOIN
    sales s ON gp.gp_id = s.gp_id
        LEFT JOIN
    game g ON gp.game_id = g.game_id
GROUP BY genre
ORDER BY sales DESC
LIMIT 1);
