# TP - JOIN - papier

Le but de ce TP est de confirmer sa bonne compréhension des jointures.

De plus, cela permet de se heureter à la nouvelle dynamique de faire des requêtes sur papier.

## Présentation du schéma

Voici le schéma du schéma, ainsi que les premières lignes de chaque table.

![construction_chart](/TP/Ecrit/images/construction_chart.png)

Table projets

![projets](/TP/Ecrit/images/projet.png)

Table employes

![projets](/TP/Ecrit/images/employes.png)

Table taches

![projets](/TP/Ecrit/images/taches.png)

Table affectations

![projets](/TP/Ecrit/images/affectations.png)

## Questions

1) Formulez une requête donnant les noms et prénoms des employés au poste de 'Chef de chantier'.

2) Formulez une requête donnant toutes les taches finies le 15 Fevrier 2022.

3) Formulez une requête donnant tous les projets en cours à la date du 8 Janvier 2024.

4) Dessiner la table résultante de la requête suivante, avec les connaissances que vous avez sur les tables :

```sql
SELECT e.nom AS nom,
    t.nom_tache AS tache,
    a.heures_travaillees
FROM affectations AS a
JOIN employes AS e
ON a.employe_id = e.employe_id
JOIN taches AS t
ON a.tache_id = t.tache_id
WHERE a.heures_travaillees < 150
```

5) Formulez une requête donnant tous les noms des tâches pour le client 'Client A'.

6) Formulez une requête donnant la dernière tâche finie sur le projet 'Pont suspendu'.

7) Formulez une requête donnant la date d'embauche de l'employé qui a le moins travaillé.

8) Formulez une requête donnant le nom et la description des tâches faites par 'Emile' 'Durand'.

9) Formulez une requête donnant les employés travaillant sur le projet "Construction d'un immeuble".

<details>
    <summary> Indice </summary>
    <a href="https://stackoverflow.com/questions/1586560/how-do-i-escape-a-single-quote-in-sql-server">Echapper un apostrophe</a>
</details>

10) Formulez une requête donnant les employés embauchés après la date de fin du projet d'id 8.

11) Formulez une requête donnant les postes demandés poue les taches du 22 Aout 2024. 

12) Expliquez, en quelques mots, l'architecture Client - Serveur.

13) Quelle est la relation entre les tables employes et taches ?

14) Pourrait-on calculer le nombre d'heures travaillées par employé ?

## Vérification

vous pouvez importer ce ficher [construction.sql](/TP/Ecrit/data/construction.sql) et vérifier les questions sur lesquelles vous avez un doute.
