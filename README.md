# Apache Zeppelin on Docker
Docker image for Apache Zeppelin (Incubating)

This is for people who want a working Apache Zeppelin browser experience for working with Apache Spark using pyspark and scala.

#Pull the image from Docker Repository

`pull reecerobinson/docker-zeppelin`

# Building the image

`docker build -t [tag] .`

# Running the image

`docker run -d --name zeppelin -v /[your notebook path]:/incubator-zeppelin/notebook -p 8080:8080 -p 8081:8081 -p 4040:4040 reecerobinson/docker-zeppelin:latest`

In your browser go to `http://[host]:8080` to view the notebook.

# Versions

Zeppelin 0.6 SNAPSHOT, Apache Spark 1.5.0
