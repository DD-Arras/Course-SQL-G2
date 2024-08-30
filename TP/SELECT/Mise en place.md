# Cours d'introduction aux bases de données

G2 - 2024

---

# TP1 - Manipulation de PgAdmin4

PgAdmin est un outil d'admninistration de bases de données.

---

# Installations

Rendez vous sur [EDB Downloads](https://www.enterprisedb.com/downloads/postgres-postgresql-downloads) et téléchargez la dernière version pour votre système d'exploitation.

Lancez l'installation et avancez dans le processus. Attention à bien sélectionner les quatre composants : ![installation_composants](/TP/SELECT/images/installation_composants.webp)

Puisque nous sommes dans un environnement local, je vous conseille d'utiliser un mot de passe facile à retenir, tel que `postgres`. Laissez les autres paramètres par défault.

Nous avons installé le serveur PostgreSQL en local, ainsi que l'interface graphique PgAdmin4 pour administrer notre nouvelle base de données.

---

# Premiers pas

## Connection au Serveur

Ouvrez PgAdmin4.

Dans l'onglet à gauche, vous trouverez le terme `Serveur`, puis `PostgreSQL 16` : cliquez dessus, puis renseignez le mot de passe choisi plus tôt. Je vous conseille vivement de cocher la case pour se souvenir du mot de passe.

### Rappel : Architecture Client - Serveur

Ici, nous avons installé un serveur local, sur le port `5432` de notre machine (voir les propriétés en faisant `Serveur -> PostgreSQL -> clic droit -> Propriétés -> Connexion`).

Ainsi, une partie de votre PC va faire des requêtes, et une autre, complètement indépendante, va faire des calculs et renvoyer une réponse.

L'architecture Client - Serveur est préservée.

![Schéma Client Serveur](/TP/SELECT/images/schema_client_serveur.png)

## Création d'une base et import d'une table CSV

Notre serveur local est vide. Nous allons créer une nouvelle base de donnée. De manière générale, un projet = une base de données.

`Serveurs -> PostgreSQL 16 -> Bases de données -> clic droit -> Créer -> Base de données`

![Create Database](/TP/SELECT/videos/create_database.gif)

Nous avons maintenant une base de données `SQL G2`, qui nous suivra durant tout le cours.

<br>

Télechargez le fichier suivant : [table_teachers.csv](/TP/SELECT/data/teachers.csv).

Nous allons maintenant pousser nos données csv sur le serveur, dans une nouvelle table.

Parcourez l'arborescence pour pouvoir créer une table :
`SQL_G2 -> Schémas -> public -> Tables -> clic droit -> Créer -> Table`

> Les schémas sont des sortes de sous dossiers. Vous pourriez créer un schéma pour chaque TP par exemple.

Donnez un nom à votre table et allez dans l'onglet `Colonnes`. Ajouttez une colonne pour chaque colonne du fichier csv.

> Attention aux types ! Les nombres entiers sont des `integer`, les textes sont des `character varying`, et les dates... des `date`.

![Ajout des colonnes](/TP/SELECT/videos/columns.gif)

Pas besoin de toucher les autres options pour l'instant.

Vous pouvez afficher votre nouvelle table avec `clic droit -> Afficher -> Toutes les lignes`.

> Cette page ne se raffraichit pas toute seule. Si vous modifiez la table, appuyez sur `F5` pour raffrachir l'affichage.

Nous avons préparé notre table : elle est prête à recevoir des données.

<br>

Importez le csv avec l'outil de PgAdmin.

![import](/TP/SELECT/videos/import.gif)

> Attention à bien être en mode 'Import'

Nos données sont bien importées, on peut maintenant faire des requêtes sur la base.