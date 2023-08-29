## Stage 1 : Gradle build produces the application executable jar
FROM gradle:6.5.0-jdk14 as builder

COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src
RUN gradle build


## Stage 2 : Final image with JRE and application executable jar
FROM openjdk:14-alpine3.10

# Copy JAR into container image
COPY --from=builder /home/gradle/src/build/libs/demo-0.0.1-SNAPSHOT.jar demo.jar

EXPOSE 8080

# Run application using executable jar application
CMD ["java", "-jar", "demo.jar"]
