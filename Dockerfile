FROM eclipse-temurin:21
RUN mkdir /opt/app
COPY springboot-docker.jar /opt/app
EXPOSE 8080
ENTRYPOINT ["/opt/app/springboot-docker.jar"]
