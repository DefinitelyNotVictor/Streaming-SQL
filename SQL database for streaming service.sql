CREATE DATABASE streaming;

USE streaming;

CREATE TABLE plan(
	id INT PRIMARY KEY AUTO_INCREMENT,
	`name` VARCHAR(30) NOT NULL,
    price FLOAT NOT NULL
);

CREATE TABLE `user`(
	id INT PRIMARY KEY AUTO_INCREMENT,
    plan_id INT NOT NULL,
    `name` VARCHAR(30) NOT NULL,
    email VARCHAR(50),
    `password` VARCHAR(20),
    FOREIGN KEY (plan_id) REFERENCES plan(id)
);

CREATE TABLE movie(
	id INT PRIMARY KEY AUTO_INCREMENT,
    movie_name VARCHAR(30),
    `year` DATE,
    duration TIME 
);

CREATE TABLE actor(
	id INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(30)
);

CREATE TABLE category(
	id INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(15)
);

CREATE TABLE watched(
	`data` DATE,
    `status` BOOL,
    `user_id` INT NOT NULL,
    movie_id INT NOT NULL,
    FOREIGN KEY (`user_id`) REFERENCES `user`(id),
    FOREIGN KEY (movie_id) REFERENCES movie(id)
);

CREATE TABLE actor_movie(
	actor_id INT NOT NULL,
    movie_id INT NOT NULL,
	FOREIGN KEY (actor_id) REFERENCES actor(id),
	FOREIGN KEY (movie_id) REFERENCES movie(id)
);

CREATE TABLE category_movie(
	category_id INT NOT NULL,
    movie_id INT NOT NULL,
	FOREIGN KEY (category_id) REFERENCES category(id),
    FOREIGN KEY (movie_id) REFERENCES movie(id)
);

INSERT INTO plan (`name`, price) VALUES
('Basic', 19.90),
('Standart', 29.90),
('Premium', 39.90),
('VIP', 49.90),
('Póbi do universitário', 14.90);

INSERT INTO `user` (plan_id, `name`, email, `password`) VALUES
(1, 'Victor', 'macarronada@email.com', 'lasanha123'),
(2, 'Biel mochila de utilidades', 'martelo@email.com', 'MARTELO'),
(3, 'Rafael, o nório', 'rafao@email.com', 'chinelo'),
(4, 'Thiago Trevoso', 'soldadoribeiro@email.com', 'therian'),
(5, 'Arthur games', 'thebestplayer@email.com', 'escala7por0');

INSERT INTO movie (movie_name, `year`, duration) VALUES
('A volta dos que não foram', '2002-01-01', '01:45:00'),
('As longas tranças do careca', '1999-05-10', '23:59:59'),
('Poeira em alto mar', '2013-07-15', '00:10:00'),
('Fogo na caixa d`agua', '2019-03-20', '10:43:03'),
('Interestelar', '2014-11-6', '02:49:00');

INSERT INTO actor (`name`) VALUES
('Roberto Carlos'),
('O Pedra'),
('Ivete Sangalo'),
('Relampago Marquinhos'),
('Matthew McConaughey');

INSERT INTO category (`name`) VALUES
('Terror'),
('Ficção'),
('Romance'),
('Drama'),
('Ficção');

INSERT INTO watched (`data`, `status`, `user_id`, movie_id) VALUES
('2002-07-20', TRUE, 1, 1),
('1999-05-10', FALSE, 2, 2),
('2025-03-10', FALSE, 3, 3),
('2025-03-04', TRUE, 4, 4),
('2025-02-01', TRUE, 5, 5),
('2025-03-18', TRUE, 1, 3),
('2025-01-02', FALSE, 2, 4),
('2020-09-28', TRUE, 3, 5),
('2007-05-30', TRUE, 4, 1),
('2003-05-30', FALSE, 5, 2);

INSERT INTO actor_movie (actor_id, movie_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(1, 2),
(2, 3),
(3, 4),
(4, 5),
(5, 1);

INSERT INTO category_movie (category_id, movie_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(1, 3),
(2, 4),
(3, 5),
(4, 1),
(5, 2);

SELECT movie_name FROM movie;

SELECT email FROM `user`;

SELECT `user`.`name`, plan.`name` FROM `user`
JOIN plan ON `user`.plan_id = plan.id;

SELECT movie.movie_name FROM watched
JOIN movie ON watched.movie_id = movie.id
WHERE watched.`user_id` = 3;

SELECT movie.movie_name FROM category_movie
JOIN movie ON category_movie.movie_id = movie.id
JOIN category ON category_movie.category_id = category.id
WHERE category.`name` = 5;

SELECT movie.movie_name FROM actor_movie
JOIN movie ON actor_movie.movie_id = movie.id
JOIN actor ON actor_movie.actor_id = actor.id
WHERE actor.`name` = 2;

SELECT actor.`name` FROM actor_movie
JOIN actor ON actor_movie.actor_id = actor.id
JOIN movie ON actor_movie.movie_id = movie.id
WHERE movie.movie_name = 3;

