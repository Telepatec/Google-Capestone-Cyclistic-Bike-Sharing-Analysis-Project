# Case study: How does a bike-share navigate speedy success?
<br>
<p align="center">
  <img src="https://raw.githubusercontent.com/labwilliam/data_analysis_projects/main/cyclistic_bike_share/scripts/logo.png" alt="logo" width = "30%">
</p>

##### Author: Hassan Bhatti

##### Date: August 29th, 2024

#

_The project follows the six-step data analysis process:_

#### [Step 1 (Ask)](#step-1-ask)
#### [Step 2 (Prepare)](#step-2-prepare)
#### [Step 3 (Process)](#step-3-process)
#### [Step 4 (Analyze)](#step-4-analyze)
#### [Step 5 (Share)](#step-5-share)
#### [Step 6 (Act)](#step-6-act)

#

# Introduction

<h3> Background </h3>
This Case Study presents a capstone project as part of the Google Data Analytics Professional Certificate Course, concentrating on a fictional company called Cyclistic, a bike-sharing company.

<h3> Purpose </h3>

I am a junior data analyst at Cyclistic, and I was assigned to the Marketing analyst team who are current working on this project. The Director believes that the company's future success depends on maximizing the number of annual memberships, hence the team's goal is to understand how casual riders and annual members use Cyclistic bikes differently.

Therefore, This study follows the data analysis process, which encompasses asking relevant questions, preparing the data, processing and analyzing it, sharing insights, and suggesting actionable recommendations to address the initial question of understanding the differences between casual riders and annual members.

<br>

## Step 1 (Ask)

<h3> Business Task </h3>

Our goal is to analyze user behaviors on how annual members and casual riders use Cyclistic bikes differently and recommendations on how to convert casual riders into annual members.

* Primary Stakeholder: Lily Moreno, Director of Marketing and my Manager.

* Secondary Stakeholder: Cyclistic marketing analytics team.

To fully understand the main question, some smaller questions must be answered first, which will carve the path to this analysis and help understand the behavior of the riders:

* What are the percentages of Annual Members compared to the Casual Riders?
* What are the proportions of Bike Riders by Bike Type?
* On a monthly rate, what are the percentages of Bike Rides?
* Number of rides taking place per day?
* What is the average ride duration each day? (measured in Mins)
* What is the frequency of rides per hour?
* What are the percentages of rides that took place per season?
* What were the percentages of rides that took place, at different times of the day?

<br>

## Step 2 (Prepare)

<h3> Organizing Data </h3>

* The datasets that are used in this project were provided by Motivate International Inc., and it contains bike-sharing riders data from the months of August 2023 to July 2024.
* Each file has 13 columns of data related to the trips taken by the bike users.
* These columns detail each ride, including the ride ID, bike type used, start and end times, starting and ending station names and IDs, starting and ending station coordinates, and rider membership type.
* This dataset covers all basis of ROCCC, being from a reliable source, with original data, which is comprehensive, current, and having a citation provided.
* All the files were downloaded locally and store with proper naming conventions and uploaded to Microsoft SSMS after the data cleaning process.

<br>

## Step 3 (Process)

<h3> Tools used in this analysis </h3>

* Data Cleaning: Microsoft Excel (to perform some preliminary data inspection)
* Data Analysis: SQL (clean, transform, organize, and summerize the datasets)
* Data Visualization: R Markdown + Tableau (Create some visualizations)
* Data Cleaning
  
Prior to merging 12 months worth of bike-sharing rides data, we must properly clean the data inorder to not have any discrepancies once the analysis begins. The following cleaning tasks were performed in Microsoft Excel:

