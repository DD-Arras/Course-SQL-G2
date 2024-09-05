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

Il a le même format que le fichier de requêtes que vous avez peut-être sauvegardé hier. Il est donc composé, lui aussi, de requêtes SQL.

Ces requêtes (qui ne sont pas à apprendre), permettent de créer deux tables, `entreprises` et `employes`, avant de les remplir.

Pour lancer ces requêtes, suivez ces étapes :
 - Assurez vous de bien vous placer dans le nouveau schéma que vous avez créé.
 - Ouvrez l'éditeur de requêtes.
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

```sql
SELECT ent.nom, emp.nom FROM jointures.entreprises AS ent
JOIN jointures.employes AS emp
ON ent.id = emp.entreprise_id
``` 

Pour les questions suivantes, Formulez des requêtes SQL pour obtenir le résultat demandé.

2) Quel est le nom de l'entreprise de `Nancy` `Jones` ?

```sql
SELECT ent.nom, FROM jointures.entreprises AS ent
JOIN jointures.employes AS emp
ON ent.id = emp.entreprise_id
WHERE emp.nom = 'Jones'
AND emp.prenom = 'Nancy'
``` 

3) Quels sont les noms et prénoms des employés de `General Electric` ?

```sql
SELECT emp.nom, emp.prenom FROM jointures.entreprises AS ent
JOIN jointures.employes AS emp
ON ent.id = emp.entreprise_id
WHERE ent.nom = 'General Electric'
``` 

> Indication : Pour faciliter la lecture de la table de résultat, vous pouvez aussi donner un alias dans vos noms de colonnes.
<details>
    <summary><i> Afficher un exemple de requête </i></summary>
    <code>SELECT ent.nom AS nom_entreprise, emp.nom AS nom_employe
    FROM jointures.entreprises AS ent
    JOIN jointures.employes AS emp
    ON ent.id = emp.entreprise_id</code>
</details>

4) Ou se situe l'entreprise qui possède l'employé avec le meilleur salaire ?

```sql
SELECT ent.ville FROM jointures.entreprises AS ent
JOIN jointures.employes AS emp
ON ent.id = emp.entreprise_id
ORDER BY salaire DESC
LIMIT 1
``` 

5) Parmis les employés situés à `Atlanta`, lequel est le moins bien payé, et quelle est son entreprise ?

```sql
SELECT ent.nom, emp.nom FROM jointures.entreprises AS ent
JOIN jointures.employes AS emp
ON ent.id = emp.entreprise_id
WHERE ent.ville = 'Atlanta'
ORDER BY salaire ASC
LIMIT 1
```

## Relations Spotify

Nous allons nous interesser à un autre ensemble de tables, celui-ci un peu plus complexe.

De la même manière que vous avez importé les tables de la relation entreprises - employés, importez le fichier [spotify.sql](/TP/JOIN/data/spotify.sql).

Vous avez alors 6 nouvelles tables.

Voici le schéma UML des tables importées :

![spotify_chart](/TP/JOIN/images/spotify_chart.png)

#### Exercices

Formulez des requêtes SQL pour obtenir le résultat demandé.

1) En réalisant une jointure entre `groupes` et `albums`, quel est le nom du groupe ayant fait l'album `For All The Dogs` ?

```sql
SELECT g.nom FROM jointures.groupes AS g
JOIN jointures.albums AS a
ON g.id = a.groupe_id
WHERE a.nom = 'For All The Dogs'
``` 

3) Quand est-ce que le groupe `Animals as Leaders` a sorti des albums ?

```sql
SELECT a.sortie FROM jointures.groupes AS g
JOIN jointures.albums AS a
ON g.id = a.groupe_id
WHERE g.nom = 'Animals as Leaders'
``` 

4) En faisant maintenant une jointure entre `groupes` et `musiciens`, quels sont les noms et prénoms des membres des groupe `GIMS` et `Billie Eilish` ?

```sql
SELECT a.sortie FROM jointures.groupes AS g
JOIN jointures.musiciens AS m
ON g.id = m.groupe_id
WHERE g.nom = 'GIMS'
OR g.nom = 'Billie Eilish'
``` 

5) En quelle année `Djuna` `Ghandi` a t-il commencé sa carrière ?

```sql
SELECT g.date_creation FROM jointures.groupes AS g
JOIN jointures.musiciens AS m
ON g.id = m.groupe_id
WHERE m.nom = 'Ghandi'
AND m.prenom = 'Djuna'
``` 

