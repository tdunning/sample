# Sample power data

This directory contains an example of power data (in the `data` directory) as well as code to generate the new data (in the `synth` directory.

The purpose is to make it easy to mock up data that a producer expects to produce so that a consumer can move forward with testing while the producer is still implementing the export process.

# Dependencies

The sample data itself has no dependencies. 

To generate new or additional data, you will need duckdb available for python. See the README in the `synth` directory for more information.