* Checking for duplicates: Using Excel's built-in "Remove Duplicates" feature, we ensured data integrity by eliminating duplicate entries.
* Validating Column Values: We verified that the `rideable_type` and `member_casual` columns only contained valid values: "classic_bike", "docked_bike", and "electric_bike" for `rideable_type`, and "casual" or "member" for `member_casual`.
* Removing Blank Values: We checked the dataset for incomplete or blank values across all columns. Rows with missing data, especially in columns like `start_station_name`, `start_station_id`, `end_station_name`, and `end_station_id`, were removed to ensure data completeness.
* Removing Unwanted Columns: We removed the `start_lat`, `start_lng`, `end_lat`, and `end_lng` columns, as they were not relevant to the analysis, to streamline the dataset and focus on essential variables.
* Adding the Ride Length Column: A new column called `ride_length` was added to calculate the duration of each ride by subtracting the `started_at` timestamp from the `ended_at` timestamp.
* Setting the Time Format: The `ride_length` column was formatted as "HH:MM" using Excel's "Format > Cells > Time > 37:30:55" option, ensuring the ride duration was displayed in a standardized time format.
* Applying Conditional Formatting: As part of the data provided, there were some extreme cases of trips that lasted less than 0 hours and some more than 24, hence they were filtered out with the use of conditional formatting and were removed from the dataset.
* Sorting the Table: The table was sorted in ascending order by the `started_at` column to ensure data consistency.
* Cleaning the data in Excel refined the dataset, addressed inconsistencies, and properly formatted ride length information for analysis.

<h3> SQL Data Manipulation </h3>

For data manipulation, the steps were performed in Microsoft SSMS. The data from each month, spanning from August 2023 to July 2024, was imported and merged into a single table called "All_Trips_Data_2023_2024".

The steps involved in this process are as follows:

* Importing the Data: The data importing process involved creating a separate table in SQL for each CSV file, named after the corresponding month of data. I defined the table structure by listing all the column names along with their respective data types. Then, using the BULK INSERT function, I imported each CSV file into its corresponding table.

* Merging the Data: A new table called, "All_Trips_Data_2023_2024" was created to store the integrated data from the whole year, and with the help of UNION ALL, the data was joined together.

* Manipulating the Data: After joining all the data together, we required some more columns to be generated to be able to measure various frequencies of bike rides to understand the behavior of customers on a deeper level. We created a new table called "All_Trips_2023_2024", which included the addition of the "months", "days", "hours", and "minutes_diff" columns.

<h4> Links </h4>
* [Importing Data](All_Trips_Imported_Data_2023_2024.sql)
* [Merging Data](All_Trips_Merged_Data_2023_2024.sql)
* [Manipulating Data](All_Trips_Manipulated_Data_2023_2024.sql)
* [Analyzing Data](All_Trips_Analyzed_Data_2023_2024.sql)
<br>

## Step 4 (Analyze)

Now that all the data has been correctly processed, we can move towards the analysis stage.

In the analysis phase, we examined the data to reveal differences in how annual members and casual riders use Cyclistic bikes.

Additionally, understanding their behaviors, preferences, and patterns also supported marketing strategies aimed at converting casual riders into annual members. The following analyses were conducted in SSMS and the resulting tables were then imported into R Studio to explore these insights ( the Graphs will be shown in the Share Step).

<h3> Q1. What are the percentages of Annual Members compared to the Casual Riders? </h3>

```sql
WITH RideCounts AS (
    SELECT 
        member_casual AS membership_type, 
        COUNT(member_casual) AS total_ride
    FROM All_Trips_Data_2023_2024
    WHERE member_casual IS NOT NULL
    GROUP BY member_casual
),
TotalCounts AS (
    SELECT 
        SUM(total_ride) AS total_membership
    FROM RideCounts
)
SELECT 
    rc.membership_type, 
    rc.total_ride, 
    tc.total_membership,
    CAST(
        CAST(rc.total_ride * 100.0 / tc.total_membership AS DECIMAL(10,2)) AS VARCHAR(10)
    ) + '%' AS membership_percentage
FROM RideCounts rc
CROSS JOIN TotalCounts tc;
```
| membership_type | total_ride | total_membership | membership_percentage |
|----------------|------------|------------------|------------------------|
| member         | 2,750,876  | 4,241,176        | 64.86%                 |
| casual         | 1,490,300  | 4,241,176        | 35.14%                 |

