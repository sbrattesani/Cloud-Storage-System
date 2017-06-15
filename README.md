# Cloud Storage System

Java based web application capable of storing files to a cloud based SQL server. Implements the use of Java servlets, SQL statements, bootstraps and various JS libraries to provide application functionality and read/write instructions to files hosted on an SQL server.


## Login

![login](https://user-images.githubusercontent.com/5677692/27158273-16ab4a88-515e-11e7-8b9a-0090dc86a331.jpg)

This inital page prompts users to login to the system. If the submitted credentails match with a user within the database server, a session is created through a cookie and the user gains access to the main GUI. Alternatively a new account can be created through the sign up link.


## Register

![register](https://user-images.githubusercontent.com/5677692/27158559-6e1b9240-515f-11e7-974f-559ea534c0c7.jpg)

The registration page is capable of querying the SQL database, ensuring information such as usernames are not duplicated (primary key). The client program also has methods in place which ensure the email is in a valid format, password is a certain length (i.e. greater than 8 characters), and the password and confirm password match. The N+T values define the level of access that users have to certain files. This is currently implemented to allow easier testing of the application and will later be moved to the server side of the system, ensuring only the database administator is able to set file access levels. The username and password are then both saved to the database using salt hashing.


## Dashboard

![dashboard](https://user-images.githubusercontent.com/5677692/27159837-e67a9918-5167-11e7-987b-65deada2c25a.jpg)

## Uploads

![upload](https://user-images.githubusercontent.com/5677692/27159838-e75dbcca-5167-11e7-9e2c-ddbc6bf05b8a.jpg)

## Downloads

![download](https://user-images.githubusercontent.com/5677692/27159840-e84ad0aa-5167-11e7-9c18-32db488b1f7d.jpg)

## Settings

![setttings](https://user-images.githubusercontent.com/5677692/27159841-e9549c88-5167-11e7-94c4-be57fd071e35.jpg)











