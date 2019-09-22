FROM ubuntu
MAINTAINER WilmerQ
ARG userJdbc=postgres
ARG passJdbc=12345
ARG host=192.168.0.15
ARG port=5432
RUN apt-get update 
RUN apt-get install -y software-properties-common && apt-get clean
RUN apt-get install -y wget && apt-get clean
RUN apt-get install -y sed && apt-get clean
RUN add-apt-repository ppa:webupd8team/java && apt-get update
RUN apt-get update
RUN apt-get install unzip && apt-get clean
RUN apt-get install openjdk-11-jdk -y && apt-get clean
RUN update-alternatives --config javac
RUN mkdir /opt/sonar/
RUN cd /opt/sonar/
RUN wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-7.9.1.zip
RUN unzip -d /opt/sonar/ sonarqube-7.9.1.zip
RUN adduser --disabled-password --gecos "" sonarqubeuser
#RUN adduser --system --no-create-home --group --disabled-login sonarqubeUser
RUN cd /opt/sonar/sonarqube-7.9.1/conf/
RUN sed -i '16csonar.jdbc.username=${userJdbc}' ./sonar.properties
RUN sed -i '17csonar.jdbc.password=${passJdbc}' ./sonar.properties
RUN sed -i '34csonar.jdbc.url=jdbc:postgresql://${host}:${port}/sonar?currentSchema=public' ./sonar.properties
RUN chown -R sonarqubeuser:sonarqubeuser /opt/sonar/
RUN su sonarqubeuser
RUN cd /opt/sonar/sonarqube-7.9.1/bin/linux-x86-64/
RUN ./sonar.sh console
EXPOSE 9000


#RUN apt-get install curl wget -y && apt-get clean
#RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
#RUN apt install nodejs -y 
#RUN add-apt-repository ppa:webupd8team/java 
#RUN apt update 
#RUN apt-get install openjdk-8-jdk -y && apt-get clean
#RUN apt-get install libc6-dev-i386 lib32z1 -y && apt-get clean
#RUN update-alternatives --config javac
#RUN apt-get install unzip && apt-get clean
#RUN wget https://services.gradle.org/distributions/gradle-4.1-bin.zip && mkdir /opt/gradle/ && unzip -d /opt/gradle/ gradle-4.1-bin.zip && rm gradle-4.1-bin.zip
#RUN mkdir -p /opt/android-sdk-linux/ && cd /opt/android-sdk-linux/ && wget https://dl.google.com/android/repository/tools_r25.2.3-linux.zip && unzip tools_r25.2.3-linux.zip && rm tools_r25.2.3-linux.zip && cd tools/bin/ && echo y | ./sdkmanager "platforms;android-23" && echo y | ./sdkmanager "platforms;android-24" && echo y | ./sdkmanager "platforms;android-25" && echo y | ./sdkmanager "platforms;android-26" && echo y | ./sdkmanager "platforms;android-27" && echo y | ./sdkmanager "platforms;android-28" && echo y | ./sdkmanager "build-tools;26.0.2" && echo y | ./sdkmanager "platform-tools" && echo y | ./sdkmanager "add-ons;addon-google_apis-google-19" && echo y | ./sdkmanager "add-ons;addon-google_apis-google-21" && echo y | ./sdkmanager "add-ons;addon-google_apis-google-22" && echo y | ./sdkmanager "add-ons;addon-google_apis-google-23" && echo y | ./sdkmanager "add-ons;addon-google_apis-google-24" && echo y | ./sdkmanager "extras;google;m2repository" && echo y | ./sdkmanager "extras;google;google_play_services" 
#ENV PATH=$PATH:/opt/gradle/gradle-4.1/bin/
#ENV PATH=${PATH}:/opt/android-sdk-linux/platform-tools/
#ENV PATH=${PATH}:/opt/android-sdk-linux/tools/
#ENV PATH=${PATH}:/opt/android-sdk-linux/build-tools/26.0.2/