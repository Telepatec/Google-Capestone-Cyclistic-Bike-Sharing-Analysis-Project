Select *  
INTO All_Trips_Data_2023_2024
From Trip_data_August_2023
UNION ALL 
SELECT *
FROM Trip_data_September_2023
UNION ALL 
SELECT *
FROM Trip_data_October_2023
UNION ALL 
SELECT *
FROM Trip_data_November_2023
UNION ALL 
SELECT *
FROM Trip_data_December_2023
UNION ALL 
SELECT *
FROM Trip_data_January_2024
UNION ALL 
SELECT *
FROM Trip_data_February_2024
UNION ALL 
SELECT *
FROM Trip_data_March_2024
UNION ALL 
SELECT *
FROM Trip_data_April_2024
UNION ALL 
SELECT *
FROM Trip_data_May_2024
UNION ALL 
SELECT *
FROM Trip_data_June_2024
UNION ALL 
SELECT *
FROM Trip_data_July_2024
  
SELECT *
FROM All_Trips_Data_2023_2024

CREATE VIEW ViewWithHeaders AS
SELECT 
    'ride_id' AS ride_id,
    'rideable_type' AS rideable_type,
    'started_at' AS started_at,
    'ended_at' AS ended_at,
    'start_station' AS start_station,
    'start_station_id' AS start_station_id,
    'end_station' AS end_station,
    'end_station_id' AS end_station_id,
    'member_casual' AS member_casual,
    'ride_length' AS ride_length
UNION ALL
SELECT 
    ride_id,
    rideable_type,
    started_at,
    ended_at,
    start_station,
    start_station_id,
    end_station,
    end_station_id,
    member_casual,
    ride_length
FROM All_Trips_Data_2023_2024;

SELECT * FROM ViewWithHeaders;