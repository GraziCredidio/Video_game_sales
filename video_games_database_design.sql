### Database design ###
USE video_games;

## Original data (single table) ##
-- Duplicates identification (unique combinations of name + platform + year of release)
SELECT 
    game_name,
    platform,
    year_of_release,
    COUNT(game_name) AS duplicates
FROM
    video_games_dup 
WHERE year_of_release BETWEEN 1980 AND 2016
GROUP BY game_name , platform , year_of_release
HAVING duplicates > 1
ORDER BY game_name; #207 records 

-- Duplicates deletion: Creating an intermediate table with unique records
DROP TABLE IF EXISTS video_games;
CREATE TABLE video_games LIKE video_games_dup;
INSERT INTO video_games SELECT DISTINCT * FROM video_games_dup WHERE year_of_release BETWEEN 1980 AND 2016;  

-- Creating PK gp_id 
ALTER TABLE video_games
ADD COLUMN gp_id INT;

ALTER TABLE video_games
MODIFY COLUMN gp_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT FIRST;
-- select * from video_games; #16581 rows


## Creation of relational data with multiple tables connected ##
-- GAME TABLE
DROP TABLE IF EXISTS game;
CREATE TABLE game (
game_name VARCHAR(255),
genre VARCHAR(50),
rating VARCHAR(50)
);

INSERT INTO game
SELECT DISTINCT game_name, min(genre), min(rating) FROM video_games GROUP BY game_name;
 
ALTER TABLE game
ADD COLUMN game_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT FIRST;
-- select * from game; -- 11424 recordings


-- PLATFORM TABLE
DROP TABLE IF EXISTS platform;
CREATE TABLE platform (
platform_name VARCHAR(50),
UNIQUE KEY (platform_name)
);

INSERT INTO platform (platform_name)
SELECT DISTINCT platform FROM video_games;

ALTER TABLE platform
ADD COLUMN platform_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT FIRST;
-- select * from platform; -- 31 recordings


-- SALES TABLE
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (
gp_id INT UNSIGNED,
na_sales NUMERIC(10,2),
eu_sales NUMERIC(10,2),
jp_sales NUMERIC(10,2),
other_sales NUMERIC(10,2),
global_sales NUMERIC(10,2),
UNIQUE KEY (gp_id)
);

INSERT INTO sales
SELECT gp_id, na_sales_million, eu_sales_million, jp_sales_million, other_sales_million, global_sales_million FROM video_games WHERE year_of_release BETWEEN 1980 AND 2016;

ALTER TABLE sales
ADD COLUMN sale_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT FIRST;
-- select * from sales; -- 16581 recordigns


-- REVIEW TABLE
DROP TABLE IF EXISTS review;
CREATE TABLE review (
gp_id INT UNSIGNED,
critic_score NUMERIC(10,2),
critic_count INT,
user_score NUMERIC(10,2),
user_count INT,
UNIQUE KEY (gp_id)
);

INSERT INTO review
SELECT gp_id, critic_score, critic_count, user_score, user_count FROM video_games;

ALTER TABLE review
ADD COLUMN review_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT FIRST;
-- select * from review; -- 16581 recordigns


-- PUBLISHER TABLE
DROP TABLE IF EXISTS publisher;
CREATE TABLE publisher (
publisher VARCHAR(100) NOT NULL,
UNIQUE KEY (publisher)
);

INSERT INTO publisher
SELECT DISTINCT TRIM(publisher) FROM video_games WHERE publisher <> '';

ALTER TABLE publisher
ADD COLUMN publisher_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT FIRST;
-- select * from publisher; -- 578 rows

-- GAME-PLATFORM TABLE
DROP TABLE IF EXISTS game_platform;
CREATE TABLE game_platform (
gp_id INT UNSIGNED AUTO_INCREMENT,
game_id INT UNSIGNED,
platform_id INT UNSIGNED,
sale_id INT UNSIGNED,
review_id INT UNSIGNED,
publisher_id INT UNSIGNED,
year_of_release YEAR,

PRIMARY KEY (gp_id),
FOREIGN KEY (game_id) REFERENCES game(game_id) ON DELETE CASCADE,
FOREIGN KEY (platform_id) REFERENCES platform(platform_id) ON DELETE CASCADE,
FOREIGN KEY (sale_id) REFERENCES sales(sale_id) ON DELETE CASCADE,
FOREIGN KEY (review_id) REFERENCES review(review_id) ON DELETE CASCADE,
FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id) ON DELETE CASCADE
);

INSERT INTO game_platform 
SELECT 
v.gp_id, 
g.game_id,
p.platform_id,
s.sale_id,
r.review_id,
pu.publisher_id,
v.year_of_release
FROM
    video_games v
		JOIN
    review r ON v.gp_id = r.gp_id
         JOIN
    sales s ON v.gp_id = s.gp_id        
		LEFT JOIN
    game g ON v.game_name = g.game_name
        LEFT JOIN
    platform p ON v.platform = p.platform_name
        LEFT JOIN
    publisher pu ON v.publisher = pu.publisher;

-- select * from game_platform; -- 16581 recordings


## Adding FK constraint (gp_id) to the sales and review tables ##
ALTER TABLE sales 
ADD FOREIGN KEY (gp_id) REFERENCES game_platform(gp_id) ON DELETE CASCADE;

ALTER TABLE review 
ADD FOREIGN KEY (gp_id) REFERENCES game_platform(gp_id) ON DELETE CASCADE;

## Dropping single tables (video_games and video_games_dup) ##
-- DROP TABLE video_games_dup;
-- DROP TABLE video_games;




/*
alter table sales
drop foreign key sales_ibfk_1;

alter table review
drop foreign key review_ibfk_1;
*/
