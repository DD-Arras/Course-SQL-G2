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

1) Quels sont les prénoms des profs avec un salaire supérieur à `40000` dollars par an ?

<!-- ```sql
SELECT first_name FROM teachers
WHERE salary > 40000
``` -->

5) Ordonnez le tableau pour avoir tous les profs de `F.D. Roosevelt HS`, puis tous les profs de `Myers Middle School`. Il faut prendre toutes les colonnes.

<!-- ```sql
SELECT * FROM teachers
ORDER BY school ASC
``` -->

6) Quels sont les prénoms des profs recrutés entre 2009 et 2012 ?

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