<h3> Q2. What are the proportions of Bike Riders by Bike Type? </h3>

```sql
WITH MembershipCounts AS (
    SELECT 
        rideable_type AS bike_type,
        member_casual AS membership_type,
        COUNT(rideable_type) AS individual_membership_count
    FROM All_Trips_2023_2024
    WHERE member_casual IS NOT NULL
    GROUP BY rideable_type, member_casual
),
TotalCounts AS (
    SELECT
        bike_type,
        SUM(individual_membership_count) AS total_membership
    FROM MembershipCounts
    GROUP BY bike_type
)
SELECT
    mc.bike_type,
    mc.membership_type,
    mc.individual_membership_count,
    tc.total_membership,
    CAST(
        CAST(mc.individual_membership_count * 100.0 / tc.total_membership AS DECIMAL(10,2))
        AS VARCHAR(10)
    ) + '%' AS membership_percentage
FROM MembershipCounts mc
JOIN TotalCounts tc
    ON mc.bike_type = tc.bike_type
ORDER BY mc.bike_type;
```
| bike_type     | membership_type | individual_membership_count | total_membership | membership_percentage |
|---------------|-----------------|------------------------------|------------------|------------------------|
| classic_bike  | member          | 1,878,836                    | 2,854,366        | 65.82%                 |
| classic_bike  | casual          | 975,530                      | 2,854,366        | 34.18%                 |
| docked_bike   | casual          | 15,514                       | 15,514           | 100.00%                |
| electric_bike | member          | 872,040                      | 1,371,296        | 63.59%                 |
| electric_bike | casual          | 499,256                      | 1,371,296        | 36.41%                 |

<h3> Q3. On a monthly rate, what are the percentages of Bike Rides? </h3>

```sql
WITH MonthlyMembershipCounts AS (
    SELECT
        member_casual AS membership_type,
        months,
        COUNT(months) AS membership_rides
    FROM All_Trips_2023_2024
    WHERE member_casual IS NOT NULL
    GROUP BY member_casual, months
),
MonthlyTotals AS (
    SELECT
        months,
        SUM(membership_rides) AS total_rides_per_month
    FROM MonthlyMembershipCounts
    GROUP BY months
)
SELECT
    mmc.membership_type,
    mmc.months,
    mmc.membership_rides,
    mt.total_rides_per_month,
    CAST(
        (mmc.membership_rides * 100.0 / mt.total_rides_per_month) AS DECIMAL(10,2)
    ) AS membership_percentage_decimal,
    CAST(
        CAST(
            (mmc.membership_rides * 100.0 / mt.total_rides_per_month) AS DECIMAL(10,2)
        ) AS VARCHAR(10)
    ) + '%' AS membership_percentage
FROM MonthlyMembershipCounts mmc
JOIN MonthlyTotals mt
    ON mmc.months = mt.months
ORDER BY 
    CASE mmc.months
        WHEN 'January' THEN 1
        WHEN 'February' THEN 2
        WHEN 'March' THEN 3
        WHEN 'April' THEN 4
        WHEN 'May' THEN 5
        WHEN 'June' THEN 6
        WHEN 'July' THEN 7
        WHEN 'August' THEN 8
        WHEN 'September' THEN 9
        WHEN 'October' THEN 10
        WHEN 'November' THEN 11
        WHEN 'December' THEN 12
    END,
    mmc.membership_type;
```
| membership_type | months     | membership_rides | total_rides_per_month | membership_percentage_decimal | membership_percentage |
|----------------|------------|------------------|------------------------|-------------------------------|------------------------|
| casual         | January    | 17,710           | 113,795                | 15.56                         | 15.56%                 |
| member         | January    | 96,085           | 113,795                | 84.44                         | 84.44%                 |
| casual         | February   | 38,164           | 184,724                | 20.66                         | 20.66%                 |
| member         | February   | 146,560          | 184,724                | 79.34                         | 79.34%                 |
| casual         | March      | 62,815           | 230,271                | 27.28                         | 27.28%                 |
| member         | March      | 167,456          | 230,271                | 72.72                         | 72.72%                 |
| casual         | April      | 93,933           | 297,777                | 31.54                         | 31.54%                 |
| member         | April      | 203,844          | 297,777                | 68.46                         | 68.46%                 |
| casual         | May        | 167,539          | 442,270                | 37.88                         | 37.88%                 |
| member         | May        | 274,731          | 442,270                | 62.12                         | 62.12%                 |
| casual         | June       | 208,384          | 494,322                | 42.16                         | 42.16%                 |
| member         | June       | 285,938          | 494,322                | 57.84                         | 57.84%                 |
| casual         | July       | 231,863          | 540,783                | 42.88                         | 42.88%                 |
| member         | July       | 308,920          | 540,783                | 57.12                         | 57.12%                 |
| casual         | August     | 233,892          | 584,953                | 39.98                         | 39.98%                 |
| member         | August     | 351,061          | 584,953                | 60.02                         | 60.02%                 |
| casual         | September  | 196,948          | 506,616                | 38.88                         | 38.88%                 |
| member         | September  | 309,668          | 506,616                | 61.12                         | 61.12%                 |
| casual         | October    | 130,294          | 403,771                | 32.27                         | 32.27%                 |
| member         | October    | 273,477          | 403,771                | 67.73                         | 67.73%                 |
| casual         | November   | 72,072           | 274,758                | 26.23                         | 26.23%                 |
| member         | November   | 202,686          | 274,758                | 73.77                         | 73.77%                 |
| casual         | December   | 36,686           | 167,136                | 21.95                         | 21.95%                 |
| member         | December   | 130,450          | 167,136                | 78.05                         | 78.05%                 |

