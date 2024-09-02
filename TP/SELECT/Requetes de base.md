# TP - Requêtes de base

Le but de ce TP est de se familiariser avec les requêtes les plus simples de SQL.

On se concentrera sur des tables seules, sans aggrégats.

## Table `students`

Suite à [Premières manipulations de PgAdmin4](/TP/SELECT/Mise%20en%20place.md), vous avez une table `students` dans une base de données `SQL_G2`.
Vous allez écrire des requêtes afin de d'obtenir le résultat demandé.

Exemple :

 - Quelles sont les noms de tous les élèves ?

```sql
SELECT name FROM students
```