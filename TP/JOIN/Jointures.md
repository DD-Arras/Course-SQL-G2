# TP - Jointures

Le but de ce TP est de comprendre les jointures. Leurs interêts et comment les implémenter.

On commence à associer plusieurs tables.

## Mise en place des ressources du TP

Dans votre base de données, créez un nouveau schéma, nommé `jointures`.

Un schéma, c'est une sorte de sous-dossier au sain d'une base

Voici la procédure à suivre : `Schémas -> clic droit -> Créer -> Schéma`.

![create_schema_path](/TP/JOIN/images/create_schema_path.png)

![create_schema_dialog](/TP/JOIN/images/create_schema_dialog.png)

## Relation entreprises - employés

Nous allons importer deux tables, en une seule fois, en utilisant le format natif `.sql`.

Télechargez ce fichier : [entreprise.sql](/TP/JOIN/data/entreprise.sql).

Il a le même format que le fichier de requêtes que vous avez peut-être sauvegardé hier. Il est donc composé, lui aussi, de requête SQL.

Ces requêtes (qui ne sont pas à apprendre), permettent de créer deux tables, `entreprises` et `employés`, avant de les remplir.

Pour lancer ces requêtes, suivez ces étapes :
 - assurez vous de bien vous placer dans le nouveau schéma que vous avez créé.
 - ouvrez l'éditeur de requêtes.
 - Appuyez sur le bouton "Ouvrir fichier" (ou utilisez le raccourci `Ctrl + O`).
 - Rentrez le fichier téléchargé.
 - Appuyez sur le bouton "Exécuter" (ou utilisez le raccourci `F5`).

Vos deux nouvelles tables sont visibles après un raffraichissement du schéma (`jointures -> clic droit -> Raffraichir`).

![import_sql](/TP/JOIN/videos/import_sql.gif)

Voici le schéma UML simbolisant ces deux tables :

![entreprise_chart](/TP/JOIN/images/entreprise_chart.png)

#### Exercices

Est-ce facile, en regardant simplement les tables, de dire quels sont les employés de chaque entreprise ?

Pour faciliter cette compréhension, essayez la requête suivante :

```sql
SELECT * FROM jointures.entreprises 
JOIN jointures.employes 
ON jointures.entreprises.id = jointures.employes.entreprise_id
```

C'est un peu plus facile de s'y retrouver.

Cependant, si vous chercher à obtenir seulement le nom de l'entreprise, pour chaque employé, vous allez rencontrer un problème...

```sql
SELECT nom FROM jointures.entreprises 
JOIN jointures.employes 
ON jointures.entreprises.id = jointures.employes.entreprise_id
```

1) Essayez d'utiliser la diapositive 29 du [cours](https://docs.google.com/presentation/d/1TKlmLLidOdDczgt6kVVT4sk8SPTT3wJeAhqYRh8FDHs/edit?usp=sharing) pour sélectionner le nom de chaque employé, et le nom de l'entreprise à laquelle il appartient.

<!-- ```sql
SELECT ent.nom, emp.nom FROM jointures.entreprises AS ent
JOIN jointures.employes AS emp
ON ent.id = emp.entreprise_id
``` -->

Pour les questions suivantes, Formulez des requêtes SQL pour obtenir le résultat demandé.

2) Quel est le nom de l'entreprise de `Nancy Jones` ?

<!-- ```sql
SELECT ent.nom, FROM jointures.entreprises AS ent
JOIN jointures.employes AS emp
ON ent.id = emp.entreprise_id
WHERE emp.nom = 'Jones'
AND emp.prenom = 'Nancy'
``` -->

3) Quels sont les noms et prénoms des employés de `General Electric` ?

<!-- ```sql
SELECT emp.nom, emp.prenom FROM jointures.entreprises AS ent
JOIN jointures.employes AS emp
ON ent.id = emp.entreprise_id
WHERE ent.nom = 'General Electric'
``` -->

> Indication : Pour faciliter la lecture de la table de résultat, vous pouvez aussi donner un alias dans vos noms de colonnes.
<details>
    <summary> Afficher la requête </summary>
    SELECT ent.nom AS nom_entreprise, emp.nom AS nom_employe
    FROM jointures.entreprises AS ent
    JOIN jointures.employes AS emp
    ON ent.id = emp.entreprise_id
</details>

4) Ou se situe l'entreprise qui possède l'employé avec le meilleur salaire ?

<!-- ```sql
SELECT ent.ville FROM jointures.entreprises AS ent
JOIN jointures.employes AS emp
ON ent.id = emp.entreprise_id
ORDER BY salaire DESC
LIMIT 1
``` -->

5) Parmis les employés situés à `Atlanta`, lequel est le moins bien payé, et quelle est sont entreprise ?

<!-- ```sql
SELECT ent.nom, emp.nom FROM jointures.entreprises AS ent
JOIN jointures.employes AS emp
ON ent.id = emp.entreprise_id
WHERE ent.ville = 'Atlanta'
ORDER BY salaire ASC
LIMIT 1
``` -->

## Relations Spotify

Nous allons nous interesser à un autre ensemble de tables, celui-ci un peu plus complexe.

De la même manière que vous avez importé les tables de la relation entreprises - employés, importez le fichier [spotify.sql](/TP/JOIN/data/spotify.sql).

Vous avez alors 6 nouvelles tables.

Voici le schéma UML des tables importées :

![spotify_chart](/TP/JOIN/images/spotify_chart.png)

#### Exercices

Formulez des requêtes SQL pour obtenir le résultat demandé.

1) En réalisant une jointure entre `groupes` et `albums`, quel est le nom du groupe ayant fait l'album `For All The Dogs` ?

2) Quand est-ce que le groupe `Animals as Leaders` a sorti des albums ?

3) En faisant maintenant une jointure entre `groupes` et `musiciens`, quels sont les noms et prénoms des membres du groupe `GIMS` ou `Billie Eilish` ?

4) En quelle année `Djuna` `Ghandi` a t-il commencé sa carrière ?

5) En utilisant la jointure appropriée, quel est le nom de l'album du titre `LUNCH` ?

6) Quel label propose le son le plus long disponible sur la base de données ?

Pour associer chaque musicien a ses instruments, nous allons effectuer une double jointure. Essayez cette requête :

```sql
SELECT m.prenom, m.nom, i.nom AS instrument FROM jointures.link_musiciens_instruments AS l
JOIN jointures.musiciens AS m
ON l.musicien_id = m.id
JOIN jointures.instruments AS i
ON l.instrument_id = i.id
```

On peut ainsi cumuler le nombre de jointures, autant que nous en avons besoin.

> Attention ! Sur des tables de taille importante, une jointure peut être couteuse et donc prendre du temps. Pensez à ne réaliser que les jointures qui sont nécessaires à votre requête.

Formulez une requêtes pour les questions suivantes :

7) Quels musiciens utilisent leur voix ?

Les requêtes suivantes utilisent plusieurs jointures pour aboutir... A vous de determiner lesquelles.

8) Quels groupes utilisent une batterie ?

9) Quel groupe possède la chanson avec le moins de `streams` ?

10) Quels sont les instruments utilisés par les compositeurs des sons ?

11) Quels sont les albums dans lequels il y a des paroles, et dont le groupe a été créé avant 2008 ?

12) Pourquoi n'est il pas possible, avec vos connaissance actelles, de formuler une requête répondant à la question suivante : Quel est la chanson avec le plus de streams, parmis les chansons composée par le musicien le plus jeune ?