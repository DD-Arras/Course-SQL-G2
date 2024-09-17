# TP - JOIN - papier

Le but de ce TP est de confirmer sa bonne compréhension des jointures.

De plus, cela permet de se heureter à la nouvelle dynamique de faire des requêtes sur papier.

## Présentation du schéma

Voici le schéma des tables, ainsi que les premières lignes de chaque table.

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

```sql
SELECT nom, prenom FROM employes
WHERE poste = 'Chef de chantier'
```

2) Formulez une requête donnant toutes les taches finies au 15 Fevrier 2022.
>(OLD) 2) Formulez une requête donnant toutes les taches associées au 'Client B'.
```sql
SELECT * FROM tache
WHERE date_fin <= '2024-02-15'
```

3) Formulez une requête donnant tous les projets en cours à la date du 8 Janvier 2024.

```sql
SELECT * FROM projets
WHERE date_debut <= '2024-01-08'
AND date_fin >= '2024-01-08'
```

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

<table>
    <thead>
        <th scope="col">nom</th>
        <th scope="col">tache</th>
        <th scope="col">heures_travaillees</th>
    </thead>
    <tbody>
        <tr>
            <td>Martin</td>
            <td>Fondations</td>
            <td>120</td>
        </tr>
    </tbody>
</table>

1) Formulez une requête donnant tous les noms des tâches pour le client 'Client A'.

```sql
SELECT t.nom_tache
FROM taches AS t
JOIN projets AS p
ON p.projet_id = t.projet_id
WHERE p.client = 'Client A'
```

6) Formulez une requête donnant la dernière tâche finie sur le projet 'Pont suspendu'.

```sql
SELECT t.nom_tache
FROM taches AS t
JOIN projets AS p
ON p.projet_id = t.projet_id
WHERE p.nom = 'Pont suspendu'
ORDER BY t.date_fin DESC
LIMIT 1
```

7) Formulez une requête donnant la date d'embauche de l'employé qui a le moins travaillé.

```sql
SELECT e.date_embauche
FROM employes AS e
JOIN affectation AS a
ON a.employe_id = e.employe_id
ORDER BY a.heures_travaillees ASC
LIMIT 1
```
> Cette requête ne répond pas vraiment à la question, qui est mal posée. En effet, on a besoin d'une fonction d'aggrégation pour la résoudre :

```sql
SELECT e.date_embauche
FROM employes AS e
JOIN affectation AS a
ON a.employe_id = e.employe_id
GROUP BY e.employe_id
ORDER BY SUM(a.heures_travaillees) ASC
LIMIT 1
```

8) Formulez une requête donnant le nom et la description des tâches faites par 'Emile' 'Durand'.

```sql
SELECT t.nom_tache, t.description
FROM taches AS t
JOIN affectations AS a
ON t.tache_id = a.tache_id
JOIN employes AS e
ON e.employe_id = a.employe_id
WHERE e.prenom = 'Emile'
AND e.nom = 'Durand'
```

9) Formulez une requête donnant les employés travaillant sur le projet "Construction d'un immeuble".

<details>
    <summary> Indice </summary>
    <a href="https://stackoverflow.com/questions/1586560/how-do-i-escape-a-single-quote-in-sql-server">Echapper un apostrophe</a>
</details>

```sql
SELECT DISTINCT e.nom
FROM taches AS t
JOIN affectations AS a
ON t.tache_id = a.tache_id
JOIN employes AS e
ON e.employe_id = a.employe_id
JOIN projets AS p
ON p.projet_id = t.projet_id
WHERE p.nom = 'Construction d''un immeuble'
```

10) Formulez une requête donnant les employés embauchés après la date de fin du projet d'id 8.

> Cette question aussi est mal posée, on a besoin des requêtes intégrées pour la résoudre.

```sql
SELECT nom
FROM employes
WHERE date_embauche > (
    SELECT date_fin
    FROM projets
    WHERE id = 8
)
```

11) Formulez une requête donnant les postes demandés poue les taches du 22 Aout 2024. 

```sql
SELECT DISTINCT e.poste
FROM taches AS t
JOIN affectations AS a
ON t.tache_id = a.tache_id
JOIN employes AS e
ON e.employe_id = a.employe_id
WHERE t.date_debut <= '2024-08-22'
AND t.date_fin >= '2024-08-22'
```

12) Expliquez, en quelques mots, l'architecture Client - Serveur.

Les **clients** envoient des **requêtes** vers un **serveur**, qui **calcule** des **réponses** qui sont renovoyées aux clients.

13) Quelle est la relation entre les tables `employes` et `taches` ?

Les deux tables possèdent une relation ManyToOne avec la table `affectations` : on peut dire que `employes` et `taches` ont une relation ManyToMany, et que la table `affectations` sert de table de liaison dans cette relation.

14) Pourrait-on calculer le nombre d'heures travaillées par employé ?

On pourrait le faire en utilisant la fonction d'aggrégation SUM :

```sql
SELECT e.nom, SUM(a.heures_travaillees)
FROM employes AS e
JOIN affectations AS a
ON e.employe_id = a.employe_id
GROUP BY e.nom
```

## Vérification

vous pouvez importer ce ficher [construction.sql](/TP/Ecrit/data/construction.sql) et vérifier les questions sur lesquelles vous avez un doute.
