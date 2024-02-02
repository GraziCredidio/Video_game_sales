# Global and Regional Video Game Sales Trends

# Table of Contents
- [Project Overview](#Project-Overview)
- [Data source](#Data-source)
- [Tools](#Tools)
- [Methodology](#Methodology)
- [Data Exploration](#Data-Exploration)
  - [General Trends](##General-Trends-and-Quantities)
  - [The Most Popular Games Around the Globe](##The-Most-Popular-Games-Around-the-Globe)


# Project Overview
This analysis aimed to explore in-depth the dynamic world of video games, specifically to compare global and regional sales trends of games released from 1980 to 2016. Which publishers are behind the most successful games in each region, what are the most popular genres, which games sold the most each year, and how do the consumer habits of North Americans, Japanese and Europeans differ when choosing platforms and genders to play are examples of some of the questions approached by this project. SQL was used to construct a database and perform explorative queries, that were further gathered into an interactive dashboard using Tableau. 


# Data source
The original dataset can be found on [Kaggle](https://www.kaggle.com/datasets/thedevastator/video-game-sales-and-ratings). The original dataset comprises over 16900 recordings of game-platform pairs (e.g. for each platform a game "X" was released, there would be a row for "x"-platform pair). This detailed dataset comprises over 16000 recordings of game names, platforms, ratings, year of release, publisher, genre, sales data (global and regional), and scores by critics and users.  


# Tools
- Microsoft Excel: initial data cleaning and manipulation
- SQL: database design, data cleaning, and exploration
- Tableau: visualization and dashboard construction

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
- *Which game genre sold the most?*

Action games were the leader both in the number of games released (3346) and global sales (1739.4 million units sold), comprising almost 20% of the total sales. The genres of strategy and adventure released more games than Puzzle, and yet sold less. Some hypotheses can be formulated from that: the industry did not launch many puzzle games, but the ones on the market are quite popular, and/or adventure and strategy games are not as popular among gamers. 


![image](https://github.com/GraziCredidio/Video_game_sales/assets/104797916/63553b53-563d-477e-abdf-4594a9c91b51) ![image](https://github.com/GraziCredidio/Video_game_sales/assets/104797916/e733ff25-d500-493f-9ff5-a9b5652dfff0)



- *Which year sold the most? Were the sales driven by the sole number of games released or due to more successful games?*
  
The year 2008 had the highest global sales (with over 684 million units sold), however, 2009 was the year with the highest amount of games released (1438 games in 2009 versus the 1435 games in 2008). It seems that, despite being lower in number, the games launched in 2008 were more popular than the ones released in 2009. Another hypothesis is that 


As one could expect, the year with the lowest number of games released and global sales was 1980 (not shown in the image).

![image](https://github.com/GraziCredidio/Video_game_sales/assets/104797916/e618ba9a-73a4-4d29-b758-02042bb4350e) ![image](https://github.com/GraziCredidio/Video_game_sales/assets/104797916/b93323e0-eb90-4a65-b38e-4348dbfaac16)



- *What are the platforms that had the most successful games (in terms of global copies sold)?*
  
PlayStation 2 (PS2) was the platform that sold the most and publishers released more games too. By taking the proportion of sales relative to the number of games released, it is possible to roughly estimate how much each game of that platform sold (considering that the games sold the same amount equally). This demonstrates how popular, in general, the games of a specific platform were. Using this metric, the platform with the highest proportional number of copies of games sold was the GameBoy (GB), in which each game released for this platform sold approximately 2.7 million copies.

![image](https://github.com/GraziCredidio/Video_game_sales/assets/104797916/a47f4979-3481-45ac-b93f-fde139f4c194) ![image](https://github.com/GraziCredidio/Video_game_sales/assets/104797916/0c4a905a-a819-48e1-bf94-3fb6aa183c6d)


## The Most Popular Games Around the Globe
- *The top 10 games that sold the most from 1980 to 2016* 

![image](https://github.com/GraziCredidio/Video_game_sales/assets/104797916/d7264483-6767-452a-9b8c-81279c825970)

