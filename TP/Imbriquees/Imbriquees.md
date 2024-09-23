# TP - Fonctions imbriquées

Le but de ce TP est d'utiliser les fonctions imbriquées, dans une table plus imposante.

## Mise en place des ressources du TP

Importez ce fichier sql : [monde.sql](/TP/Imbriquees/data/monde.sql).

Il comporte trois tables : une table des pays, une table de villes, et et une table de voyages.

1) Observez les tables et dessinez un schéma UML qui décrit le schéma `monde`. Les jointures doivent apparaitre.

2) La gestion des capitales pourrait être améliorée. Proposez un ou plusieurs changements afin de simplifier l'accès des capitales pour chaque pays.

> OLD : La structure du schéma aurait pu être amélioré, en effet, il manque une jointure... Proposez une jointure qui n'est pas présente actuellement, qui aurait pu être intéressante.

> On pourrait faire les changements suivants : Ajout d'une clé étrangère `capitale_id` dans `pays`, qui référencie la clé primaire `id` de `villes` pour que la jointure des deux tables permette d'accéder naturellement aux capitales des pays, puis suppression du champs `capital` dans `villes`.

## Questions

3) Quelle est la ville avec le plus d'habitants ?

```sql
SELECT ville, population
FROM villes
ORDER BY population DESC
LIMIT 1
```

4) Combien de villes y a t'il dans la base de données ?

```sql
SELECT COUNT(*) FROM villes
```

5) Ordonnez les familles (nom de famille identiques) en mettant en avant celles qui ont le plus dépensé dans des voyages.

```SQL
SELECT nom, SUM(prix)
FROM voyages
GROUP BY nom
ORDER BY SUM(prix) DESC
```

6) Trouvez les familles qui ont dépensé dans au moins un voyage, un montant plus grand que la moyenne des voyages.
>OLD : Trouvez les familles qui ont dépensé plus d'argent que la moyenne dans des voyages.

```sql
-- 2 - Requête globale
SELECT nom
FROM voyages
WHERE MAX(prix) > (
    -- 1 Moyenne des voyages
    SELECT AVG(prix) FROM voyages
)
GROUP BY nom
```

> OLD :

```sql
SELECT nom
FROM voyages
WHERE SUM(prix) > (
    SELECT AVG(summ) FROM (
        SELECT SUM(prix) AS summ
        FROM voyages
        GROUP BY nom
    )
)
GROUP BY nom
```

7) Quelles sont les villes qui sont plus habitées que la capitale de leur pays ?

```sql
-- 4 - On selectionne (avec des alias pour plus de clarté) les colonnes
SELECT v.ville AS ville, v.population AS population,
    capitals.ville AS capitale, capitals.population AS population_capitale
FROM villes AS v
JOIN (
    -- 1 - Selection des capitales
    SELECT ville, population, pays_id
    FROM villes
    WHERE capital = 'primary'
) AS capitals
-- 2 - On s'assure qu'on compare les villes avec la capitale du même pays
ON v.pays_id = capitals.pays_id
-- 3 - On applique le filtre
WHERE v.population > capitals.population
```

8) Quel est le prix minimal d'un voyage depuis la ville qui est la plus chère en tant que ville de départ ?

```sql
-- 2 - selection du minimum dans cette ville
-- On peut eventuellement obtenir plus d'information sur ce voyage
-- en réalisant une ou deux jointures avec villes, et en remplacant
-- MIN(prix) par ORDER BY prix ASC LIMIT 1
SELECT MIN(prix) FROM voyages
WHERE ville_depart = (
    -- 1 - selection de la ville de départ la plus chère en moyenne
    SELECT ville_depart FROM voyages
    GROUP BY ville_depart
    ORDER BY AVG(prix)
    LIMIT 1
)
```

Si PostgreSQL peut être utilisé pour faire des opérations géographiques et géométriques(voir l'extension [postgis](https://postgis.net/)), nous n'allons pas l'utiliser aujourd'hui.

>Cette extention est puissante et utilise GDAL/OGR, une bibliothèque en C++ extrèmement optimisée. Postgis sublime cette technologie, en l'associant aux travaux en parallèles propre à SQL, pour des performances véritablement excellentes sur le calcul géométrique.

A la place, nous allons considérer que 1 degré en longitude = 1 degré en latitude = 111 km, sur l'ensemble de la terre. Jacques Beilin est en panique.

9) Quelles villes sont proches (moins de 200km) d'une capitale ?

