
IF OBJECT_ID('All_Trips_2023_2024', 'U') IS NOT NULL
  DROP TABLE All_Trips_2023_2024
  CREATE TABLE All_Trips_2023_2024
  (
  ride_id nvarchar(255),
  rideable_type nvarchar(255),
  started_at smalldatetime,
  ended_at smalldatetime,
  member_casual nvarchar(255),
  ride_length time(0),
  months nvarchar(255),
  weekdays nvarchar(255),
  hours int,
  duration_minutes int
);

INSERT INTO All_Trips_2023_2024
SELECT
  ride_id,
  rideable_type,
  started_at,
  ended_at,
  member_casual,
  ride_length,
  DATENAME(MONTH, started_at) AS months,
  DATENAME(WEEKDAY, started_at) AS weekdays,
  DATENAME (HOUR, started_at) AS hours,
  DATEDIFF(minute, started_at, ended_at) AS minutes_diff
FROM All_Trips_Data_2023_2024;

SELECT *
FROM All_Trips_2023_2024
WHERE member_casual is not null 
ORDER BY started_at ASC

CREATE VIEW ViewWithHeaders AS
SELECT 
    'ride_id' AS ride_id,
    'rideable_type' AS rideable_type,
    'started_at' AS started_at,
    'ended_at' AS ended_at,
    'member_casual' AS member_casual,
    'ride_length' AS ride_length,
    'months' AS months,
    'weekdays' AS weekdays,
    'hours' AS hours,
    'minutes_diff' AS minutes_diff
UNION ALL
SELECT 
    ride_id,
    rideable_type,
    started_at,
    ended_at,
    member_casual,
    ride_length,
    DATENAME(MONTH, started_at) AS months,
    DATENAME(WEEKDAY, started_at) AS weekdays,
    DATENAME(HOUR, started_at) AS hours,
    DATEDIFF(minute, started_at, ended_at) AS minutes_diff
FROM All_Trips_2023_2024;
