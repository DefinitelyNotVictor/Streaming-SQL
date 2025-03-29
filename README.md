# Streaming Database

## Description
This SQL script sets up a relational database for a streaming platform, including tables for users, plans, movies, actors, categories, and watched history.

## Database and Tables

### 1. Database Creation

CREATE DATABASE streaming;
USE streaming;

This creates and selects the streaming database.

## 2. Tables

`plan` 
Stores subscription plans.

CREATE TABLE plan(
    id INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(30) NOT NULL,
    price FLOAT NOT NULL
);

`user`
Stores user details including their subscription plan.

CREATE TABLE `user`(
    id INT PRIMARY KEY AUTO_INCREMENT,
    plan_id INT NOT NULL,
    `name` VARCHAR(30) NOT NULL,
    email VARCHAR(50),
    `password` VARCHAR(20),
    FOREIGN KEY (plan_id) REFERENCES plan(id)
);

`movie`
Stores movie details.

CREATE TABLE movie(
    id INT PRIMARY KEY AUTO_INCREMENT,
    movie_name VARCHAR(30),
    `year` DATE,
    duration TIME
);

`actor`
Stores actor information.

CREATE TABLE actor(
    id INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(30)
);

`category`
Stores movie categories.

CREATE TABLE category(
    id INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(15)
);

`watched`
Stores records of watched movies.

CREATE TABLE watched(
    `data` DATE,
    `status` BOOL,
    `user_id` INT NOT NULL,
    movie_id INT NOT NULL,
    FOREIGN KEY (`user_id`) REFERENCES `user`(id),
    FOREIGN KEY (movie_id) REFERENCES movie(id)
);

`actor_movie`
Links actors to movies.

CREATE TABLE actor_movie(
    actor_id INT NOT NULL,
    movie_id INT NOT NULL,
    FOREIGN KEY (actor_id) REFERENCES actor(id),
    FOREIGN KEY (movie_id) REFERENCES movie(id)
);

`category_movie`
Links categories to movies.

CREATE TABLE category_movie(
    category_id INT NOT NULL,
    movie_id INT NOT NULL,
    FOREIGN KEY (category_id) REFERENCES category(id),
    FOREIGN KEY (movie_id) REFERENCES movie(id)
);

## Data Insertion
The script inserts sample data into each table.

## Sample Queries
Some queries to retrieve useful information:

- List all movies:
SELECT movie_name FROM movie;

- Get all user emails:
SELECT email FROM `user`;

- Get user names and their subscription plans:
SELECT `user`.`name`, plan.`name` FROM `user`
JOIN plan ON `user`.plan_id = plan.id;

- Get movies watched by user with ID 3:
SELECT movie.movie_name FROM watched
JOIN movie ON watched.movie_id = movie.id
WHERE watched.`user_id` = 3;

- Get movies in a specific category (example ID = 5):
SELECT movie.movie_name FROM category_movie
JOIN movie ON category_movie.movie_id = movie.id
JOIN category ON category_movie.category_id = category.id
WHERE category.`name` = 5;

- Get movies featuring a specific actor (example ID = 2):
SELECT movie.movie_name FROM actor_movie
JOIN movie ON actor_movie.movie_id = movie.id
JOIN actor ON actor_movie.actor_id = actor.id
WHERE actor.`name` = 2;

- Get actors in a specific movie (example ID = 3):
SELECT actor.`name` FROM actor_movie
JOIN actor ON actor_movie.actor_id = actor.id
JOIN movie ON actor_movie.movie_id = movie.id
WHERE movie.movie_name = 3;