```sql
-- On pourrait rajouter DISTINCT
SELECT v.ville
FROM villes AS v
JOIN (
    -- 1 - Selection des capitales
    SELECT longitude, latitude
    FROM villes
    WHERE capital = 'primary'
) AS c
-- 2 - Cas particulier de jointure spatiale avec calcul de distance
ON sqrt(power(v.longitude - c.longitude, 2) + power(v.latitude - c.latitude, 2)) < 200/111
```

10) Quelle est la famille qui paie le plus cher, en moyenne, pour faire un voyage vers une ville avec un nombre d'habitants supérieur à la moyenne ?

```sql
-- 3 - Selection des familles
SELECT vg.nom, AVG(vg.prix)
FROM voyages AS vg
JOIN (
    -- 2 - Selection des villes avec une pop > moyenne
    SELECT id from villes
    WHERE population > (
        -- 1 - nombre d'habitants moyen
        SELECT AVG(population) FROM villes
    )
) AS gv
ON gv.id = vg.ville_arrivee
GROUP BY vg.nom
ORDER BY AVG(vg.prix)
LIMIT 1
-- On aurait aussi pu utiliser un IN
```

11) Quelle est la ville vers laquelle les voyages sont les plus rentables en moyenne : des voyages très longs, pour pas cher ?

```sql
SELECT v2.ville
FROM voyages AS vg
JOIN villes AS v1
ON v1.id = vg.ville_depart
JOIN villes AS v2
ON v2.id = vg.ville_arrivee
GROUP BY v2.id
ORDER BY AVG(sqrt(power(v1.longitude - v2.longitude, 2) + power(v1.latitude - v2.latitude, 2))/vg.prix)
LIMIT 1
```
<!-- A recheck vite fait-->

12) Quelle partie du monde, Est ou Ouest (longitude positive ou négative), y a t'il le moins d'ecart type pour acheter des tickets ?

```sql
-- 2 - selection de l'ecart type (racine de la variance)
SELECT m.partie, AVG(ABS(v.prix-m.moyenne))
FROM voyages AS v
JOIN (
    -- 1 - Selection de la moyenne pour chaque partie
    SELECT AVG(prix) AS moyenne, longitude < 0 AS partie FROM voyages
    GROUP BY longitude < 0
) AS m
ON (v.longitude < 0) = m.partie
GROUP BY m.partie
```
<!-- A recheck vite fait-->

13) Existe t-il des allers-retours : des paires de voyages avec des villes d'arrivée et de départ inversées ?

```sql
SELECT v1.ville_depart, v1.ville_arrivee
FROM voyages AS v1
JOIN voyages AS v2
ON v1.ville_depart = v2.ville_arrivee
WHERE v1.ville_arrivee = v2.ville_depart
```

14) Quelle est la médiane, et la moyenne, de la population des villes ?

```sql
-- 4 - selection de la moyenne
SELECT (
    -- 3 - Select de la médiane
    SELECT MAX(pop) FROM (
        -- 2 - Selection de la partie inférieure
        SELECT population AS pop FROM villes
        ORDER BY population ASC
        LIMIT (
            -- 1 - Selection du nombre de villes
            SELECT COUNT(*)
            FROM villes
        ) / 2 +1
    )
) AS mediane, AVG(population) AS moyenne
FROM villes
-- Il y a sans doute des manières plus efficaces d'obtenir ces valeurs
```

15) Quelle est la ville la plus éloignée de toute capitale ?

```sql
SELECT v.ville
FROM villes AS v
JOIN (
    -- 1 - Selection des capitales
    SELECT longitude, latitude
    FROM villes
    WHERE capital = 'primary'
) AS c
-- 2 - Cas particulier de jointure spatiale. On estimme que la distance minimale dans ce cas est 1000km
ON sqrt(power(v.longitude - c.longitude, 2) + power(v.latitude - c.latitude, 2)) > 1000/111
ORDER BY sqrt(power(v.longitude - c.longitude, 2) + power(v.latitude - c.latitude, 2)) DESC
LIMIT 1
```

16) Trouvez les familles qui ont dépensé plus d'argent que la moyenne dans des voyages.

```sql
SELECT nom
FROM voyages
WHERE SUM(prix) > (
    SELECT AVG(summ) FROM (
        SELECT SUM(prix) AS summ
        FROM voyages
        GROUP BY nom
    )
)
GROUP BY nom
```