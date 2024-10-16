CREATE SCHEMA IF NOT EXISTS jointures;

DROP TABLE IF EXISTS jointures.groupes CASCADE;
DROP TABLE IF EXISTS jointures.musiciens CASCADE;
DROP TABLE IF EXISTS jointures.albums CASCADE;
DROP TABLE IF EXISTS jointures.sons CASCADE;
DROP TABLE IF EXISTS jointures.instruments CASCADE;
DROP TABLE IF EXISTS jointures.link_musiciens_instruments CASCADE;


CREATE TABLE jointures.groupes (
    id serial PRIMARY KEY,
    nom varchar(100),
    date_creation date
) ;

CREATE TABLE jointures.musiciens (
    id serial PRIMARY KEY,
    prenom varchar(100),
    nom varchar(100),
    date_naissance date, 
    groupe_id integer REFERENCES jointures.groupes (id)
) ;

CREATE TABLE jointures.albums (
    id serial PRIMARY KEY,
    nom varchar(100),
    date_sortie date,
    label varchar(100),
    groupe_id integer REFERENCES jointures.groupes (id)
) ;

CREATE TABLE jointures.sons (
    id serial PRIMARY KEY,
    nom varchar(100),
    numero integer,
    duree double precision,
    streams integer,
    album_id integer REFERENCES jointures.albums (id),
    compositeur_id integer REFERENCES jointures.musiciens (id)
) ;

CREATE TABLE jointures.instruments (
    id serial PRIMARY KEY,
    nom varchar(100)
) ;

CREATE TABLE jointures.link_musiciens_instruments (
    id serial PRIMARY KEY,
    musicien_id integer REFERENCES jointures.musiciens (id),
    instrument_id integer REFERENCES jointures.instruments (id)
) ;

INSERT INTO jointures.groupes (nom, date_creation)
VALUES
    ('GIMS', '2002-01-01'),
    ('Billie Eilish', '2016-03-01'),
    ('Drake', '2002-01-01'),
    ('Animals as Leaders', '2007-01-01'),
    ('Beyond Creation', '2005-01-01');
;
INSERT INTO jointures.musiciens (prenom, nom, date_naissance, groupe_id)
VALUES
    ('Djuna', 'Ghandi', '1986-05-05', 1),
    ('Billie', 'O''Connell', '2001-12-18', 2),
    ('Finneas', 'O''Connell', '1997-07-30', 2),
    ('Aubrey', 'Graham', '1986-10-24', 3),
    ('Tosin', 'Abasi', '1983-01-07', 4),
    ('Javier', 'Reyes', null, 4),
    ('Matt', 'Garstka', null, 4),
    ('Simon', 'Girard', null, 5),
    ('Kevin', 'Chartré', null, 5),
    ('Philippe', 'Boucher', null, 5),
    ('Hugo', 'Doyon-Karout', null, 5)

;

INSERT INTO jointures.albums (nom, date_sortie, label, groupe_id)
VALUES
    ('SOIS PAS TIMIDE', '2024-07-19', 'GÉANTE ROUGE', 1),
    ('SPIDER', '2024-05-10', 'GÉANTE ROUGE', 1),
    ('Hit Me Hard and Soft', '2024-05-17', 'Darkroom', 2),
    ('For All The Dogs', '2023-10-06', 'OVO', 3),
    ('The Joy of Motion', '2014-03-24', 'Sumerian', 4),
    ('The Aura', '2011-01-01', 'Season of Mist', 5), 
    ('Algorythm', '201-05-12', 'Season of Mist', 5)
;
INSERT INTO jointures.sons (nom, numero, duree, streams, album_id, compositeur_id)
VALUES
    ('SOIS PAS TIMIDE', 1, 2.75, 35323357, 1, 1),
    ('SPIDER', 1, 3.13, 95034094, 2, 1),
    ('BIRDS OF A FEATHER', 4, 3.5, 916170864, 3, 2),
    ('LUNCH', 2, 2.98, 476308050, 3, 2),
    ('Rich Baby Daddy', 20, 5.32, 425328256, 4, 5),
    ('IDGAF', 7, 4.33, 444667316, 4, 5),
    ('What Would Pluto Do', 15, 3.03, 17837349, 4, 5),
    ('Physical Education', 5, 4.68, 20059431, 5, 5), 
    ('The Woven Web', 10, 4.12, 10928854, 5,  5),
    ('Omnipresent Perception', 4, 6.18, 3029723, 6, 8),
    ('Coexistence', 2, 7.6, 1053303, 6, 9),
    ('Entre Suffrage et Mirage', 2, 4.33, 429029, 7, 8)
;
INSERT INTO jointures.instruments (nom)
VALUES
    ('voix'),
    ('guitare'),
    ('clavier'),
    ('basse'),
    ('batterie')
;
INSERT INTO jointures.link_musiciens_instruments (musicien_id, instrument_id)
VALUES 
    (1, 1),
    (2, 1),
    (2, 2),
    (2, 3),
    (3, 1),
    (3, 2),
    (3, 3),
    (4, 1),
    (5, 2),
    (6, 2),
    (7, 5),
    (8, 1),
    (8, 2),
    (9, 1),
    (9, 2),
    (10, 5),
    (11, 4)
;
