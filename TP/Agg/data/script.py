import pandas as pd
import numpy as np


type_translation = {
    'int64': 'INT',
    'object': 'VARCHAR',
    'float64': 'DOUBLE PRECISION'
}


def to_sql(df_array, names_array, file_name, schema='public'):
    if len(df_array) != len(names_array):
        raise Exception('Length of df_array does not match length of names_array')
    with open(f'./{file_name}.sql', 'w') as file:
        file.write(f'CREATE SCHEMA IF NOT EXISTS {schema};\n\n')
        file.writelines([f'DROP TABLE IF EXISTS {name} CASCADE;\n' for name in names_array])
        file.write('\n\n')
        # Creation des tables
        for i in range(len(names_array)):
            df = df_array[i]
            file.write(f'CREATE TABLE {schema}.{names_array[i]} (\n')
            for column in df.iloc[:,0:-1].columns:
                columntype = df.dtypes.replace(type_translation)[column]
                file.write(f'\t{column} {columntype},\n')
            last_column = df.columns[-1]
            last_columntype = df.dtypes.replace(type_translation)[last_column]
            file.write(f'\t{last_column} {last_columntype}\n);\n\n')
        file.write('\n')
        # Insertion dans les tables
        for i in range(len(names_array)):
            df = df_array[i]
            file.write(f'INSERT INTO {schema}.{names_array[i]} VALUES\n')
            ar = df.values
            for line in ar[0:-1]:
                file.write('\t(')
                for v in line[0:-1]:
                    file.write(f"'{v}', ")
                file.write(f"'{line[-1]}'),\n")
            file.write('\t(')
            for v in ar[-1][0:-1]:
                    file.write(f"'{v}', ")
            file.write(f"'{ar[-1][-1]}');\n\n")




prenomsDF = pd.read_csv('./prenoms.csv')['prenom']
nomsDF = pd.read_csv('./noms.csv')['nom']

elevesDF = pd.DataFrame()
elevesDF['id'] = [i for i in range(1, 151)]
elevesDF['prenom'] = prenomsDF.sample(150, ignore_index=True)
elevesDF['nom'] = nomsDF.sample(150, ignore_index=True)
elevesDF['classe_id'] = np.random.randint(1, 6, size=150)
elevesDF['maths'] = np.random.uniform(0, 20, size=150)
elevesDF['francais'] = np.random.uniform(0, 20, size=150)
elevesDF['histoire'] = np.random.uniform(0, 20, size=150)
elevesDF['moyenne'] = (elevesDF['maths']
                       + elevesDF['francais']
                         + elevesDF['histoire']) / 3

classesDF = pd.DataFrame()
classesDF['id'] = [i for i in range(1, 6)]
classesDF['nom'] = ['CP', 'CE1', 'CE2', 'CM1', 'CM2']

to_sql([elevesDF, classesDF], ['eleves', 'classes'], 'ecole', 'ecole')

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
achatsDF['prix'] = np.random.randint(1, 200, size=1000)

to_sql([clientsDF, vendeursDF, achatsDF], ['clients', 'vendeurs', 'achats'], 'eshop', 'eshop')