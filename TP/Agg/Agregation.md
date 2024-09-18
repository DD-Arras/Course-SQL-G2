# TP - Fonctions d'Agrégation

Le but de ce TP est de se confronter aux fonctions d'agrégations, outils d'analyse de tables.

## Schéma ecole

Importez le schéma suivant : [ecole.sql](./data/ecole.sql).

Il comportes deux tables : `classes` et `eleves`, qui sont joins par une relation OneToMany.

Observez pendant quelques instants les tables et leurs structures.

>Les données de ses tables ont été générés aléatoirement par [script agg](../../src/agg.py), aucune donnée ne référence quelconque personne réelle.

### Questions

Formulez des requêtes SQL qui correspondent aux questions.

1) Quels sont les élèves ayant eu une note de maths supérieure à 12 ?

```sql
SELECT *
FROM eleves
WHERE maths > 12
```

2) Quels sont les élèves en CP ?

```sql
SELECT e.prenom, e.nom
FROM eleves AS e
JOIN classes AS c
ON c.id = e.classe_id
WHERE c.nom = 'CP'
```

3) Donnez deux requêtes différentes pour la question suivante : Quel est la plus haute note de francais ?

```sql
SELECT MAX(francais)
FROM eleves
```

```sql
SELECT francais
FROM eleves
ORDER BY francais DESC
LIMIT 1
```

4) Pour chaque classe, donnez le nombre d'élèves.

```sql
SELECT c.nom, COUNT(*)
FROM eleves AS e
JOIN classes AS c
ON c.id = e.classe_id
GROUP BY c.nom
```

5) Comment la colonne `moyenne` a-t-elle été calculée ? Formulez une requête qui calcule la moyenne de chaque élève, sans utiliser la colonne `moyene`.

>Une moyenne est calculée avec le caclul suivant : (maths + francais + histoire)/3

```sql
SELECT e.prenom, e.nom, (maths + francais + histoire)/3
FROM eleves
```

6) Quelle est la note d'histoire la plus faible dans la classe des CE2 ? Plusieurs méthodes sont possibles.

```sql
SELECT c.nom, MIN(histoire)
FROM eleves AS e
JOIN classes AS c
ON c.id = e.classe_id
GROUP BY c.nom
HAVING c.nom = 'CE2'
```

```sql
SELECT c.nom, MIN(histoire)
FROM eleves AS e
JOIN classes AS c
ON c.id = e.classe_id
WHERE c.nom = 'CE2'
GROUP BY c.nom
```

```sql
SELECT c.nom, histoire
FROM eleves AS e
JOIN classes AS c
ON c.id = e.classe_id
WHERE c.nom = 'CE2'
ORDER BY histoire ASC
LIMIT 1
```

7) Ordonnez les classes, en mettant les classes avec les moyennes en français les plus basses, en haut.

```sql
SELECT c.nom, AVG(francais)
FROM eleves AS e
JOIN classes AS c
ON c.id = e.classe_id
GROUP BY c.nom
ORDER BY AVG(francais) ASC
```

8) Pour chaque classe, quel est le nombre d'élèves ayant une note d'histoire inférieure à dix ?

```sql
SELECT c.nom, COUNT(*)
FROM eleves AS e
JOIN classes AS c
ON c.id = e.classe_id
WHERE e.histoire < 10
GROUP BY c.nom
```

9) Quels sont les classes, où le nombre d'élève ayant une note de francais supérieure à dix, est plus grand que 15?

```sql
SELECT c.nom, COUNT(*)
FROM eleves AS e
JOIN classes AS c
ON c.id = e.classe_id
WHERE c.francais > 10
GROUP BY c.nom
HAVING COUNT(*) >= 15
```

## Schéma `eshop`

Importez le schéma suivant : [eshop.sql](./data/eshop.sql).

La table `achats` est une table de liaison entre les tables `clients` et `vendeurs`, qui ont une relation ManyToMany.

En effet, une même personne peut acheter des biens sur plusieurs sites, et chaque site comptabilise de nombreux clients. Chaque transaction est moidélisée par une entrée dans la table `achats`, qui référence aussi le prix du bien acheté.

### Questions

Formulez des requêtes SQL qui correspondent aux questions.

1) Combien de vendeurs différents existe il ?

```sql
SELECT COUNT(*)
FROM vendeurs
```

2) Quelle somme totale les clients ont ils dépensé sur ces sites ?

```sql
SELECT SUM(prix)
FROM achats
```

3) Quelle est la somme dépensée par Marie Tardy ?
<!-- A modifier si on recharge le script -->

```sql
SELECT SUM(a.prix)
FROM achats AS a
JOIN clients AS c
ON c.id = a.client_id
WHERE c.prenom = 'Marie'
AND c.nom = 'Tardy'
```

4) Vers quels site s'est elle tournée pour faire ses achats ?

```sql
SELECT DISTINCT v.nom
FROM achats AS a
JOIN clients AS c
ON c.id = a.client_id
JOIN vendeurs AS v
ON v.id = a.vendeur_id
WHERE c.prenom = 'Marie'
AND c.nom = 'Tardy'
```

5) Quel est le prix minimum d'un achat à la Fnac ?

```sql
SELECT MIN(a.prix)
FROM achats AS a
JOIN vendeurs AS v
ON v.id = a.vendeur_id
WHERE v.nom = 'FNAC'
GROUP BY v.nom
```

```sql
SELECT MIN(a.prix)
FROM achats AS a
JOIN vendeurs AS v
ON v.id = a.vendeur_id
GROUP BY c.nom
HAVING v.nom = 'FNAC'
```

```sql
SELECT a.prix
FROM achats AS a
JOIN vendeurs AS v
ON v.id = a.vendeur_id
WHERE v.nom = 'FNAC'
ORDER BY a.prix ASC
LIMIT 1
```

6) Ordonnez les vendeurs, en placant ceux avec une moyenne de prix élevée, en haut.

```sql
SELECT v.nom, AVG(a.prix)
FROM achats AS a
JOIN vendeurs AS v
ON v.id = a.vendeur_id
GROUP BY v.nom
ORDER BY AVG(a.prix) DESC
```

7) Quels sont les sites sur lesquels de nombreuses (8 ou plus) petites transactions (moins de 10 euros) on été faites ?

```sql
SELECT v.nom, COUNT(*)
FROM achats AS a
JOIN vendeurs AS v
ON v.id = a.vendeur_id
WHERE a.prix < 10
GROUP BY v.nom
HAVING COUNT(*) >= 8
```

8) Combien de personnes différentes ont acheté sur Amazon ou Aliexpress ?
<!-- a modifier --> 

> Cette question requiert une utilisation de `COUNT` que nous n'avons pas vu, ca n'est pas au programme.

```sql
SELECT COUNT(DISTINCT c.nom)
FROM achats AS a
JOIN clients AS c
ON c.id = a.client_id
JOIN vendeurs AS v
ON v.id = a.vendeur_id
WHERE v.nom = 'Amazon'
OR v.nom = 'Alieexpress'
```

9) En ne prenant en compte que les sites avec un grand nombre de ventes (plus de 90) sur les grandes transactions (plus de 50 euros), quels sont les trois sites ayant fait les plus gros chiffres d'affaire sur ces transactions ?

```sql
SELECT v.nom, COUNT(*)
FROM achats AS a
JOIN vendeurs AS v
ON v.id = a.vendeur_id
WHERE a.prix > 50
GROUP BY v.nom
HAVING COUNT(*) >= 90
ORDER BY SUM(a.prix) DESC
LIMIT 3
```