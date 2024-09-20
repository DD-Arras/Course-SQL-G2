from util import *

prenomsDF: pd.DataFrame = pd.read_csv(os.path.join(dir, './data/prenoms.csv'))['prenom']
nomsDF: pd.DataFrame = pd.read_csv(os.path.join(dir, './data/noms.csv'))['nom']

countriesDF: gpd.GeoDataFrame = gpd.read_file(os.path.join(dir, './data/countries.csv'))

countriesDF['id'] = pd.to_numeric(countriesDF['id'])
countriesDF['longitude'] = pd.to_numeric(countriesDF['longitude'])
countriesDF['latitude'] = pd.to_numeric(countriesDF['latitude'])

countriesGeom = gpd.points_from_xy(
    x=countriesDF["longitude"],
    y=countriesDF["latitude"],
    crs="EPSG:4326"
)

citiesDF: gpd.GeoDataFrame = gpd.read_file(os.path.join(dir, './data/worldcities.csv'))

citiesDF['id'] = citiesDF.index + 1
citiesDF['longitude'] = pd.to_numeric(citiesDF['lng'])
citiesDF['latitude'] = pd.to_numeric(citiesDF['lat'])
citiesDF['population'] = pd.to_numeric(citiesDF['population'])
citiesDF['population'] = citiesDF['population'].fillna(0.0).astype('int64')

citiesGeom = gpd.points_from_xy(
    x=citiesDF["longitude"],
    y=citiesDF["latitude"],
    crs="EPSG:4326"
)
citiesDF['pays_id'] = citiesDF.merge(countriesDF, left_on="iso2", right_on="code")["id_y"]

citiesDF.drop(columns=['city_ascii', 'lat', 'lng', 'country'], inplace=True)

capitalsDF = citiesDF[citiesDF['capital'] == 'primary']

travelsDF = pd.DataFrame()
travelsSize = 10000
travelsDF['id'] = range(1, travelsSize+1)
travelsDF['prenom'] = prenomsDF.sample(travelsSize, ignore_index=True, replace=True)
travelsDF['nom'] = nomsDF.sample(travelsSize, ignore_index=True, replace=True)
travelsDF['ville_depart'] = capitalsDF["id"].sample(travelsSize, ignore_index=True, replace=True)
travelsDF['ville_arrivee'] = capitalsDF["id"].sample(travelsSize, ignore_index=True, replace=True)
travelsDF['prix'] = np.random.randint(100, 200, size=travelsSize) * (travelsDF["ville_depart"]+50000) / 100000

to_sql([countriesDF, citiesDF, travelsDF], ['pays', 'villes', 'voyages'],
       os.path.join(dir, '../TP/Imbriquees/data/monde.sql'), schema='monde')

a modifier pour n' avoir quune capitale par pays
+ question 2 orienter sur capitales
