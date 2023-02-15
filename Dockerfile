FROM eclipse-temurin:8-jdk as java_build

#ENV http_proxy=http://proxy.tch.harvard.edu:3128
RUN apt-get update && apt-get install -y ca-certificates openssl wget unzip git-core maven libnss3

## Download apache-tomcat and extract:
RUN wget -q https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.21/bin/apache-tomcat-9.0.21.zip
RUN unzip apache-tomcat-9.0.21.zip

## Check out version of ctakes with best working web-rest module
## Then compile with maven
RUN git clone https://github.com/apache/ctakes.git

## Copy hsql dictionary descriptor into right location
RUN wget -q -O dict.zip  https://sourceforge.net/projects/ctakesresources/files/snorx_2021aa.zip/download
RUN mkdir -p /ctakes/ctakes-web-rest/src/main/resources/org/apache/ctakes/dictionary/lookup/fast/
RUN unzip -o dict.zip -d /ctakes/ctakes-web-rest/src/main/resources/org/apache/ctakes/dictionary/lookup/fast/

COPY customDictionary.xml /ctakes/ctakes-web-rest/src/main/resources/org/apache/ctakes/dictionary/lookup/fast/
COPY pom.xml /ctakes

# This version of the default piper comments out a memory-intensive negation module. If you need to run
# negation detection, then comment out this line.
# In theory shouldn't be necessary to rename since there is a TinyRestPipeline file that points to Default.piper but trying this out:
COPY Default.piper /ctakes/ctakes-web-rest/src/main/resources/pipers/TinyRestPipeline.piper
COPY Default.piper /ctakes/ctakes-web-rest/src/main/resources/pipers/Default.piper

WORKDIR /ctakes
RUN mvn compile -pl '!ctakes-distribution'  -DskipTests
RUN mvn install -pl '!ctakes-distribution'  -DskipTests

FROM tomcat:9.0-jre8-temurin
COPY --from=java_build /ctakes/ctakes-web-rest/target/ctakes-web-rest.war $CATALINA_HOME/webapps/
ENV CTAKES_HOME=/ctakes
CMD ["catalina.sh", "run"]
