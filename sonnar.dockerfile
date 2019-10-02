FROM ubuntu
MAINTAINER WilmerQ
#argumentos 
#ARG userJdbc=postgres
#ARG passJdbc=12345
#ARG host=192.168.0.15
#ARG port=5432
#asignacion de variables
ENV userJdbc2=postgres
ENV passJdbc2=12345
ENV host2=192.168.0.15
ENV port2=5432
RUN apt-get update 
RUN apt-get install -y software-properties-common && apt-get clean
RUN apt-get install -y wget && apt-get clean
RUN apt-get install -y sed && apt-get clean
RUN add-apt-repository ppa:webupd8team/java && apt-get update
RUN apt-get update
RUN apt-get install unzip && apt-get clean
RUN apt-get install openjdk-11-jdk -y && apt-get clean
RUN update-alternatives --config javac
RUN mkdir /opt/sonar
RUN cd /opt/sonar/ && wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-7.9.1.zip && unzip -d /opt/sonar/ sonarqube-7.9.1.zip && rm sonarqube-7.9.1.zip
RUN adduser --disabled-password --gecos "12345" sonarqubeuser
RUN chown -R sonarqubeuser:sonarqubeuser /opt/sonar/
#USER sonarqubeuser
#RUN whoami
RUN cd /opt/sonar/sonarqube-7.9.1/conf/ && ls && sed -i '16csonar.jdbc.username='$userJdbc2 ./sonar.properties && sed -i '17csonar.jdbc.password='$passJdbc2 ./sonar.properties && sed -i '34csonar.jdbc.url=jdbc:postgresql://'$host2':'$port2'/sonar?currentSchema=public' ./sonar.properties  && cd /opt/sonar/sonarqube-7.9.1/bin/linux-x86-64/ && ./sonar.sh console
#RUN cd /opt/sonar/sonarqube-7.9.1/conf/ && ls && sed -i '16csonar.jdbc.username='$userJdbc2 ./sonar.properties && sed -i '17csonar.jdbc.password='$passJdbc2 ./sonar.properties && sed -i '34csonar.jdbc.url=jdbc:postgresql://'$host2':'$port2'/sonar?currentSchema=public' ./sonar.properties && chown -R sonarqubeuser:sonarqubeuser /opt/sonar/ && su sonarqubeuser && cd /opt/sonar/sonarqube-7.9.1/bin/linux-x86-64/ && ./sonar.sh console
EXPOSE 9000
COPY ./sonar-entrypoint.sh /opt/
RUN chmod +x /opt/sonar-entrypoint.sh && cd /opt/ && ls
#ENTRYPOINT ["/bin/bash","/opt/sonar-entrypoint.sh" ]
ENTRYPOINT ["/opt/sonar-entrypoint.sh"]
CMD ["variable1", "variable2", "superman"]