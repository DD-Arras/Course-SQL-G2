# TP - Requêtes de base

Le but de ce TP est de se familiariser avec les requêtes les plus simples de SQL.

On se concentrera sur des tables seules, sans aggrégats.

## Table `teachers`

Suite à [Premières manipulations de PgAdmin4](/TP/SELECT/Mise%20en%20place.md), vous avez une table `teachers` dans une base de données `SQL_G2`.
Vous allez écrire des requêtes afin de d'obtenir le résultat demandé.

#### Exemple 

 - Quels sont les noms de tous les profs ?

```sql
SELECT last_name FROM teachers
```

#### Exercices

1) Quels sont les prénoms de tous les profs ?

<!-- ```sql
SELECT first_name FROM teachers
``` -->

2) Quels sont les prénoms, et l'école, de tous les profs ?

<!-- ```sql
SELECT first_name, school FROM teachers
``` -->

3) Quels sont les prénoms, et l'école, des profs allant à l'école `Myers Middle School` ?

<details>
    <summary> Indice </summary>
    WHERE
</details>

<!-- ```sql
SELECT first_name, school FROM teachers
WHERE school = 'Myers Middle School'
``` -->

4) Quels sont les prénoms des profs avec un salaire supérieur à `40000` dollars par an ?

<!-- ```sql
SELECT first_name FROM teachers
WHERE salary > 40000
``` -->

5) Ordonnez le tableau pour avoir tous les profs de `F.D. Roosevelt HS`, puis tous les profs de `Myers Middle School`. Il faut prendre toutes les colonnes.

<details>
    <summary> Indice </summary>
    ORDER BY
</details>

<!-- ```sql
SELECT * FROM teachers
ORDER BY school ASC
``` -->

6) Quels sont les prénoms des profs recrutés entre 2009 et 2012 ?

<details>
    <summary> Indice </summary>
    WHERE ... AND
</details>

<!-- ```sql
SELECT first_name FROM teachers
WHERE hire_date > '2009-01-01'
AND hire_date < '2012-01-01'
``` -->

7) Lister les profs (toutes les colonnes) du salaire le plus haut au salaire le plus bas.

<!-- ```sql
SELECT * FROM teachers
ORDER BY salary DESC
``` -->

8) Ecrire une requête pour obtenir le prénom du prof avec le salaire le plus haut.

<details>
    <summary> Indice </summary>
    LIMIT 1
</details>

<!-- ```sql
SELECT first_name FROM teachers
ORDER BY salary DESC
LIMIT 1
``` -->

9) Quel est le prénom du prof avec le salaire le plus haut, dans les profs de `Myers Middle School` ?

<!-- ```sql
SELECT first_name FROM teachers
WHERE school = 'Myers Middle School'
ORDER BY salary DESC
LIMIT 1
``` -->

## Table `repères topographiques`

De la même manière que vous avez importé `teachers.csv`, téléchargez et importez la table csv des [repères topographiques des Hauts de Seine](https://opendata.hauts-de-seine.fr/explore/dataset/reperes-topographiques/export/?disjunctive.nature&disjunctive.commune&sort=commune) en base de données.

> Lors de la sélection du séparateur, indiquez `;` (point-virgule) à la place de `,` (virgule).

> Si vous avez un doute sur le type d'une colonne, préferez `character varying`. La conversion vers d'autres types de données est plus facile.

#### Exercices

Formulez des requêtes SQL pour obtenir le résultat demandé.

1) Quels sont les identifiants des repères de la commune de `Sceaux` ?

<!-- ```sql
SELECT identifiant FROM reperes
WHERE commune="SCEAUX"
``` -->

2) Quels sont les identifiants des repères de type `Spit` avec une observation ?

<!-- ```sql
SELECT identifiant FROM reperes
WHERE nature="Spit"
AND observation != ''
``` -->

<!-- Attention voir si il faut pas utiliser IS NOT NULL -->

3) En Lambert93, quels sont les identifiants des repères à l'ouest de `X=647888` ?

<!-- ```sql
SELECT identifiant FROM reperes
WHERE x_l93 < 647888
``` -->

3) En Lambert93, quels sont les identifiants des repères à l'ouest de `X=647888`, ou au nord de `Y=6854692`?

<details>
    <summary> Indice </summary>
    WHERE ... OR
</details>

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

```sql
SELECT DISTINCT codepostal FROM reperes
ORDER BY codepostal DESC
```

6) Préparez une requête pour filtrer les repères ayant une nature `Repère clou d'arpentage`.

<details>
    <summary> Indice </summary>
    <a href="https://stackoverflow.com/questions/1586560/how-do-i-escape-a-single-quote-in-sql-server">Echapper un apostrophe</a>
</details>