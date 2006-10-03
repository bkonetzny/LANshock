[ Installation ]

 1. Download ColdFusion MX 7 (Trial) at http://www.macromedia.com/software/coldfusion/
 2. Install ColdFusion MX 7 and connect it to your avaible webserver (e.g. Apache) or use the built-in JRun webserver
 3. Download the latest MySQL 4.x Server (http://www.mysql.com).
 4. Install MySQL and create a database (e.g. lanshock) and create a new user with full rights for this database
 5. Access the ColdFusion Administrator with your webbrowser
 6. Set up a new Datasource entry with the created mysql-database in the ColdFusion Administrator
    See Section [ MySQL 4.1 ]
 7. Copy all LANshock files in a folder under your webroot
 8. Set up a new Mapping in the ColdFusion Administrator,
    name it 'lanshock' and point it to the lanshock-folder under your webroot
 9. Access LANshock with your webbrowser
10. Youre done ;)



[ MySQL 4.1 / 5 ]
See Macromedia-Technote: http://www.macromedia.com/cfusion/knowledgebase/index.cfm?id=tn_19170

 1. Download a current, stable version of the MySQL Connector J JDBC driver, available at: http://dev.mysql.com/downloads/connector/j/
 2. Extract the mysql-connector-java-3.{n}-bin.jar file from the downloaded archive file. 
 3. Save the mysql-connector-java-3.{n}-bin.jar file in the cf_root/WEB-INF/lib directory. 
 4. Restart the ColdFusion MX server. 
 5. Add a new data source to the ColdFusion MX Administrator, using the driver option Other. 
 6. Enter the JDBC URL:
    jdbc:mysql://[host]:[port]/[database] 
 7. Enter the Driver Class:
    com.mysql.jdbc.Driver 
 8. Complete username/password, and adjust other data source settings, if needed. 
 9. Submit the data source for verification. 