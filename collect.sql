copy (select sn, model, product_id, location,
       timestamp '2023-02-27 0:00:00' + to_hours(t) start_time, timestamp '2023-02-27 0:00:00' + to_hours(t+1) end_time,
       "iLo" as source, name as type, unit, scale * least(random(), random()) "value"
       from 'times.csv', 'measurements.csv', 'inventory.csv' order by t, sn)
to 'data-2023-02-27.csv' with (header, force_quote)
