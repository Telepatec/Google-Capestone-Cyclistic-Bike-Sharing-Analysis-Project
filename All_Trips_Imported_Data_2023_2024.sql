CREATE TABLE Trip_data_August_2023 (
    ride_id NVARCHAR(255),
    rideable_type NVARCHAR(255),
    started_at SMALLDATETIME,
    ended_at SMALLDATETIME,
    start_station NVARCHAR(225),
    start_station_id NVARCHAR(225),
    end_station NVARCHAR(225),
    end_station_id NVARCHAR(225),
    member_casual NVARCHAR(255),
    ride_length TIME(0)  -- Adjusted to NVARCHAR(10) to match "h:mm:ss"
);

-- Bulk insert the data into the table
BULK INSERT Trip_data_August_2023
FROM 'C:\Users\hassa\Downloads\Google Capestone Cyclistic Bike Share Analysis\Cleaned data\August_2023_cleaned.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

CREATE TABLE Trip_data_September_2023 (
    ride_id NVARCHAR(255),
    rideable_type NVARCHAR(255),
    started_at SMALLDATETIME,
    ended_at SMALLDATETIME,
    start_station NVARCHAR(225),
    start_station_id NVARCHAR(225),
    end_station NVARCHAR(225),
    end_station_id NVARCHAR(225),
    member_casual NVARCHAR(255),
    ride_length TIME(0)  -- Adjusted to NVARCHAR(10) to match "h:mm:ss"
);

-- Bulk insert the data into the table
BULK INSERT Trip_data_August_2023
FROM 'C:\Users\hassa\Downloads\Google Capestone Cyclistic Bike Share Analysis\Cleaned data\September_2023_cleaned.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

CREATE TABLE Trip_data_October_2023 (
    ride_id NVARCHAR(255),
    rideable_type NVARCHAR(255),
    started_at SMALLDATETIME,
    ended_at SMALLDATETIME,
    start_station NVARCHAR(225),
    start_station_id NVARCHAR(225),
    end_station NVARCHAR(225),
    end_station_id NVARCHAR(225),
    member_casual NVARCHAR(255),
    ride_length TIME(0)  -- Adjusted to NVARCHAR(10) to match "h:mm:ss"
);

-- Bulk insert the data into the table
BULK INSERT Trip_data_August_2023
FROM 'C:\Users\hassa\Downloads\Google Capestone Cyclistic Bike Share Analysis\Cleaned data\October_2023_cleaned.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

CREATE TABLE Trip_data_November_2023 (
    ride_id NVARCHAR(255),
    rideable_type NVARCHAR(255),
    started_at SMALLDATETIME,
    ended_at SMALLDATETIME,
    start_station NVARCHAR(225),
    start_station_id NVARCHAR(225),
    end_station NVARCHAR(225),
    end_station_id NVARCHAR(225),
    member_casual NVARCHAR(255),
    ride_length TIME(0)  -- Adjusted to NVARCHAR(10) to match "h:mm:ss"
);

-- Bulk insert the data into the table
BULK INSERT Trip_data_August_2023
FROM 'C:\Users\hassa\Downloads\Google Capestone Cyclistic Bike Share Analysis\Cleaned data\November_2023_cleaned.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

CREATE TABLE Trip_data_December_2023 (
    ride_id NVARCHAR(255),
    rideable_type NVARCHAR(255),
    started_at SMALLDATETIME,
    ended_at SMALLDATETIME,
    start_station NVARCHAR(225),
    start_station_id NVARCHAR(225),
    end_station NVARCHAR(225),
    end_station_id NVARCHAR(225),
    member_casual NVARCHAR(255),
    ride_length TIME(0)  -- Adjusted to NVARCHAR(10) to match "h:mm:ss"
);

-- Bulk insert the data into the table
BULK INSERT Trip_data_December_2023
FROM 'C:\Users\hassa\Downloads\Google Capestone Cyclistic Bike Share Analysis\Cleaned data\December_2023_cleaned.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

CREATE TABLE Trip_data_January_2024 (
    ride_id NVARCHAR(255),
    rideable_type NVARCHAR(255),
    started_at SMALLDATETIME,
    ended_at SMALLDATETIME,
    start_station NVARCHAR(225),
    start_station_id NVARCHAR(225),
    end_station NVARCHAR(225),
    end_station_id NVARCHAR(225),
    member_casual NVARCHAR(255),
    ride_length TIME(0)  -- Adjusted to NVARCHAR(10) to match "h:mm:ss"
);

-- Bulk insert the data into the table
BULK INSERT Trip_data_January_2024
FROM 'C:\Users\hassa\Downloads\Google Capestone Cyclistic Bike Share Analysis\Cleaned data\January_2024_cleaned.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

