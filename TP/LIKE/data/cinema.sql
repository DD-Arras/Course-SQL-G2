CREATE SCHEMA IF NOT EXISTS cinema;

DROP TABLE IF EXISTS cinema.films CASCADE;
DROP TABLE IF EXISTS cinema.realisateurs CASCADE;
DROP TABLE IF EXISTS cinema.acteurs CASCADE;
DROP TABLE IF EXISTS cinema.casting CASCADE;

CREATE TABLE cinema.realisateurs (
    realisateur_id INT PRIMARY KEY,
    nom VARCHAR(100),
    prenom VARCHAR(100),
    nationalite VARCHAR(50)
);

CREATE TABLE cinema.films (
    film_id INT PRIMARY KEY,
    realisateur_id INT,
    titre VARCHAR(100),
    genre VARCHAR(50),
    date_sortie DATE,
    FOREIGN KEY (realisateur_id) REFERENCES cinema.realisateurs(realisateur_id)
);

CREATE TABLE cinema.acteurs (
    acteur_id INT PRIMARY KEY,
    nom VARCHAR(100),
    prenom VARCHAR(100),
    date_naissance DATE
);

CREATE TABLE cinema.casting (
    casting_id INT PRIMARY KEY,
    film_id INT,
    acteur_id INT,
    role VARCHAR(100),
    FOREIGN KEY (film_id) REFERENCES cinema.films(film_id),
    FOREIGN KEY (acteur_id) REFERENCES cinema.acteurs(acteur_id)
);

INSERT INTO cinema.realisateurs (realisateur_id, nom, prenom, nationalite) VALUES
(1, 'Nolan', 'Christopher', 'Britannique'),
(2, 'Tarantino', 'Quentin', 'Américain'),
(3, 'Chazelle', 'Damien', 'Américain'),
(4, 'Scott', 'Ridley', 'Britannique'),
(5, 'Cameron', 'James', 'Canadien'),
(6, 'Wachowski', 'Lana', 'Américaine'),
(7, 'Iñárritu', 'Alejandro', 'Mexicain'),
(8, 'Fincher', 'David', 'Américain'),
(9, 'Scorsese', 'Martin', 'Américain, Italien');

INSERT INTO cinema.films (film_id, titre, genre, date_sortie, realisateur_id) VALUES
(1, 'Inception', 'Science Fiction', '2010-07-16', 1),
(2, 'The Dark Knight', 'Action', '2008-07-18', 1),
(3, 'Interstellar', 'Science Fiction', '2014-11-07', 1),
(4, 'Django Unchained', 'Western', '2012-12-25', 2),
(5, 'Pulp Fiction', 'Crime', '1994-10-14', 2),
(6, 'La La Land', 'Comédie musicale', '2016-12-09', 3),
(7, 'Gladiator', 'Historique', '2000-05-05', 4),
(8, 'Titanic', 'Romance', '1997-12-19', 5),
(9, 'The Matrix', 'Science Fiction', '1999-03-31', 6),
(10, 'The Revenant', 'Aventure', '2015-12-25', 7),
(11, 'Fight Club', 'Drame', '1999-10-15', 8),
(12, 'The Wolf of Wall Street', 'Biographie', '2013-12-25', 9),
(13, 'Once Upon a Time in Hollywood', 'Comédie dramatique', '2019-07-26', 2);

INSERT INTO cinema.acteurs (acteur_id, nom, prenom, date_naissance) VALUES
(1, 'DiCaprio', 'Leonardo', '1974-11-11'),
(2, 'Bale', 'Christian', '1974-01-30'),
(3, 'Pitt', 'Brad', '1963-12-18'),
(4, 'Foxx', 'Jamie', '1967-12-13'),
(5, 'Stone', 'Emma', '1988-11-06'),
(6, 'Gosling', 'Ryan', '1980-11-12'),
(7, 'Crowe', 'Russell', '1964-04-07'),
(8, 'Reeves', 'Keanu', '1964-09-02'),
(9, 'Winslet', 'Kate', '1975-10-05'),
(10, 'Hardy', 'Tom', '1977-09-15'),
(11, 'Norton', 'Edward', '1969-08-18'),
(12, 'Robbie', 'Margot', '1990-07-02');

INSERT INTO cinema.casting (casting_id, film_id, acteur_id, role) VALUES
(1, 1, 1, 'Dom Cobb'),
(2, 2, 2, 'Bruce Wayne _ Batman'),
(3, 3, 1, 'Cooper'),
(4, 4, 3, 'Calvin Candie'),
(5, 4, 4, 'Django'),
(6, 5, 3, 'Butch Coolidge'),
(7, 6, 5, 'Mia Dolan'),
(8, 6, 6, 'Sebastian Wilder'),
(9, 7, 7, 'Maximus'),
(10, 8, 1, 'Jack Dawson'),
(11, 8, 9, 'Rose DeWitt Bukater'),
(12, 9, 8, 'Neo'),
(13, 10, 1, 'Hugh Glass'),
(14, 11, 3, 'Tyler Durden'),
(15, 11, 11, 'Le Narrateur'),
(16, 12, 1, 'Jordan Belfort'),
(17, 13, 1, 'Rick Dalton'),
(18, 13, 12, 'Sharon Tate');