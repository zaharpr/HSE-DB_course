CREATE schema IF NOT EXISTS hospital;

CREATE TABLE IF NOT EXISTS hospital.station
(
    station_number INTEGER PRIMARY KEY,
    station_name   TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS hospital.station_personell
(
    pers_number    INTEGER PRIMARY KEY,
    pers_name      TEXT    NOT NULL,
    station_number INTEGER NOT NULL REFERENCES hospital.station (station_number),
    profession     INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS hospital.doctor
(
    pers_number    INTEGER PRIMARY KEY,
    area           TEXT    NOT NULL,
    rank           TEXT    NOT NULL,
    station_number INTEGER NOT NULL REFERENCES hospital.station (station_number)
);

CREATE TABLE IF NOT EXISTS hospital.caregiver
(
    pers_number    INTEGER PRIMARY KEY,
    qualification  TEXT    NOT NULL,
    station_number INTEGER NOT NULL REFERENCES hospital.station (station_number)
);

CREATE TABLE IF NOT EXISTS hospital.room
(
    room_number    INTEGER PRIMARY KEY,
    number_of_beds INTEGER NOT NULL,
    station_number INTEGER NOT NULL REFERENCES hospital.station (station_number)
);

CREATE TABLE IF NOT EXISTS hospital.patient
(
    patient_number INTEGER PRIMARY KEY,
    name           TEXT        NOT NULL,
    disease        TEXT        NOT NULL,
    doctor         INTEGER     NOT NULL REFERENCES hospital.doctor (pers_number),
    room_number    INTEGER NOT NULL REFERENCES hospital.room (room_number),
    occupied_from  TIMESTAMPTZ NOT NULL,
    occupied_to    TIMESTAMPTZ NOT NULL
);