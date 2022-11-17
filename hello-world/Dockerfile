FROM adoptopenjdk/openjdk11:ubi
RUN mkdir /opt/app
COPY  ./target/hello-world-0.0.1-SNAPSHOT.jar /opt/app/hello-world.jar
CMD ["java", "-jar", "/opt/app/hello-world.jar"]
EXPOSE 8080