--Q1. What are the percentages of Annual Members compared to the Casual Riders?

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

--Q2. What are the proportions of Bike Riders by Bike Type? 

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

--Q3. On a monthly rate, what are the percentages of Bike Rides?

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

--Q4. Number of rides taking place per day?

SELECT member_casual AS membership_type, 
weekdays,
COUNT (weekdays) AS rides_per_day
FROM All_Trips_2023_2024
WHERE member_casual is not null 
GROUP BY member_casual, weekdays
ORDER BY 
CASE weekdays
     WHEN 'Sunday' THEN 1 
	 WHEN 'Monday' THEN 2
	 WHEN 'Tuesday' THEN 3 
	 WHEN 'Wednesday' THEN 4
	 WHEN 'Thursday' THEN 5
	 WHEN 'Friday' THEN 6
	 WHEN 'Saturday' THEN 7 
END, member_casual;
----------------------------------------------

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

--Q5. What is the average ride duration each day? (measured in Mins)

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

--Q6. What is the frequency of rides per hour? 

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

--Q7. What are the percentages of rides that took place per season?

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

--Q8. What were the percentages of rides that took place, at different times of the day? 

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