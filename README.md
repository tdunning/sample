# Sample power data

This directory contains an example of power data (in the `data` directory) as well as code to generate the new data (in the `synth` directory.

The purpose is to make it easy to mock up data that a producer expects to produce so that a consumer can move forward with testing while the producer is still implementing the export process.

# Dependencies

The sample data itself has no dependencies. 

To generate new or additional data, you will need duckdb available for python. See the README in the `synth` directory for more information.

# Usage

The value of this system is that it allows coordination between a data producer and a data consumer while allowing development on either side to proceed in parallel.

At the start of this process, the producer and consumer agree on the format and general content of the telemetry to be transferred. They then use the generators in the synth to produce data unit tests and mock data. This is shown in the following diagram

<img width="500" alt="image" src="https://user-images.githubusercontent.com/250490/225228289-0f419b55-0701-41ea-9389-4ef33207ba63.png">


These products can be used to decouple further development. The data unit tests can be used as a mock data consumer which lets the coding for the production of telemetry files to proceed without any external interaction as shown below. 
<img width="700" alt="image" src="https://user-images.githubusercontent.com/250490/225227930-9f1da355-ffd6-44f7-a9ec-0d3b19fa9eba.png">


The mock data, consisting of a mock device inventory and mock telemetry can be used to code the production processing pipeline, also without interactions. This is shown below.
<img width="800" alt="image" src="https://user-images.githubusercontent.com/250490/225222820-20ade52e-2663-43d0-93a9-c2412ef55ea1.png">

Once the data being produced passes the unit tests, and once the mock data can be driven through the pipeline all the way to display, the systems can be combined. The only additional mechanism required at this point is some form of data transfer. Commonly, this takes the form of storing the inventory and data in S3, but other approaches are entirely plausible. This combined system is shown here.
<img width="1229" alt="image" src="https://user-images.githubusercontent.com/250490/225223040-a29a8eea-393e-4a2a-b92f-b335cfdb0f0c.png">
