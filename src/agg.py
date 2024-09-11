from util import *

prenomsDF = pd.read_csv(os.path.join(dir, './data/prenoms.csv'))['prenom']
nomsDF = pd.read_csv(os.path.join(dir, './data/noms.csv'))['nom']

elevesDF = pd.DataFrame()
elevesDF['id'] = [i for i in range(1, 151)]
elevesDF['prenom'] = prenomsDF.sample(150, ignore_index=True)
elevesDF['nom'] = nomsDF.sample(150, ignore_index=True)
elevesDF['classe_id'] = np.random.randint(1, 6, size=150)
elevesDF['maths'] = np.random.uniform(5, 20, size=150) - elevesDF['classe_id']
elevesDF['francais'] = np.random.uniform(0, 15, size=150) + elevesDF['classe_id']
elevesDF['histoire'] = np.random.uniform(0, 16, size=150) + (elevesDF['classe_id'] - 3)**2
elevesDF['moyenne'] = (elevesDF['maths']
                       + elevesDF['francais']
                         + elevesDF['histoire']) / 3

classesDF = pd.DataFrame()
classesDF['id'] = [i for i in range(1, 6)]
classesDF['nom'] = ['CP', 'CE1', 'CE2', 'CM1', 'CM2']

to_sql([elevesDF, classesDF], ['eleves', 'classes'],
       os.path.join(dir, '../TP/Agg/data/ecole.sql'), 'ecole')

clientsDF = pd.DataFrame()
clientsDF['id'] = [i for i in range(1, 201)]
clientsDF['prenom'] = prenomsDF.sample(200, ignore_index=True)
clientsDF['nom'] = nomsDF.sample(200, ignore_index=True)

vendeursDF = pd.DataFrame()
vendeursDF['id'] = [i for i in range(1, 9)]
vendeursDF['nom'] = ['Amazon', 'Leboncoin', 'Cdiscount', 'eBay',
        'Leroy Merlin', 'Fnac', 'Aliexpress', 'Microsoft']

achatsDF = pd.DataFrame()
achatsDF['id'] = [i for i in range(1, 1001)]
achatsDF['client_id'] = np.random.randint(1, 201, size=1000)
achatsDF['vendeur_id'] = np.random.randint(1, 9, size=1000)
achatsDF['prix'] = np.random.randint(1, 200, size=1000) * (20+achatsDF['vendeur_id']) / 28

to_sql([clientsDF, vendeursDF, achatsDF], ['clients', 'vendeurs', 'achats'],
       os.path.join(dir, '../TP/Agg/data/eshop.sql'), 'eshop')