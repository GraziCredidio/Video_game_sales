### Which publishers are behind the most successful games in terms of sales and reviews? ###
USE video_games;

-- Publishers that released the highest amount of games 
SELECT 
    pu.publisher, COUNT(g.game_id) AS no_games_released
FROM
    game_platform gp
        LEFT JOIN
    game g ON gp.game_id = g.game_id
        LEFT JOIN
    publisher pu ON gp.publisher_id = pu.publisher_id
GROUP BY publisher
ORDER BY no_games_released DESC;

-- Publishers that sold the most and number of games released
SELECT 
    pu.publisher,
	COUNT(g.game_id) AS no_games_released,
    SUM(s.global_sales) AS global_sales,
    CONCAT(ROUND((SUM(s.na_sales)/SUM(global_sales))*100, 2), '%') AS na_sales,
    CONCAT(ROUND((SUM(s.eu_sales)/SUM(global_sales))*100, 2), '%') AS eu_sales,
    CONCAT(ROUND((SUM(s.jp_sales)/SUM(global_sales))*100, 2), '%') AS jp_sales  
FROM
    game_platform gp
        JOIN
    sales s ON gp.sale_id = s.sale_id
        LEFT JOIN
    game g ON gp.game_id = g.game_id
        LEFT JOIN
    publisher pu ON gp.publisher_id = pu.publisher_id
GROUP BY publisher
ORDER BY global_sales DESC , no_games_released DESC;

-- Top sellers of each publisher and how much they contributed to the total sales of the publishers
-- Identify if a publisher has the top game as main source of sales
WITH cte_top_sellers_publishers AS (
SELECT 
	a.publisher, 
    g.game_name, 
    a.publisher_global_sales, 
    s.global_sales AS game_global_sales,
    DENSE_RANK() OVER(PARTITION BY a.publisher ORDER BY s.global_sales DESC) AS sales_rank
FROM
		(SELECT
			pu.publisher_id,
			pu.publisher,
			SUM(s.global_sales) AS publisher_global_sales
		FROM
			game_platform gp
				JOIN
			sales s ON gp.sale_id = s.sale_id
				LEFT JOIN
			publisher pu ON gp.publisher_id = pu.publisher_id
		GROUP BY publisher) a
	RIGHT JOIN 
		game_platform gp ON gp.publisher_id = a.publisher_id
	LEFT JOIN 
		game g ON gp.game_id = g.game_id
	JOIN 
		sales s ON gp.sale_id = s.sale_id
WHERE a.publisher IS NOT NULL)
SELECT 
	c.publisher, 
    c.game_name, 
    c.publisher_global_sales, 
    c.game_global_sales, 
    ROUND(((c.game_global_sales / c.publisher_global_sales)*100), 1) AS percent_top_game_sales
FROM cte_top_sellers_publishers c
WHERE sales_rank = 1 
ORDER BY percent_top_game_sales;

-- How much from the total global sales the publishers are accountable?
SELECT 
    a.publisher,
    a.publisher_global_sales,
    CONCAT(ROUND((a.publisher_global_sales/(SELECT SUM(global_sales) FROM sales))*100, 2), '%') AS percent_from_total_global_sales
FROM
(SELECT
			pu.publisher_id,
			pu.publisher,
			SUM(s.global_sales) AS publisher_global_sales
		FROM
			game_platform gp
				JOIN
			sales s ON gp.sale_id = s.sale_id
				LEFT JOIN
			publisher pu ON gp.publisher_id = pu.publisher_id
		GROUP BY publisher) a
WHERE a.publisher IS NOT NULL OR a.publisher <> 'Unkown'
ORDER BY publisher_global_sales DESC;