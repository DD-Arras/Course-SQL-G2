# TP - Requêtes de base

Le but de ce TP est de se familiariser avec les requêtes les plus simples de SQL.

On se concentrera sur des tables seules, sans aggrégats.

## Table `professeurs`

Suite à [Premières manipulations de PgAdmin4](./Mise_en_place.md), vous avez une table `professeurs` dans une base de données `SQL_G2`.
Vous allez écrire des requêtes afin de d'obtenir le résultat demandé.

#### Exemple

 - Quels sont les noms de tous les profs ?

```sql
SELECT nom FROM schema.professeurs
```

**Attention !** Dans tout le cours et les corrections, on remplacera `schema.professeurs` par simplement `professeurs`.

De plus, pour simplifier l'accès à la bonne table dans le bon schéma, vous pouvez glisser-déposer la table depuis l'arborescence (le panneau gauche) sur l'éditeur de requêtes (le panneau au milieu en haut).

Utilisez la touche `F5` pour lancer votre requête. Les résultats s'affichent dans le panneau au milieu en bas.

> Vous pouvez juxtaposer plusieurs requête dans un seul éditeur de requête. Utilisez le symbole `;` (point-virgule) pour séparer les requêtes. Dans ce cas, à chaque `F5`, toutes les requêtes seront exécutées, mais seul le résulat de la dernière sera affiché.

#### Exercices

1) Quels sont les prénoms de tous les profs ?

<!-- ```sql
SELECT prenom FROM professeurs
``` -->

2) Quels sont les prénoms, et l'école, de tous les profs ?

<!-- ```sql
SELECT prenom, ecole FROM professeurs
``` -->

3) Quels sont les prénoms, et l'école, des profs allant à l'école `Myers Middle ecole` ?

<details>
    <summary> <i> Indice </i> </summary>
    WHERE
</details><br>

<!-- ```sql
SELECT prenom, ecole FROM professeurs
WHERE ecole = 'Myers Middle ecole'
``` -->

4) Quels sont les prénoms des profs avec un salaire supérieur à `40000` dollars par an ?

<!-- ```sql
SELECT prenom FROM professeurs
WHERE salaire > 40000
``` -->

5) Ordonnez le tableau pour avoir tous les profs de `F.D. Roosevelt HS`, puis tous les profs de `Myers Middle ecole`. Il faut prendre toutes les colonnes.

<details>
    <summary> <i> Indice </i> </summary>
    ORDER BY
</details><br>

<!-- ```sql
SELECT * FROM professeurs
ORDER BY ecole ASC
``` -->

6) Quels sont les prénoms des profs recrutés entre 2009 et 2012 ?

<details>
    <summary> <i> Indice </i> </summary>
    WHERE ... AND
</details><br>

<!-- ```sql
SELECT prenom FROM professeurs
WHERE date_embauche > '2009-01-01'
AND date_embauche < '2012-01-01'
``` -->

7) Lister les profs (toutes les colonnes) du salaire le plus haut au salaire le plus bas.

<!-- ```sql
SELECT * FROM professeurs
ORDER BY salaire DESC
``` -->

8) Ecrire une requête pour obtenir le prénom du prof avec le salaire le plus haut.

<details>
    <summary> <i> Indice </i> </summary>
    LIMIT 1
</details><br>

<!-- ```sql
SELECT prenom FROM professeurs
ORDER BY salaire DESC
LIMIT 1
``` -->

9) Quel est le prénom du prof avec le salaire le plus bas, dans les profs de `Myers Middle ecole` ?

<!-- ```sql
SELECT prenom FROM professeurs
WHERE ecole = 'Myers Middle ecole'
ORDER BY salaire ASC
LIMIT 1
``` -->

## Table `repères topographiques`

De la même manière que vous avez importé `professeurs.csv`, téléchargez et importez la table csv des [repères topographiques des Hauts de Seine](https://opendata.hauts-de-seine.fr/explore/dataset/reperes-topographiques/export/?disjunctive.nature&disjunctive.commune&sort=commune) en base de données.

> Lors de la sélection du séparateur, indiquez `;` (point-virgule) à la place de `,` (virgule).

> Mettez les noms des champs en **minuscule**.

> Si vous avez un doute sur le type d'une colonne, préferez `character varying`. La conversion vers d'autres types de données est plus facile.

> *Si vous avez un problème pour importer les données, vous pouvez aussi utiliser l'éditeur de requêtes et [ce fichier](./data/reperes_topo.sql). Appelez moi !*

#### Exercices

Formulez des requêtes SQL pour obtenir le résultat demandé.

1) Quels sont les identifiants des repères de la commune de `Sceaux` ?

<!-- ```sql
SELECT identifiant FROM reperes
WHERE commune="SCEAUX"
``` -->

2) Quels sont les identifiants des repères de type `Spit` avec une observation ?
<details>
    <summary> <i> Indice </i> </summary>
    <a href="https://www.w3schools.com/sql/sql_null_values.asp">Détecter la présence d'information sur une colonne</a>
</details><br>

<!-- ```sql
SELECT identifiant FROM reperes
WHERE nature="Spit"
AND observation IS NOT NULL
``` -->

1) En Lambert93, quels sont les identifiants des repères à l'ouest de `X=647888` ?

<!-- ```sql
SELECT identifiant FROM reperes
WHERE x_l93 < 647888
``` -->

3) En Lambert93, quels sont les identifiants des repères à l'ouest de `X=647888`, ou au nord de `Y=6854692`?

<details>
    <summary> <i> Indice </i> </summary>
    WHERE ... OR
</details><br>

<!-- ```sql
SELECT identifiant FROM reperes
WHERE x_l93 < 647888
OR y_l93 > 6854692
``` -->

4) Comparez les résultats des deux requêtes suivantes :

```sql
SELECT commune FROM reperes
```
```sql
SELECT DISTINCT commune FROM reperes
```

5) Formulez une requête pour obtenir les trois codes postaux les plus hauts. Les trois doivent être différents.

<!-- ```sql
SELECT DISTINCT codepostal FROM reperes
ORDER BY codepostal DESC
``` -->

6) Préparez une requête pour filtrer les repères ayant une nature `Repère clou d'arpentage`.

<details>
    <summary> <i> Indice </i> </summary>
    <a href="https://stackoverflow.com/questions/1586560/how-do-i-escape-a-single-quote-in-sql-server">Echapper un apostrophe</a>
</details><br>

<!-- ```sql
SELECT identifiant FROM reperes
WHERE nature='Repère clou d''arpentage'
``` -->