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

2) Quels sont les élèves en CP ?

3) Donnez deux requêtes différentes pour la question suivante : Quel est la plus haute note de francais ?

4) Pour chaque classe, donnez le nombre d'élèves.

5) Comment la colonne `moyenne` a-t-elle été calculée ? Formulez une requête qui calcule la moyenne de chaque élève, sans utiliser la colonne `moyene`.

6) Quelle est la note la plus faible d'histoire dans la classe des CE2 ? Plusieurs méthodes sont possibles.

7) Ordonnez les classes, en mettant les classes avec les moyennes en français les plus basses, en haut.

8) Pour chaque classe, quel est le nombre d'élèves ayant une note d'histoire inférieure à dix ?

9) Quels sont les classes, où le nombre d'élève ayant une note de francais supérieure à dix, est plus grand que 15?

## Schéma `eshop`

Importez le schéma suivant : [eshop.sql](./data/eshop.sql).

La table `achats` est une table de liaison entre les tables `clients` et `vendeurs`, qui ont une relation ManyToMany.

En effet, une même personne peut acheter des biens sur plusieurs sites, et chaque site comptabilise de nombreux clients. Chaque transaction est moidélisée par une entrée dans la table `achats`, qui référence aussi le prix du bien acheté.

### Questions

Formulez des requêtes SQL qui correspondent aux questions.

1) Combien de vendeurs différents existe il ?

2) Quelle somme totale les clients ont ils dépensé sur ces sites ?

3) Quelle est la somme dépensée par Marie Tardy ?
<!-- A modifier si on recharge le script -->

4) Vers quels site s'est elle tournée pour faire ses achats ?

5) Quel est le prix minimum d'un achat à la Fnac ?

6) Ordonnez les vendeurs, en placant ceux avec une moyenne de prix élevée, en haut.

7) Quels sont les sites sur lesquels de nombreuses (8 ou plus) petites transactions (moins de 10 euros) on été faites ?

8) Combien de personnes différentes ont acheté sur Amazon ou Aliexpress ?

9) En ne prenant en compte que les sites avec un grand nombre de ventes (plus de 90) sur les grandes transactions (plus de 50 euros), quels sont les trois sites ayant fait les plus gros chiffres d'affaire sur ces transactions ?
