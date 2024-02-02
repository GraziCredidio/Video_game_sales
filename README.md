# Global and Regional Video Game Sales Trends

# Table of Contents
- [Project Overview](#Project-Overview)
- [Data source](#Data-source)
- [Tools](#Tools)
- [Methodology](#Methodology)
- [Data Exploration](#Data-Exploration)
  - [General Trends](##General-Trends-and-Quantities)
  - [Market Segmentation](##Market-Segmentation)


# Project Overview
This analysis aimed to explore in-depth the dynamic world of video games, specifically to compare global and regional sales trends of games released from 1980 to 2016. Which publishers are behind the most successful games in each region, what are the most popular genres, which games sold the most each year, and how do the consumer habits of North Americans, Japanese and Europeans differ when choosing platforms and genders to play are examples of some of the questions approached by this project. SQL was used to construct a database and perform explorative queries, that were further gathered into an interactive dashboard using Tableau. 


# Data source
The original dataset can be found on [Kaggle](https://www.kaggle.com/datasets/thedevastator/video-game-sales-and-ratings). The original dataset comprises over 16900 recordings of game-platform pairs (e.g. for each platform a game "X" was released, there would be a row for "x"-platform pair). This detailed dataset comprises over 16000 recordings of game names, platforms, ratings, year of release, publisher, genre, sales data (global and regional), and scores by critics and users.  


# Tools
- Microsoft Excel: initial data cleaning and manipulation
- SQL: database design, data cleaning, and exploration
- Tableau: visualization and [dashboard](https://public.tableau.com/app/profile/graziella.credidio/viz/Videogames_17056915247530/Dashboard) construction

# Methodology 
## Data cleaning
The dataset was retrieved in 2020, however, due to the low number of recordings for the years 2017 onwards, these were not considered in the present analysis. Games with blank names (2) were excluded and blank release years (273) were manually inputted according to publicly available information. Cells with "unknown" were replaced by blank cells and all records were trimmed. Games with "JP sales", "EU sales" or "NA sales" in their titles were properly merged into the corresponding entries and those with "weekly sales" or "old sales" were excluded. Duplicate recordings (same name, platform and publisher) were excluded (211). A total of 16581 recordings were kept for further exploratory analysis and visualizations.  
  
## Database design
A relational database was designed (as in the schema below) following normalization rules. All tables are connected to the central table "game-platform", in which the game and publisher tables have a one-to-many relationship, while the others have a one-to-one relationship with it. 
The DDL employed can be found in the file "video_games_database_design".

![Database_design](https://github.com/GraziCredidio/Video_game_sales/assets/104797916/c1b714ab-20af-4d90-9a24-ed35026d617a)

# Data Exploration
A series of SQL queries were carried out and data exploration was split into 5 main blocks: 
- General trends and quantities
- Globally successful games
- Most popular platforms
- Regional market trends
- Publishers behind the most successful games

## General Trends

An initial exploration of global numbers.

- *Which genre sold the most?*

Action games were the leader both in the number of games released (3346) and global sales (1739.4 million units sold), comprising almost 20% of the total sales. The genres of strategy and adventure released more games than Puzzle, and yet sold less. Some hypotheses can be formulated from that: the industry did not launch many puzzle games, but the ones on the market are quite popular, and/or adventure and strategy games are not as popular among gamers. 

 ![image](https://github.com/GraziCredidio/Video_game_sales/assets/104797916/e733ff25-d500-493f-9ff5-a9b5652dfff0) ![image](https://github.com/GraziCredidio/Video_game_sales/assets/104797916/63553b53-563d-477e-abdf-4594a9c91b51)



- *Which year sold the most?*
  
The year 2008 had the highest global sales (with over 684 million units sold), however, 2009 was the year with the highest amount of games released (1438 games in 2009 versus the 1435 games in 2008). It seems that, despite being lower in number, the games launched in 2008 were more popular than the ones released in 2009. As one could expect, the year with the lowest number of games released and global sales was 1980 (not shown in the image).

![image](https://github.com/GraziCredidio/Video_game_sales/assets/104797916/e618ba9a-73a4-4d29-b758-02042bb4350e) ![image](https://github.com/GraziCredidio/Video_game_sales/assets/104797916/b93323e0-eb90-4a65-b38e-4348dbfaac16)



- *Which platforms had the most successful games?*
  
PlayStation 2 (PS2) was the platform that sold the most and publishers released more games too. By taking the proportion of sales relative to the number of games released, it is possible to roughly estimate how much each game of that platform sold (considering that the games sold the same amount equally). This demonstrates how popular, in general, the games of a specific platform were. Using this metric, the platform with the highest proportional number of copies of games sold was the GameBoy (GB), in which each game released for this platform sold approximately 2.7 million copies.

![image](https://github.com/GraziCredidio/Video_game_sales/assets/104797916/a47f4979-3481-45ac-b93f-fde139f4c194) ![image](https://github.com/GraziCredidio/Video_game_sales/assets/104797916/0c4a905a-a819-48e1-bf94-3fb6aa183c6d)



## Market segmentation

Investigating how different the preferences for games and genres are in each region and the need for market segmentation in the games industry.


- *Top 10 games: global versus regional successes and contribution of regions to global sales*
  
The query below outputs the top 10 games in terms of global sales and the level of popularity of these games in each region. This way, it becomes clear that while some games are very appreciated in some regions, they are not so popular in others. An example is "Grand Theft Auto V", which is the 2nd most purchased game in Europe and 5th in North America, but it is only in the 113th position in Japan. The Call of Duty franchise does not seem to be very popular among Japanese too. On the other hand, Pokemon Red/Blue is the top 1 game in Japan but comes in 22nd place in NA and 18th in Europe. 

Another important observation is that 7 of the top 10 games were published by Nintendo, showcasing how prominent the company is in the field of games.

Only two games (Pokemon Red/Blue and New Super Mario Bros.) did not have a clear dominance of one or two regions over the other(s). In general, the North American market contributed the most to the sales of all top 10 games. However, it is unclear whether this phenomenon is simply because of a higher population (consequently, more people buying), due to differences in culture, purchasing power, or even the socioeconomic context of these major regions by the time the games were released. 


![image](https://github.com/GraziCredidio/Video_game_sales/assets/104797916/88944398-f90a-4c1e-a8cc-4ffc47e79233) ![image](https://github.com/GraziCredidio/Video_game_sales/assets/104797916/e6e676bd-8882-472d-8580-578f79c252da)


- *Genre preferences*
  
As shown before, it seemed obvious that North America, Europe and Japan have different tastes in terms of games and game genres. Indeed, Role-Playing games are very popular among Japanese, while Action games are the preference among Westerners (Europeans and North Americans). 

![image](https://github.com/GraziCredidio/Video_game_sales/assets/104797916/cdc328bd-5ab9-415a-b481-b2d0c80ea70b) 
![image](https://github.com/GraziCredidio/Video_game_sales/assets/104797916/9c198500-044c-43f8-b54a-c77866e59795)



- *Most acclaimed games by the critics and users*
