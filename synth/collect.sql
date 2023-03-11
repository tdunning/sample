select sn, model, product_id, location,
       timestamp '2023-02-27 0:00:00' + to_hours(t) start_time, timestamp '2023-02-27 0:00:00' + to_hours(t+1) end_time,
       scale * least(random(), random()) measurement_value, unit, name
from 'times.csv', 'measurements.csv', 'inventory.csv' order by t, sn;
