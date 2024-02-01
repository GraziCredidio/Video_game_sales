# Global and Regional Video Game Sales Trends

# Table of Contents
- [Project Overview](#Project-Overview)
- [Data source](#Data-source)
- [Tools](#Tools)
- [Methodology](#Methodology)
- [Data Exploration](#Data-Exploration)
  - [General trends and quantities](##General-Trends-and-Quantities)


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

## General Trends and Quantities
- *Which genre had the most number of games released? Which had the least?*

Action games were the leader both in the number of games released (1930) and global sales (1739.4 million units sold), comprising almost 20% of the total sales. The genres of strategy and adventure released more games than Puzzle, and yet sold less. Some hypotheses can be formulated from that: the industry did not launch many puzzle games, but the ones on the market are quite popular, and/or adventure and strategy games are not so popular among gamers. 

![image](https://github.com/GraziCredidio/Video_game_sales/assets/104797916/d758c17d-a7cb-42c0-a054-c1468a6fe99a) ![image](https://github.com/GraziCredidio/Video_game_sales/assets/104797916/60ffe42f-4e0d-44b0-94ae-ae1023e65bb7)



- *Which year sold the most? Were the sales driven by the sole number of games released?*
  
The year 2008 had the highest global sales (with over 684 million units sold), however, 2009 was the year with the highest amount of games released (1438 games versus the 1435 games released in 2008). As one could expect, the year with the lowest number of games released and global sales was 1980 (not shown in the image below).

![image](https://github.com/GraziCredidio/Video_game_sales/assets/104797916/e618ba9a-73a4-4d29-b758-02042bb4350e) ![image](https://github.com/GraziCredidio/Video_game_sales/assets/104797916/b93323e0-eb90-4a65-b38e-4348dbfaac16)



