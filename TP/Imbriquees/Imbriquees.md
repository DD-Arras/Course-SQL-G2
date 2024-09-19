# TP - Fonctions imbriquées

Le but de ce TP est d'utiliser les fonctions imbriquées, dans une table de plus en plus imposante.

## Mise en place des ressources du TP

Importez ce fichier sql : [cinema.sql](/TP/Imbriquees/data/monde.sql).

Il comporte trois tables : une table des pays, une table de villes, et et une table de voyages.

1) Observez les tables et dessinez un schéma UML qui décrit le schéma `monde`. Les jointures doivent apparaitre.

2) La structure du schéma aurait pu être amélioré, en effet, il manque une jointure... Proposez une jointure qui n'est pas présente actuellement, qui aurait pu être intéressante.

3) Quelle est la ville avec le plus d'habitants ?

4) Combien de villes y a t'il dans la base de données ?

5) Ordonnez les familles (nom de famille identiques) en mettant en avant celles qui ont le plus dépensé dans des voyages.

6) Trouvez les familles qui ont dépensé plus d'argent que la moyenne dans des voyages.

7) Quelles sont les villes qui sont plus habitées que la capitale de leur pays ?

8) Quel est le prix minimal d'un voyage depuis la ville qui est la plus chère en tant que ville de départ ?

Si PostgreSQL peut être utilisé pour faire des opérations géographiques et géométriques(voir l'extension [postgis](https://postgis.net/)), nous n'allons pas l'utiliser aujourd'hui.

>Cette extention est puissante et utilise GDAL/OGR, une bibliothèque en C++ extrèmement optimisée. Postgis sublime cette technologie, en l'associant aux travaux en parallèles propre à SQL, pour des performances véritablement excellentes sur le calcul géométrique.

A la place, nous allons considérer que 1 degré en longitude = 1 degré en latitude = 111 km, sur l'ensemble de la terre. Jacques Beilin est en panique.

9) Quelles villes sont proches (moins de 200km) d'une capitale ?

10) Quelle est la famille qui paie le plus cher, en moyenne, pour faire un voyage vers une ville avec un nombre d'habitants supérieur à la moyenne.

11) Quelle est la ville vers laquelle les voyages sont les plus rentables en moyenne : des voyages très longs, pour pas cher.

12) Quelle partie du monde, Est ou Ouest (longitude positive ou négative), y a t'il le moins d'ecart type pour acheter des tickets ?

13) Existe t-il des allers-retours : des paires de voyages avec des villes d'arrivée et de départ inversées.