<h3> Q4. Number of rides taking place per day? </h3>

```sql
SELECT 
    member_casual AS membership_type, 
    weekdays,
    COUNT(weekdays) AS rides_per_day
FROM 
    All_Trips_2023_2024
WHERE 
    member_casual IS NOT NULL 
GROUP BY 
    member_casual, 
    weekdays
ORDER BY 
    DATEPART(WEEKDAY, 
        CASE weekdays
            WHEN 'Sunday' THEN '2024-01-07'
            WHEN 'Monday' THEN '2024-01-08'
            WHEN 'Tuesday' THEN '2024-01-09'
            WHEN 'Wednesday' THEN '2024-01-10'
            WHEN 'Thursday' THEN '2024-01-11'
            WHEN 'Friday' THEN '2024-01-12'
            WHEN 'Saturday' THEN '2024-01-13'
        END
    ),
    member_casual;
```
| membership_type | weekdays   | rides_per_day |
|----------------|------------|---------------|
| casual         | Sunday     | 254,449       |
| member         | Sunday     | 300,218       |
| casual         | Monday     | 166,565       |
| member         | Monday     | 387,326       |
| casual         | Tuesday    | 170,669       |
| member         | Tuesday    | 444,168       |
| casual         | Wednesday  | 190,438       |
| member         | Wednesday  | 463,595       |
| casual         | Thursday   | 183,456       |
| member         | Thursday   | 432,900       |
| casual         | Friday     | 217,308       |
| member         | Friday     | 382,570       |
| casual         | Saturday   | 307,415       |
| member         | Saturday   | 340,099       |

<h3> Q5. What is the average ride duration each day? (measured in Mins) </h3>

