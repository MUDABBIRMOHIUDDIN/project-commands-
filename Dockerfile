# Use Tomcat 9.0 with JDK 17
FROM tomcat:9.0-jdk17

# Set Java options (optional but recommended)
ENV JAVA_OPTS="-Xms512m -Xmx1024m"

# Remove default webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your WAR file to Tomcat ROOT
COPY target/WEB1.war /usr/local/tomcat/webapps/ROOT.war

# Change Tomcat default port to 8081
RUN sed -i 's/port="8080"/port="8081"/' /usr/local/tomcat/conf/server.xml

# Expose the new port
EXPOSE 8081

# Optional: volume for logs
VOLUME /usr/local/tomcat/logs

# Optional: health check
HEALTHCHECK --interval=30s --timeout=5s CMD curl -f http://localhost:8081/ || exit 1

# Start Tomcat with Java options
CMD ["sh", "-c", "catalina.sh run $JAVA_OPTS"]
