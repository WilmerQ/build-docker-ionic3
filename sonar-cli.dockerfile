FROM ubuntu
MAINTAINER WilmerQ
RUN apt-get update 
RUN apt-get install -y software-properties-common && apt-get clean
RUN apt-get install -y wget && apt-get clean
RUN apt-get install -y sed && apt-get clean
RUN apt-get install -y unzip && apt-get clean
RUN apt-get install -y maven && apt-get clean
RUN cd home/ && wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.0.0.1744-linux.zip && unzip sonar-scanner-cli-4.0.0.1744-linux.zip
RUN cd home/ && rm sonar-scanner-cli-4.0.0.1744-linux.zip