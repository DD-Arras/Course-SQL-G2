CREATE SCHEMA IF NOT EXISTS construction;

DROP TABLE IF EXISTS construction.projets CASCADE;
DROP TABLE IF EXISTS construction.employes CASCADE;
DROP TABLE IF EXISTS construction.taches CASCADE;
DROP TABLE IF EXISTS construction.affectations CASCADE;

CREATE TABLE construction.projets (
    projet_id INT PRIMARY KEY,
    nom VARCHAR(100),
    client VARCHAR(100),
    date_debut DATE,
    date_fin DATE
);

CREATE TABLE construction.employes (
    employe_id INT PRIMARY KEY,
    nom VARCHAR(100),
    prenom VARCHAR(100),
    poste VARCHAR(50),
    date_embauche DATE
);

CREATE TABLE construction.taches (
    tache_id INT PRIMARY KEY,
    projet_id INT,
    nom_tache VARCHAR(100),
    description VARCHAR(255),
    date_debut DATE,
    date_fin DATE,
    FOREIGN KEY (projet_id) REFERENCES construction.projets(projet_id)
);

CREATE TABLE construction.affectations (
    affectation_id INT PRIMARY KEY,
    employe_id INT,
    tache_id INT,
    heures_travaillees INT,
    FOREIGN KEY (employe_id) REFERENCES construction.employes(employe_id),
    FOREIGN KEY (tache_id) REFERENCES construction.taches(tache_id)
);

INSERT INTO construction.projets (projet_id, nom, client, date_debut, date_fin) VALUES
(1, 'Construction d’un immeuble', 'Client A', '2024-01-01', '2024-12-31'),
(2, 'Aménagement de bureau', 'Client B', '2023-06-15', '2024-03-01'),
(3, 'Pont suspendu', 'Client C', '2024-04-10', '2025-10-15'),
(4, 'Rénovation maison', 'Client D', '2024-08-20', '2025-01-30');

INSERT INTO construction.employes (employe_id, nom, prenom, poste, date_embauche) VALUES
(1, 'Dupont', 'Jean', 'Ingénieur', '2020-05-01'),
(2, 'Martin', 'Sophie', 'Chef de chantier', '2018-03-22'),
(3, 'Lemoine', 'Pierre', 'Architecte', '2021-07-12'),
(4, 'Bernard', 'Claire', 'Technicien', '2019-10-30'),
(5, 'Durand', 'Luc', 'Maçon', '2022-01-15');

INSERT INTO construction.taches (tache_id, projet_id, nom_tache, description, date_debut, date_fin) VALUES
(1, 1, 'Fondations', 'Construction des fondations du bâtiment', '2024-01-05', '2024-02-28'),
(2, 1, 'Élévation des murs', 'Montage des murs extérieurs', '2024-03-01', '2024-06-15'),
(3, 2, 'Installation électricité', 'Mise en place du réseau électrique', '2023-06-20', '2023-09-10'),
(4, 2, 'Peinture', 'Peinture intérieure des locaux', '2023-09-15', '2023-12-01'),
(5, 3, 'Plans de conception', 'Création des plans du pont', '2024-04-12', '2024-05-30'),
(6, 4, 'Toiture', 'Réparation de la toiture', '2024-08-25', '2024-09-30');

INSERT INTO construction.affectations (affectation_id, employe_id, tache_id, heures_travaillees) VALUES
(1, 1, 1, 150),
(2, 2, 1, 120),
(3, 3, 5, 200),
(4, 4, 4, 100),
(5, 5, 2, 180),
(6, 1, 3, 160),
(7, 4, 6, 80);