```sql
WITH WeeklyData AS (
    SELECT
        member_casual AS membership_type, 
        weekdays, 
        duration_minutes
    FROM All_Trips_2023_2024
    WHERE member_casual IS NOT NULL
)
SELECT 
    membership_type,
    weekdays,
    AVG(duration_minutes) AS ride_duration
FROM WeeklyData
GROUP BY membership_type, weekdays
ORDER BY 
    CASE weekdays
        WHEN 'Sunday' THEN 1 
        WHEN 'Monday' THEN 2
        WHEN 'Tuesday' THEN 3 
        WHEN 'Wednesday' THEN 4
        WHEN 'Thursday' THEN 5
        WHEN 'Friday' THEN 6
        WHEN 'Saturday' THEN 7 
    END,
    membership_type;
```
| membership_type | weekdays   | ride_duration |
|----------------|------------|---------------|
| casual         | Sunday     | 27            |
| member         | Sunday     | 13            |
| casual         | Monday     | 23            |
| member         | Monday     | 11            |
| casual         | Tuesday    | 20            |
| member         | Tuesday    | 11            |
| casual         | Wednesday  | 21            |
| member         | Wednesday  | 12            |
| casual         | Thursday   | 20            |
| member         | Thursday   | 11            |
| casual         | Friday     | 23            |
| member         | Friday     | 12            |
| casual         | Saturday   | 27            |
| member         | Saturday   | 14            |

<h3> Q6. What is the frequency of rides per hour? </h3>

```sql
WITH FilteredData AS (
    SELECT
        member_casual AS membership_type, 
        hours
    FROM All_Trips_2023_2024
    WHERE member_casual IS NOT NULL
)
SELECT 
    membership_type, 
    hours,
    COUNT(hours) AS rides_per_hour
FROM FilteredData
GROUP BY membership_type, hours
ORDER BY hours, membership_type;
```
| membership_type | hours | rides_per_hour |
|----------------|-------|----------------|
| casual         | 0     | 21,892         |
| member         | 0     | 21,303         |
| casual         | 1     | 14,552         |
| member         | 1     | 12,048         |
| casual         | 2     | 8,616          |
| member         | 2     | 6,638          |
| casual         | 3     | 4,664          |
| member         | 3     | 4,420          |
| casual         | 4     | 3,491          |
| member         | 4     | 5,772          |
| casual         | 5     | 8,094          |
| member         | 5     | 26,566         |
| casual         | 6     | 19,576         |
| member         | 6     | 82,796         |
| casual         | 7     | 36,901         |
| member         | 7     | 157,096        |
| casual         | 8     | 51,216         |
| member         | 8     | 192,179        |
| casual         | 9     | 52,307         |
| member         | 9     | 126,642        |
| casual         | 10    | 67,827         |
| member         | 10    | 112,925        |
| casual         | 11    | 86,079         |
| member         | 11    | 132,780        |
| casual         | 12    | 101,505        |
| member         | 12    | 152,087        |
| casual         | 13    | 105,484        |
| member         | 13    | 151,506        |
| casual         | 14    | 108,437        |
| member         | 14    | 152,500        |
| casual         | 15    | 118,325        |
| member         | 15    | 187,611        |
| casual         | 16    | 135,729        |
| member         | 16    | 258,161        |
| casual         | 17    | 144,950        |
| member         | 17    | 300,510        |
| casual         | 18    | 121,290        |
| member         | 18    | 226,491        |
| casual         | 19    | 87,659         |
| member         | 19    | 157,181        |
| casual         | 20    | 63,597         |
| member         | 20    | 109,489        |
| casual         | 21    | 51,586         |
| member         | 21    | 81,591         |
| casual         | 22    | 45,476         |
| member         | 22    | 57,842         |
| casual         | 23    | 31,047         |
| member         | 23    | 34,742         |

<h3> Q7. What are the percentages of rides that took place per season? </h3>

