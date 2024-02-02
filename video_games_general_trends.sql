### Exploring general trends and quantities ### 
USE video_games;

-- Qntity of games released per genre and genre that sold the most
SELECT 
    g.genre,
    COUNT(g.game_name) AS games_count,
    SUM(s.global_sales) AS global_sales
FROM
    sales s
        JOIN
    game_platform gp ON s.gp_id = gp.gp_id
        LEFT JOIN
    game g ON g.game_id = gp.game_id
GROUP BY g.genre
ORDER BY global_sales DESC , games_count DESC;

-- Global sales per year and number of games released
SELECT 
    gp.year_of_release as year,
    SUM(s.global_sales) AS global_sales,
    COUNT(g.game_name) AS games_num
FROM
    sales s
        JOIN
    game_platform gp ON s.gp_id = gp.gp_id
        LEFT JOIN
    game g ON g.game_id = gp.game_id
GROUP BY gp.year_of_release
ORDER BY global_sales DESC , games_num DESC;

-- Quantity of games released per platform and sales
SELECT 
    p.platform_name,
    COUNT(*) AS no_of_games,
    SUM(s.global_sales) AS global_sales,
     SUM(s.global_sales)/COUNT(*) as sale_per_game
FROM
    game_platform gp
        JOIN
    sales s ON gp.sale_id = s.sale_id
        LEFT JOIN
    platform p ON gp.platform_id = p.platform_id
GROUP BY platform_name
ORDER BY global_sales DESC , no_of_games DESC;




-- top seller of each year (global) 
WITH cte_top_sellers_years AS(
SELECT 
	a.year_of_release, 
    a.game_name, 
    a.global_sales, 
    DENSE_RANK() OVER(PARTITION BY a.year_of_release ORDER BY a.global_sales DESC) AS rank_sales
FROM (SELECT 
   MAX(gp.year_of_release) AS year_of_release,
   g.game_name, 
   SUM(s.global_sales) AS global_sales
FROM
    game_platform gp
        JOIN
    sales s ON gp.gp_id = s.gp_id
        LEFT JOIN
    game g ON gp.game_id = g.game_id
GROUP BY gp.year_of_release, g.game_name 
ORDER BY gp.year_of_release) a)
SELECT c.year_of_release, c.game_name, c.global_sales
FROM cte_top_sellers_years c
WHERE rank_sales = 1;

-- top seller of each genre
WITH cte_top_sellers_genre AS(
SELECT 
	a.genre, 
    a.game_name, 
    a.global_sales, 
    DENSE_RANK() OVER(PARTITION BY a.genre ORDER BY a.global_sales DESC) AS rank_sales
FROM (SELECT 
   MAX(g.genre) AS genre,
   g.game_name, 
   SUM(s.global_sales) AS global_sales
FROM
    game_platform gp
        JOIN
    sales s ON gp.gp_id = s.gp_id
        LEFT JOIN
    game g ON gp.game_id = g.game_id
GROUP BY g.genre, g.game_name 
ORDER BY g.genre) a)
SELECT c.genre, c.game_name, c.global_sales
FROM cte_top_sellers_genre c
WHERE rank_sales = 1;

-- Top genre of each year
WITH cte_top_genre_years AS(
SELECT 
	a.year_of_release, 
    a.genre, 
    a.global_sales, 
    DENSE_RANK() OVER(PARTITION BY a.year_of_release ORDER BY a.global_sales DESC) AS rank_sales
FROM (SELECT 
   MAX(gp.year_of_release) AS year_of_release,
   g.genre, 
   SUM(s.global_sales) AS global_sales
FROM
    game_platform gp
        JOIN
    sales s ON gp.gp_id = s.gp_id
        LEFT JOIN
    game g ON gp.game_id = g.game_id
GROUP BY gp.year_of_release, g.genre 
ORDER BY gp.year_of_release) a)
SELECT c.year_of_release, c.genre, c.global_sales
FROM cte_top_genre_years c
WHERE rank_sales = 1;

-- Genres that sold the most (percentage)
SELECT 
    g.genre, 
    COUNT(g.game_name) AS games_count,
    SUM(s.global_sales) AS global_sales, 
    CONCAT(ROUND((SUM(s.global_sales)/(SELECT SUM(global_sales) FROM sales))*100,2), '%') AS percent_global_sales
FROM
    game_platform gp
        JOIN
    sales s ON gp.sale_id = s.sale_id
        JOIN
    game g ON gp.game_id = g.game_id
GROUP BY g.genre
ORDER BY global_sales DESC;

-- Most acclaimed games (critic score) from each genre
WITH cte_top_critic_genre AS (
SELECT 
	a.genre, 
    a.game_name, 
    a.year_of_release, 
	DENSE_RANK() OVER (PARTITION BY a.genre ORDER BY a.avg_critic_score DESC, a.no_critic_reviews DESC) as rank_critic,
	a.avg_critic_score,
    a.no_critic_reviews,
    a.avg_user_score,
    a.no_user_reviews
FROM (SELECT 
		g.genre,
		g.game_name,
		MAX(gp.year_of_release) AS year_of_release,
		ROUND(AVG(r.critic_score), 1) AS avg_critic_score,
        SUM(r.critic_count) AS no_critic_reviews,
        ROUND(AVG(r.user_score), 1) AS avg_user_score,
        SUM(r.user_count) AS no_user_reviews
	FROM
		game_platform gp
        JOIN
            review r ON gp.gp_id = r.gp_id
        LEFT JOIN
    game g ON gp.game_id = g.game_id
	WHERE r.critic_score <> 0
	GROUP BY g.genre, g.game_name) a)
SELECT 
    c.genre,
    c.game_name,
    c.year_of_release,
    c.avg_critic_score,
    c.no_critic_reviews,
    c.avg_user_score,
    c.no_user_reviews
FROM
    cte_top_critic_genre c
WHERE
    rank_critic = 1;

-- Most acclaimed games (users scores) from each genre
WITH cte_top_user_genre AS (
SELECT 
	a.genre, 
    a.game_name, 
    a.year_of_release, 
	DENSE_RANK() OVER (PARTITION BY a.genre ORDER BY a.avg_user_score DESC, a.no_user_reviews DESC) as rank_critic, #in case of ties, take the one with most reviews
	a.avg_user_score,
    a.no_user_reviews,
    a.avg_critic_score,
    a.no_critic_reviews
FROM (SELECT 
		g.genre,
		g.game_name,
		MAX(gp.year_of_release) AS year_of_release,
		ROUND(AVG(r.user_score), 1) AS avg_user_score,
        SUM(r.user_count) AS no_user_reviews,
        ROUND(AVG(r.critic_score), 1) AS avg_critic_score,
        SUM(r.critic_count) AS no_critic_reviews
	FROM
		game_platform gp
        JOIN
            review r ON gp.gp_id = r.gp_id
        LEFT JOIN
    game g ON gp.game_id = g.game_id
	WHERE r.user_score <> 0
	GROUP BY g.genre, g.game_name) a)
SELECT c.genre, c.game_name, c.year_of_release, c.avg_user_score, c.no_user_reviews, c.avg_critic_score, c.no_critic_reviews
FROM cte_top_user_genre c
WHERE rank_critic = 1;