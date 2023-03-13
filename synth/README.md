# Generating Synthetic Power Data 

This directory contains code for generating synthetic power data including both the actual data as well as an inventory of the devices generating the data. The only trick to this is that there is a lot of internal coherency that is required to make this data look reasonable. First, the data as generated should always refer to machines in the inventory, second the inventory should have realistic machine information and location information.

# Process Description

The general process here starts with a catalog of machine types. I grabbed about 20 machine definitions from the (HPE Partsurfer)[https://partsurfer.hpe.com/] to get this going (it's easy to add more later) and put the results into `server_types.csv`. At this point, `log-synth` can use the `server_inventory.s` schema to generate serial numbers and locations for a bunch of machines. Joining the output of `log-synth` with `server_types.csv` resolves the references to the server types into a fully fledged inventory which goes into `../data/inventory.csv`.

Generating actual samples in `collect.sql` uses a few tricks to get the measurements we want. The core idea is that the measurements are a cartesian join with the inventory, the sample times (`times.csv`) and the measurement types (`measurements.csv`). This results in one sample for each combination of machine in inventory, time and measurement type. These samples are augmented with a random number in the range [0,1] scaled by the reasonable max in `measurements.csv`. This all works well for generating a single day of data. We could generate more by extending the times table or, more economically, by joining against a date table.

# Running the Generator

You can do the entire data generation programatically using the `generate-inventory` and `generate-data` scripts.

## Inventory Generation

Inventory generation only needs to be done once for an output directory. The options for this script include:

| Option | Description |
-------+----------
| `--directory` | The directory where the inventory should be written |
| `--count`      | The number of servers for which data should be generated |

Creating an inventory will also create a template `README` file in the target directory.

## Data Generation

Data generation can be done once or multiple times to generate multiple output files.

The command line options include the following

| Option | Description |
-------+----------
| `--directory` | The directory where the data should be written |
| `--date`        | the base date and, optionally, hour for the file. This should be in the format YYYY-MM-DD or YYYY-MM-DDTHH. If you specify an hour, then the data will span one hour. If you specify just a date, then 24 hours of data will be generated |
| `--interval`   | the interval between measurements in seconds. The default is 3600 (1 hour) |
| `--fuzz`        | the maximum variation in time between samples. Default is 0 |
| `--interval`   | specifies that beginning and end times for each measurement are included in the output. This is the default. |
| `--end`         | specifies that only the end time for each measurement is included. This is an alternative to`--interval` |
| `--format=f` | specifies the output format for the data. The value of f can be csv or parquet |
