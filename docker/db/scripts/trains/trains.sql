CREATE SCHEMA IF NOT EXISTS trains;

CREATE TABLE IF NOT EXISTS trains.city
(
    city_name   TEXT NOT NULL,
    city_region TEXT NOT NULL,
    PRIMARY KEY (city_region, city_name)
);

CREATE TABLE IF NOT EXISTS trains.station
(
    name             TEXT PRIMARY KEY,
    number_of_tracks INTEGER NOT NULL,
    city_name        TEXT    NOT NULL,
    city_region      TEXT    NOT NULL,
    FOREIGN KEY (city_name, city_region) REFERENCES trains.city (city_name, city_region)
);

CREATE TABLE IF NOT EXISTS trains.train
(
    train_number  INTEGER PRIMARY KEY,
    train_length  INTEGER NOT NULL,
    start_station TEXT REFERENCES trains.station (name),
    end_station   TEXT REFERENCES trains.station (name)
);

CREATE TABLE IF NOT EXISTS trains.connection
(
    train_number      INTEGER     NOT NULL REFERENCES trains.train (train_number),
    departure_station TEXT        NOT NULL REFERENCES trains.station (name),
    arrival_station   TEXT        NOT NULL REFERENCES trains.station (name),
    departure_time    TIMESTAMPTZ NOT NULL,
    arrival_time      TIMESTAMPTZ NOT NULL,
    PRIMARY KEY (train_number, departure_station, arrival_station)
);