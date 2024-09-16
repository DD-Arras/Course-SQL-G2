import pandas as pd
import numpy as np
import os

dir = os.path.dirname(__file__)

type_translation = {
    'int64': 'INT',
    'object': 'VARCHAR',
    'float64': 'DOUBLE PRECISION'
}


def to_sql(df_array, names_array, path, schema='public'):
    if len(df_array) != len(names_array):
        raise Exception('Length of df_array does not match length of names_array')
    with open(path, 'w') as file:
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
        ## Correct some floats casted as ints
        file.replace('.0', '')