CREATE TABLE Trip_data_February_2024 (
    ride_id NVARCHAR(255),
    rideable_type NVARCHAR(255),
    started_at SMALLDATETIME,
    ended_at SMALLDATETIME,
    start_station NVARCHAR(225),
    start_station_id NVARCHAR(225),
    end_station NVARCHAR(225),
    end_station_id NVARCHAR(225),
    member_casual NVARCHAR(255),
    ride_length TIME(0)  -- Adjusted to NVARCHAR(10) to match "h:mm:ss"
);

-- Bulk insert the data into the table
BULK INSERT Trip_data_February_2024
FROM 'C:\Users\hassa\Downloads\Google Capestone Cyclistic Bike Share Analysis\Cleaned data\February_2024_cleaned.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

CREATE TABLE Trip_data_March_2024 (
    ride_id NVARCHAR(255),
    rideable_type NVARCHAR(255),
    started_at SMALLDATETIME,
    ended_at SMALLDATETIME,
    start_station NVARCHAR(225),
    start_station_id NVARCHAR(225),
    end_station NVARCHAR(225),
    end_station_id NVARCHAR(225),
    member_casual NVARCHAR(255),
    ride_length TIME(0)  -- Adjusted to NVARCHAR(10) to match "h:mm:ss"
);

-- Bulk insert the data into the table
BULK INSERT Trip_data_March_2024
FROM 'C:\Users\hassa\Downloads\Google Capestone Cyclistic Bike Share Analysis\Cleaned data\March_2024_cleaned.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

CREATE TABLE Trip_data_April_2024 (
    ride_id NVARCHAR(255),
    rideable_type NVARCHAR(255),
    started_at SMALLDATETIME,
    ended_at SMALLDATETIME,
    start_station NVARCHAR(225),
    start_station_id NVARCHAR(225),
    end_station NVARCHAR(225),
    end_station_id NVARCHAR(225),
    member_casual NVARCHAR(255),
    ride_length TIME(0)  -- Adjusted to NVARCHAR(10) to match "h:mm:ss"
);

-- Bulk insert the data into the table
BULK INSERT Trip_data_April_2024
FROM 'C:\Users\hassa\Downloads\Google Capestone Cyclistic Bike Share Analysis\Cleaned data\April_2024_cleaned.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

CREATE TABLE Trip_data_May_2024 (
    ride_id NVARCHAR(255),
    rideable_type NVARCHAR(255),
    started_at SMALLDATETIME,
    ended_at SMALLDATETIME,
    start_station NVARCHAR(225),
    start_station_id NVARCHAR(225),
    end_station NVARCHAR(225),
    end_station_id NVARCHAR(225),
    member_casual NVARCHAR(255),
    ride_length TIME(0)  -- Adjusted to NVARCHAR(10) to match "h:mm:ss"
);

-- Bulk insert the data into the table
BULK INSERT Trip_data_May_2024
FROM 'C:\Users\hassa\Downloads\Google Capestone Cyclistic Bike Share Analysis\Cleaned data\May_2024_cleaned.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

CREATE TABLE Trip_data_June_2024 (
    ride_id NVARCHAR(255),
    rideable_type NVARCHAR(255),
    started_at SMALLDATETIME,
    ended_at SMALLDATETIME,
    start_station NVARCHAR(225),
    start_station_id NVARCHAR(225),
    end_station NVARCHAR(225),
    end_station_id NVARCHAR(225),
    member_casual NVARCHAR(255),
    ride_length TIME(0)  -- Adjusted to NVARCHAR(10) to match "h:mm:ss"
);

-- Bulk insert the data into the table
BULK INSERT Trip_data_June_2024
FROM 'C:\Users\hassa\Downloads\Google Capestone Cyclistic Bike Share Analysis\Cleaned data\June_2024_cleaned.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

CREATE TABLE Trip_data_July_2024 (
    ride_id NVARCHAR(255),
    rideable_type NVARCHAR(255),
    started_at SMALLDATETIME,
    ended_at SMALLDATETIME,
    start_station NVARCHAR(225),
    start_station_id NVARCHAR(225),
    end_station NVARCHAR(225),
    end_station_id NVARCHAR(225),
    member_casual NVARCHAR(255),
    ride_length TIME(0)  -- Adjusted to NVARCHAR(10) to match "h:mm:ss"
);

-- Bulk insert the data into the table
BULK INSERT Trip_data_July_2024
FROM 'C:\Users\hassa\Downloads\Google Capestone Cyclistic Bike Share Analysis\Cleaned data\July_2024_cleaned.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);