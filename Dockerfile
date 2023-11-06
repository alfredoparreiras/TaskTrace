# Start with a base image of the latest version of Tomcat
FROM tomcat:latest

# Set the maintainer’s name
LABEL authors="alfredosilva"

# Remove unnecessary default Tomcat apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the WAR file to the Tomcat webapps directory
COPY ./target/TaskTrace.war /usr/local/tomcat/webapps/ROOT.war

# Expose HTTP port
EXPOSE 8080

# Run Tomcat on container st