6) En utilisant la jointure appropriée, quel est le nom de l'album du titre `LUNCH` ?

```sql
SELECT a.nom FROM jointures.albums AS a
JOIN jointures.sons AS s
ON a.id = s.album_id
WHERE s.nom = 'LUNCH'
```

8) Quels sont les titres des singles : les sons avec un nom identique à leur album ?

```sql
SELECT s.nom FROM jointures.albums AS a
JOIN jointures.sons AS s
ON a.id = s.album_id
WHERE s.nom = a.nom
```

9) Quel label propose le son le plus long disponible sur la base de données ?

```sql
SELECT a.label FROM jointures.albums AS a
JOIN jointures.sons AS s
ON a.id = s.album_id
ORDER BY duree DESC
LIMIT 1
```

Pour associer chaque musicien a ses instruments, nous allons effectuer une double jointure. Essayez cette requête :

```sql
SELECT m.prenom, m.nom, i.nom AS instrument
FROM jointures.link_musiciens_instruments AS l
JOIN jointures.musiciens AS m
ON l.musicien_id = m.id
JOIN jointures.instruments AS i
ON l.instrument_id = i.id
```

On peut ainsi cumuler le nombre de jointures, autant que nous en avons besoin.

> Attention ! Sur des tables de taille importante, une jointure peut être couteuse et donc prendre du temps. Pensez à ne réaliser que les jointures qui sont nécessaires à votre requête.

Formulez une requêtes pour las questions suivantes :

8) Quels musiciens utilisent leur voix ?

```sql
SELECT m.prenom, m.nom
FROM jointures.link_musiciens_instruments AS l
JOIN jointures.musiciens AS m
ON l.musicien_id = m.id
JOIN jointures.instruments AS i
ON l.instrument_id = i.id
WHERE i.name = 'voix'
```

Les requêtes suivantes utilisent plusieurs jointures pour aboutir... A vous de déterminer lesquelles.

9) Quels groupes utilisent une batterie ?

```sql
SELECT g.nom, 
FROM jointures.link_musiciens_instruments AS l
JOIN jointures.musiciens AS m
ON l.musicien_id = m.id
JOIN jointures.instruments AS i
ON l.instrument_id = i.id
JOIN jointures.groupes AS g
ON g.id = m.groupe_id
WHERE i.name = 'batterie'
```

10) Quel groupe possède le son avec le plus de `streams` ?

```sql
SELECT g.nom
FROM jointures.groupes AS g
JOIN jointures.albums AS a
ON g.id = a.groupe_id
JOIN jointures.sons AS s
ON a.id = s.album_id
ORDER BY s.streams
LIMIT 1
```

11) Quels sont les instruments utilisés par les compositeurs de chaque sons ? Affichez Le titre, le nom du compositeur, et ses instruments.

```sql
SELECT m.prenom, m.nom, i.nom AS instrument, s.nom AS son
FROM jointures.link_musiciens_instruments AS l
JOIN jointures.musiciens AS m
ON l.musicien_id = m.id
JOIN jointures.instruments AS i
ON l.instrument_id = i.id
JOIN jointures.sons AS s
ON m.id = s.compositeur_id
```

12) Quels sont les albums dans lequels il y a des paroles, et dont le groupe a été créé avant 2008 ?

```sql
SELECT a.nom
FROM jointures.link_musiciens_instruments AS l
JOIN jointures.musiciens AS m
ON l.musicien_id = m.id
JOIN jointures.instruments AS i
ON l.instrument_id = i.id
JOIN jointures.groupes AS g
ON g.id = m.groupe_id
JOIN jointures.albums AS a
ON g.id = a.groupe_id
WHERE i.nom = 'voix'
AND g.date_creation < '2008-01-01'
```

13) Pourquoi n'est il pas possible, avec vos connaissance actelles, de formuler une requête répondant à la question suivante : Quel est la chanson avec le plus de streams, parmis les chansons composées par le musicien le plus jeune ?

> Une manière de répondre à la question est de, dans un premier temps, détermier quel est le musicien le plus jeune, puis, dans un second temps, trouver quelle chanson a le plus de streams parmi celles qu'il a composé. Cependant, avec vos connaissances actuelles, vous ne pouvez faire que des requêtes instantannées. Il faudra attendre les requêtes imbriquées pour faire des requêtes en plusieurs temps. Même si il est tout de même possible de determiner le musicien le plus jeune dans le même temps de troucher ses sons, cela nécessite l'utilisation des fonctions d'aggrégation, que vous ne connaissez pas encore.
