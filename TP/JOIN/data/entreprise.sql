--------------------------------------------------------------
-- Inspiré de
-- Practical SQL: A Beginner's Guide to Storytelling with Data
-- by Anthony DeBarros

-- Chapter 6 nom Examples
--------------------------------------------------------------

CREATE SCHEMA IF NOT EXISTS jointures;

DROP TABLE IF EXISTS jointures.entreprises;
DROP TABLE IF EXISTS jointures.employes;

CREATE TABLE jointures.entreprises (
    id serial PRIMARY KEY,
    nom varchar(100),
    ville varchar(100)
);

CREATE TABLE jointures.employes (
    id serial PRIMARY KEY,
    prenom varchar(100),
    nom varchar(100),
    salaire integer,
    entreprise_id integer REFERENCES jointures.entreprises (id)
);

INSERT INTO jointures.entreprises (nom, ville)
VALUES
    ('First Data', 'Atlanta'),
    ('Grey Television', 'Atlanta'),
    ('General Electric', 'Boston');

INSERT INTO jointures.employes (prenom, nom, salaire, entreprise_id)
VALUES
    ('Nancy', 'Jones', 62500, 1),
    ('Lee', 'Smith', 59300, 1),
    ('Soo', 'Nguyen', 83000, 2),
    ('Janet', 'King', 95000, 3);
