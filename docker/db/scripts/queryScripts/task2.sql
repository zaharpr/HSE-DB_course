SELECT trainnr
FROM trains.connection
WHERE connection.fromstation IN (SELECT fromstation
                                 FROM trains.connection AS c
                                          JOIN trains.station ON station.name = c.tostation
                                 WHERE cityname = 'Тверь')
  AND connection.tostation IN (SELECT tostation
                               FROM trains.connection AS c
                                        JOIN trains.station ON station.name = c.fromstation
                               WHERE cityname = 'Москва');

SELECT trainnr
FROM trains.connection
WHERE connection.fromstation IN (SELECT fromstation
                                 FROM trains.connection AS c
                                          JOIN trains.station ON station.name = c.tostation
                                 WHERE cityname = 'Санкт-Петербург')
  AND connection.tostation IN (SELECT tostation
                               FROM trains.connection AS c
                                        JOIN trains.station ON station.name = c.fromstation
                               WHERE cityname = 'Москва')
  AND DATE(departure) = DATE(arrival);