```sql
SELECT
   membership_type,
   season,
   COUNT(*) AS ride_per_season,
   SUM(COUNT(*)) OVER (PARTITION BY season) AS total_rides_per_season,
   CONCAT(CAST(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (PARTITION BY season) AS DECIMAL(10,2)), '%') AS percentage_per_season
FROM (
   SELECT
      member_casual AS membership_type,
      CASE
         WHEN months IN ('December', 'January', 'February') THEN 'Winter'
         WHEN months IN ('March', 'April', 'May') THEN 'Spring'
         WHEN months IN ('June', 'July', 'August') THEN 'Summer'
         WHEN months IN ('September', 'October', 'November') THEN 'Autumn'
      END AS season
   FROM All_Trips_2023_2024
   WHERE member_casual IS NOT NULL
) AS derived_table
GROUP BY membership_type, season
ORDER BY 
   CASE season
      WHEN 'Winter' THEN 1
      WHEN 'Spring' THEN 2
      WHEN 'Summer' THEN 3
      WHEN 'Autumn' THEN 4
   END, membership_type;
```
| membership_type | season | ride_per_season | total_rides_per_season | percentage_per_season |
|----------------|--------|-----------------|-------------------------|------------------------|
| casual         | Winter | 92,560          | 465,655                 | 19.88%                 |
| member         | Winter | 373,095         | 465,655                 | 80.12%                 |
| casual         | Spring | 324,287         | 970,318                 | 33.42%                 |
| member         | Spring | 646,031         | 970,318                 | 66.58%                 |
| casual         | Summer | 674,139         | 1,620,058               | 41.61%                 |
| member         | Summer | 945,919         | 1,620,058               | 58.39%                 |
| casual         | Autumn | 399,314         | 1,185,145               | 33.69%                 |
| member         | Autumn | 785,831         | 1,185,145               | 66.31%                 |

<h3> Q8. What were the percentages of rides that took place, at different times of the day? </h3>

```sql
SELECT
  membership_type,
  part_of_day,
  COUNT(part_of_day) AS rides_per_part_of_day,
  SUM(COUNT(part_of_day)) OVER (PARTITION BY part_of_day) AS total_rides_per_part_of_day,
  CONCAT(CAST(COUNT(part_of_day) * 100.0 / SUM(COUNT(part_of_day)) OVER (PARTITION BY part_of_day) AS DECIMAL(10,2)), '%') AS percentage_of_rides
FROM (
   SELECT
     member_casual AS membership_type,
     duration_minutes AS ride_duration,
     CASE
       WHEN hours >= 0 AND hours < 6 THEN 'Night'
       WHEN hours >= 6 AND hours < 12 THEN 'Morning'
       WHEN hours >= 12 AND hours < 18 THEN 'Afternoon'
       WHEN hours >= 18 THEN 'Evening'
     END AS part_of_day
   FROM All_Trips_2023_2024
   WHERE member_casual IS NOT NULL
) AS subquery
GROUP BY part_of_day, membership_type
ORDER BY 
  CASE part_of_day
    WHEN 'Night' THEN 1
    WHEN 'Morning' THEN 2
    WHEN 'Afternoon' THEN 3
    WHEN 'Evening' THEN 4
  END, membership_type;
```
| membership_type | part_of_day | rides_per_part_of_day | total_rides_per_part_of_day | percentage_of_rides |
|-----------------|-------------|-----------------------|-----------------------------|---------------------|
| casual          | Night       | 61,309                | 138,056                     | 44.41%              |
| member          | Night       | 76,747                | 138,056                     | 55.59%              |
| casual          | Morning     | 313,906               | 1,118,324                   | 28.07%              |
| member          | Morning     | 804,418               | 1,118,324                   | 71.93%              |
| casual          | Afternoon   | 714,430               | 1,916,805                   | 37.27%              |
| member          | Afternoon   | 1,202,375             | 1,916,805                   | 62.73%              |
| casual          | Evening     | 400,655               | 1,067,991                   | 37.51%              |
| member          | Evening     | 667,336               | 1,067,991                   | 62.49%              |
<br>

## Step 5 (Share)

Moving towards the visualization step, we made use of a powerful tool called R Studio to generate graphs for the data that was discovered in the analysis step.

The results from the Analysis step were exported into an R Markdown file, where each graph was visualized.

<br>

<h3> Q1. What are the percentages of Annual Members compared to the Casual Riders? </h3>

# 

Analysis of the ride data from August 2023 to July 2024 revealed that annual members made up the majority, accounting for 64.86% of the total 4,241,176 rides.

