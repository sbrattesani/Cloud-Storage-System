# Cloud Storage System

Java based web application capable of storing files to a cloud based SQL server. Implements the use of Java servlets, SQL statements, bootstraps and various JS libraries to provide application functionality and read/write instructions to files hosted on an SQL server.


## Login

![login](https://user-images.githubusercontent.com/5677692/27158273-16ab4a88-515e-11e7-8b9a-0090dc86a331.jpg)

This inital page prompts users to login to the system. If the submitted credentails match with a user within the database server, a session is created through a cookie and the user gains access to the main GUI. Alternatively a new account can be created through the sign up link.


## Register

![register](https://user-images.githubusercontent.com/5677692/27158559-6e1b9240-515f-11e7-974f-559ea534c0c7.jpg)

The registration page is capable of querying the SQL database, ensuring information such as usernames are not duplicated (primary key). The client program also has methods in place which ensure the email is in a valid format, password is a certain length (i.e. greater than 8 characters), and the password and confirm password match. The N+T values define the level of access that users have to certain files. This is currently implemented to allow easier testing of the application and will later be moved to the server side of the system, ensuring only the database administator is able to set file access levels. The username and password are then both saved to the database using salt hashing.


## Dashboard

![dashboard](https://user-images.githubusercontent.com/5677692/27159957-9ba69bac-5168-11e7-9982-a1fdd4222267.jpg)

The main dashboard is primariliy used to provide information and navigation. From here the user has access to services including file upload, download, and user settings configuration.


## Uploads

![upload](https://user-images.githubusercontent.com/5677692/27159959-9c6cdb0a-5168-11e7-8e52-b3939d564864.jpg)

As shown, the uploads service allow users to select a file from their local machine to be submitted to the SQL database. The method used to achieve this involves converting the file into bytes, separating it into shares, and saving it to blob storage.


## Downloads

![download](https://user-images.githubusercontent.com/5677692/27159840-e84ad0aa-5167-11e7-9c18-32db488b1f7d.jpg)

The download page queries the SQL database and displays all files currently hosted on the server. Assuming the users N+T values are greater than the file, they are able to download and rebuild the bytes into a readable file output.


## Settings

![setttings](https://user-images.githubusercontent.com/5677692/27159841-e9549c88-5167-11e7-94c4-be57fd071e35.jpg)

A basic account management page that allow users to edit or delete their profile. This service uses similar validation methods to the register page, ensuring there is no duplication of usernames, emails, etc.











