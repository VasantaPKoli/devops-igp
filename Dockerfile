# Base Image - Tomcat 9
FROM tomcat:9

# Copy War file from your local directory to Tomcat's webapps folder
COPY *.war /usr/local/tomcat

# Expose port 8080 for accessing the web application
EXPOSE 8080

# Start Tomcat using the array format
CMD ["catalina.sh", "run"]
