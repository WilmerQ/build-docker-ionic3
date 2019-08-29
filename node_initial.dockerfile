FROM ubuntu:16.04
#COPY D:\jdk-6u45-linux-x64.bin home/
#COPY source dest
RUN apt-get update
RUN apt-get install -y software-properties-common
RUN apt-get install curl wget -y
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt install nodejs -y
RUN node -v
RUN npm -v