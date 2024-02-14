![Alicia-VideoGames-1480](https://github.com/GraziCredidio/Video_game_sales/assets/104797916/c5a33241-5de4-48b1-b5c1-89609874b1b9)

# Table of Contents
- [Project Overview](#Project-Overview)
- [Data source](#Data-source)
- [Tools](#Tools)
- [Methodology](#Methodology)
- [Key Findings](#Key-Findings)
  - [General Trends](##General-Trends-and-Quantities)
  - [Market Segmentation](##Market-Segmentation)
  - [Publishers behind the most successful games](##Publishers-behind-the-most-successful-games)
- [Final Thoughts](#Final-Thoughts)

# Project Overview
This analysis aimed to explore in-depth the dynamic world of video games, specifically to compare global and regional sales trends of games released from 1980 to 2016. Which publishers are behind the most successful games in each region, what are the most popular genres, which games sold the most each year, and how do the consumer habits of North Americans, Japanese and Europeans differ when choosing platforms and genders to play are examples of some of the questions approached by this project. SQL was used to construct a database and perform explorative queries, that were further gathered into an interactive dashboard using Tableau. 


# Data source
The original dataset can be found on [Kaggle](https://www.kaggle.com/datasets/thedevastator/video-game-sales-and-ratings). The original dataset comprises over 16900 recordings of game-platform pairs (e.g. for each platform a game "X" was released, there would be a row for "x"-platform pair). This detailed dataset comprises over 16000 recordings of game names, platforms, ratings, year of release, publisher, genre, sales data (global and regional), and scores by critics and users.  


# Tools
- Microsoft Excel: initial data cleaning and manipulation
- SQL: database design, data cleaning, and exploration
- Tableau: visualization and dashboard construction. *Click [here](https://public.tableau.com/app/profile/graziella.credidio/viz/Videogames_17056915247530/Dashboard) to access this content.*

# Methodology 
## Data cleaning
The dataset was retrieved in 2020, however, due to the low number of recordings for the years 2017 onwards, these were not considered in the present analysis. Games with blank names (2) were excluded and blank release years (273) were manually inputted according to publicly available information. Cells with "unknown" were replaced by blank cells and all records were trimmed. Games with "JP sales", "EU sales" or "NA sales" in their titles were properly merged into the corresponding entries and those with "weekly sales" or "old sales" were excluded. Duplicate recordings (same name, platform and publisher) were excluded (211). A total of 16581 recordings were kept for further exploratory analysis and visualizations. The cleaned data used for this project can be found in the "Video_Games_Modified.csv" file.  
  
## Database design
A relational database was designed (as in the schema below) following normalization rules. All tables are connected to the central table "game-platform", in which the game and publisher tables have a one-to-many relationship, while the others have a one-to-one relationship with it. 
The DDL employed can be found in the file "video_games_database_design".

![Database_design](https://github.com/GraziCredidio/Video_game_sales/assets/104797916/c1b714ab-20af-4d90-9a24-ed35026d617a)

## Exploratory analysis
SQL (MySQL) was used to explore trends and generate insights into the video games industry. The main topics addressed in this project were general trends, market segmentation and leading game publishers, however, it was not limited to these. 

## Dashboard construction
A reconstruction of the relational database was made inside Tableau by importing and joining the tables from the database. Some key findings were chosen to be displayed. Interactive plots were generated and a preview of the [dashboard](https://public.tableau.com/app/profile/graziella.credidio/viz/Videogames_17056915247530/Dashboard) can be seen below: 

*By clicking on the image you will be able to view and interact with the dashboard functionalities*
[![Dashboard](https://github.com/GraziCredidio/Video_game_sales/assets/104797916/d2636c80-6371-4ea4-954f-43de28e4d316)](https://public.tableau.com/app/profile/graziella.credidio/viz/Videogames_17056915247530/Dashboard)



# Key Findings 
A series of SQL queries were carried out and data exploration was split into 3 main blocks: 
- General trends and quantities
- Market segmentation
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

Investigating how different the preferences for games, genres and platforms are in each region and the need for market segmentation in the games industry.

- *What are the preferred platforms in each region?*

Interestingly, the preferred platforms of each region belong to different manufacturers. The Japanese seem to be huge fans of the portable console Nintendo DS, while Microsoft was very successful in North America with the Xbox 360 and Sony in Europe with the PlayStation 2. Many factors may have contributed to this discrepancy, such as directed marketing campaigns, exclusive games of each platform, final price, availability of customer support, regional special offers etc. 

  ![image](https://github.com/GraziCredidio/Video_game_sales/assets/104797916/f5358b34-3747-4a62-8d9c-5877bf69f62f) ![image](https://github.com/GraziCredidio/Video_game_sales/assets/104797916/f7409a9c-5183-438b-8af3-f6a6d17d2ecc)



- *Genre preferences*
  
North America, Europe and Japan have different tastes in terms of games and game genres. For example, role-playing games are very popular among Japanese, while Action games are the preference among Westerners (Europeans and North Americans).

![image](https://github.com/GraziCredidio/Video_game_sales/assets/104797916/cdc328bd-5ab9-415a-b481-b2d0c80ea70b) 
![image](https://github.com/GraziCredidio/Video_game_sales/assets/104797916/9c198500-044c-43f8-b54a-c77866e59795)



- *Top 10 games: global versus regional successes and contribution of regions to global sales*
  
To further investigate regional differences, the query below outputs the top 10 games in terms of global sales, their publishers, genres, their popularity in each region and the contribution of these regions to global sales. 

Out of the 12 existing genres (in this dataset), 7 had games among the 10 top sellers. No game belonging to the genres adventure, fighting, miscellaneous, simulation and strategy is on the top 10 best sellers. A sales pattern seems to be in place: shooter and action games are not popular in Japan, while they are well-accepted in North America and Europe. This way, it becomes clear that while some games are very appreciated in some regions, they are not so popular in others. An example is "Grand Theft Auto V", which is the 2nd most purchased game in Europe and 5th in North America, but it is only in the 113th position in Japan. The Call of Duty franchise does not seem to be very popular among Japanese too. On the other hand, Pokemon Red/Blue is the top 1 game in Japan but comes in 22nd place in NA and 18th in Europe. 

Another important observation is that 7 of the top 10 games were published by Nintendo, showcasing how prominent the company is in the field of games.

Only two games (Pokemon Red/Blue and New Super Mario Bros.) did not have a clear dominance of one or two regions over the other(s). In general, the North American market contributed the most to the sales of all top 10 games. However, it is unclear whether this phenomenon is simply because of a higher population (consequently, more people buying), due to differences in culture, purchasing power, or even the socioeconomic context of these major regions by the time the games were released. 


![image](https://github.com/GraziCredidio/Video_game_sales/assets/104797916/88944398-f90a-4c1e-a8cc-4ffc47e79233) ![image](https://github.com/GraziCredidio/Video_game_sales/assets/104797916/e6e676bd-8882-472d-8580-578f79c252da)


## Publishers behind the most successful games 
- *Companies that sold the most, the number of games they released, and their regional market share*

As suspected, Nintendo is the leader in the number of copies sold globally given their prominent role in the top 10 games analysis made previously. However, surprisingly, the number of games published by Nintendo is almost half (approx. 52%) of the second place (Electronic Arts - EA). This indicates that, although Nintendo releases fewer games, they are very popular, while EA may have published games that did not perform well. In addition, among the top 10 publishers, while Europe was not the leader in sales for any of the publishers, Japan was responsible for over 50% of the sales of Namco Bandai Games. The other publishers show a stronger presence in the North American market. The European market seems to behave similarly to the North American in general, with some exceptions like Nintendo, Sega, and Capcom. However, some companies have their sales spread across the globe in a fairly equal proportion (e.g.: Konami Digital Entertainment)


![image](https://github.com/GraziCredidio/Video_game_sales/assets/104797916/a8da10cf-ac52-4d25-a85e-29b95c41894c) ![image](https://github.com/GraziCredidio/Video_game_sales/assets/104797916/976ae493-a108-429d-8e2a-364a8dd25501)

- *Identifying publishers that may rely on their "one-hit wonder"*

Some companies may have their revenue relying mostly upon a single release. It is possible to investigate this matter by analyzing how much of a publisher's sales come from their top-seller game. This may indicate different strategies across publishers. For example, Electronic Arts seems to invest in publishing a high number of games, even though the sales performance of each title is not a prominent portion of their revenue. On the other hand, Nintendo releases fewer games, however, they are enough to put the company in the first place in sales. No matter the strategy a company adopts, having the revenue coming mostly from a single source is risky. A total of 194 publishers (out of 609) have more than 90% of their sales coming from one game, which may indicate that the games industry is highly competitive.


![image](https://github.com/GraziCredidio/Video_game_sales/assets/104797916/6647ebcc-31fd-450c-9393-ff32c1a82525) ![image](https://github.com/GraziCredidio/Video_game_sales/assets/104797916/a84b6a3f-92a9-4d83-99b6-196d1dd38481)


# Final Thoughts
With this analysis, it is clear that until 2016 there was a clear distinction in player habits and preferences among Japanese, North Americans and Europeans. The market segment that contributed the most to sales was North America. However, Role-Playing games were sold the most in Japan, depicting the huge success that this genre has in this region. These consumer patterns vary not only in the game genre but also in the platform that sells the most in these regions. In addition, the most successful publishers were evaluated in terms of number of copies sold, revealing also different business strategies. 

This project used the number of copies sold as the main metric for evaluating the performance of genres, platforms, publishers, and games. It is important to keep in mind that depending on the business model of a company, the amount of units sold does not directly correlate with the revenue generated. An example of a relatively more recent business strategy is companies that rely their revenue mostly on in-game purchases rather than selling more units. These games are, commonly, free to play and sell items or aesthetic modifications that the player can buy inside the game. Since this practice has been applied on a larger scale in the last few years, this may not affect the present analysis. It is, however, unclear whether the number of copies sold also includes downloadable games. Another possible limitation of analyzing this industry segment is that many companies decided not to share their sales data anymore, which compromises a follow-up analysis using updated data. 


In addition, the games industry has been facing profound changes in their structure. It became a common practice for a variety of publishers to be acquired by a single bigger company. An interesting follow-up on this analysis would be to aggregate publishers to the companies that they are owned, revealing that the multimillionaire games market may not be as segmented as the public perceives it to be. 