![image](https://github.com/user-attachments/assets/26d1a5f8-bb58-45a7-b0bd-ec47a8ae6f84)

<br>

<h3> Q2. What are the proportions of Bike Riders by Bike Type? </h3>

#

Classic bikes are the most popular overall, with members making up 65.82% of their usage, indicating a strong preference for this type among regular users. Casual riders also use classic bikes significantly, comprising 34.18% of the total rides. For electric bikes, members again dominate, accounting for 63.59% of rides, while casual riders make up 36.41%. This suggests that both groups appreciate the convenience of electric bikes, but members still lead in usage. Notably, docked bikes are exclusively used by casual riders, indicating that this bike type is likely designed for one-time or infrequent use, making it less appealing or unavailable to members. 

![image](https://github.com/user-attachments/assets/4d087864-e4d0-42db-98d1-23abc04edc47)

<br>

<h3> Q3. On a monthly rate, what are the percentages of Bike Rides? </h3>

#

Members consistently account for a higher percentage of rides throughout the year, with their dominance peaking in colder months, indicating regular usage, likely for commuting. Casual riders, on the other hand, show a significant increase during warmer months, particularly from May to September, where their participation rises to nearly 40-43% of total rides, suggesting that their usage is more influenced by favorable weather conditions. Despite this seasonal fluctuation, members remain the majority in all months.

![image](https://github.com/user-attachments/assets/bd11bfcd-ebde-4300-9c4f-857d98c5b642)

<br>

<h3> Q4. Number of rides taking place per day? </h4>

#

Members consistently have more rides on all days of the week, indicating higher engagement and regular use of the service. Member ridership peaks during weekdays, particularly on Wednesday, with 463,595 rides, suggesting that members likely use bikes for commuting and daily activities. In contrast, casual riders have their highest ridership on weekends, especially on Saturday (307,415 rides) and Sunday (254,449 rides), indicating that casual users are more inclined to use the service for leisure activities. This contrast between weekday and weekend usage patterns suggests that members are more consistent in their usage, likely for practical purposes, while casual riders are more influenced by the opportunity for recreational rides on weekends.

![image](https://github.com/user-attachments/assets/c2d830aa-17e5-443b-81a3-e7a31c02a7db)

<br>

<h3> Q5. What is the average ride duration each day? (measured in Mins) </h3>

#

Casual riders consistently have longer ride durations, ranging from 20 to 27 minutes, with the longest rides occurring on weekends (27 minutes on Saturday and Sunday). This suggests that casual users likely engage in more leisurely, recreational activities, taking advantage of their rides for extended periods. In contrast, member riders have significantly shorter ride durations, averaging between 11 and 14 minutes throughout the week, indicating that their rides are likely more purpose-driven, such as commuting or running errands, where efficiency is key. The consistent pattern of shorter rides among members across all days further underscores their practical, time-sensitive use of the service, while casual riders tend to enjoy longer, more relaxed rides, especially on weekends.

![image](https://github.com/user-attachments/assets/57fd35b9-8655-4eee-976f-38fb10d2dab0)

<br>

<h3> Q6. What is the frequency of rides per hour? </h3>

#

Casual riders show a more evenly spread usage throughout the day, with notable peaks during mid-morning and late afternoon (10 AM to 5 PM). Their activity gradually decreases in the evening, with a noticeable drop after 8 PM. This pattern suggests that casual riders likely use the service for leisurely or recreational purposes, with a preference for daytime hours.

In contrast, member riders exhibit clear peaks during early morning (6 AM to 9 AM) and late afternoon to early evening (4 PM to 7 PM), corresponding with typical commuting hours. The sharp increase in rides during these times indicates that members predominantly use the service for commuting to and from work or school. Their usage during non-commuting hours, while still present, is significantly lower, reinforcing the idea that members are more likely to use bikes for practical, time-sensitive purposes.

![image](https://github.com/user-attachments/assets/87f1ab84-443e-4c86-880e-fa37f11084a4)

<br>

<h3> Q7. What are the percentages of rides that took place per season? </h3>

#

Member riders consistently account for a higher percentage of rides throughout all seasons, with their dominance most pronounced in the winter, where they represent 80.12% of total rides. This indicates that members are more committed to using the service year-round, even in colder weather, likely for commuting or regular activities.

Casual riders, on the other hand, show a significant increase in ridership during the warmer seasons, particularly in the summer, where their rides make up 41.61% of the total. This suggests that casual users are more influenced by favorable weather and are likely to use the service more for recreational purposes during these periods. In contrast, their usage drops sharply in the winter to just 19.88%, indicating that casual users are less inclined to ride in colder conditions.

![image](https://github.com/user-attachments/assets/f11641e3-a00e-4bc0-be43-dea281378d96)

<br>

<h3> Q8. What were the percentages of rides that took place, at different times of the day? </h3>

#

Members consistently account for the majority of rides across all time zones, with their highest percentage during the morning (71.93%), indicating a strong preference for early rides, likely for commuting or starting daily activities. This suggests that members are more inclined to use the service for practical, time-sensitive purposes.

Casual riders, on the other hand, have a more balanced distribution of rides across the day but still show less engagement compared to members in every time zone. Their highest activity is in the afternoon, where they contribute to 37.27% of rides, indicating that casual users are more likely to ride during leisurely or less time-constrained hours. Notably, casual riders also account for a significant portion of night rides (44.41%), which might suggest recreational activities or occasional night-time commuting.

![image](https://github.com/user-attachments/assets/68f413bc-23bc-4007-8398-655179b99eaa)

<br>

## Step 6 (Act)

Based on the results of my analysis, some key takeaways and strategies to convert more casual riders into annual members can be derived.

<h3> Key Takeaways </h3>

#

* Ride Distribution by Type: Members use both classic and electric bikes more frequently, whereas casual riders show significant use of docked bikes, likely for short-term or one-time use.

* Monthly Variation: Ride volumes are highest in summer, with casual riders showing significant peaks during summer (41.61%) compared to other months, while members maintain relatively stable usage throughout the year.

* Weekday vs. Weekend Usage: Members have higher ride frequencies on weekdays, with peak usage on Monday (387,326 rides), whereas casual riders show increased activity on weekends, with peak rides on Saturday (307,415 rides).

* Ride Duration: Casual riders exhibit longer average ride durations ranging from 20 to 27 minutes, compared to members, who have shorter durations averaging 11 to 14 minutes.

* Peak Usage Hour: Members have peak ride hours between 6-9 AM and 4-7 PM, aligning with typical commuting times, while casual riders peak in the afternoon and evening.

* Seasonal Patterns: Casual riders show increased usage during warmer months (spring and summer) and during weekends, indicating a preference for recreational use when weather conditions are favorable.

* Part of Day Distribution: Members concentrate their rides in the morning and evening hours, whereas casual riders have a more evenly distributed usage pattern, peaking in the afternoon (37.27%) and evening (37.51%).
  
<br>

<h3> Strategies to convert more Casual Riders into Annual Members </h3>

#

* Seasonal Promotions: Offer targeted promotions or discounts during the peak recreational periods (spring and summer) to encourage casual riders to try membership benefits.

* Leisure Incentives: Develop membership packages that include benefits tailored for casual use, such as discounted rates for longer rides or special offers for extended recreational use.

* Enhanced Convenience: Implement features or perks that appeal to casual riders' preferences, such as free or discounted weekend rentals, to make membership more attractive for leisure riders.

* Time-Based Membership Benefits: Introduce time-based incentives that align with the casual riders' peak usage times (afternoons and evenings), such as off-peak membership discounts or bonus ride credits.

* Trial Memberships: Offer trial memberships or temporary discounts that allow casual riders to experience the benefits of membership without a long-term commitment.

* Promote Bike Types: Highlight the availability and benefits of bike types favored by casual riders, such as classic and electric bikes, in membership marketing materials.

* Engagement Campaigns: Create marketing campaigns that emphasize the convenience, cost savings, and additional perks of membership, specifically targeting casual riders who may be influenced by these factors.




