from pandas import pandas as pd
pd.__version__
df_1 = pd.read_csv('./green_tripdata_2019-10.csv')
df_2 = pd.read_csv('./taxi_zone_lookup.csv')
df_1.head()

from sqlalchemy import create_engine
engine = create_engine('postgresql://root:shekobeko62@pgdatabase:5432/ny_taxi')
engine.connect()
df_1.head(n=0).to_sql('green_taxi_data', con=engine, if_exists='replace') #truncates the table
df_2.head(n=0).to_sql('taxi_zone_lookup', con=engine, if_exists='replace') #truncates the table
df_1.lpep_pickup_datetime =  pd.to_datetime(df_1.lpep_pickup_datetime)
df_1.lpep_dropoff_datetime = pd.to_datetime(df_1.lpep_dropoff_datetime)
df_1.to_sql('green_taxi_data', con=engine, if_exists='append')
df_2.to_sql('taxi_zone_lookup', con=engine, if_exists='append')
pip install psycopg2-binary

print(pd.io.sql.get_schema(df_1, name='green_taxi_data', con=engine))
print(pd.io.sql.get_schema(df_2, name='taxi_zone_lookup', con=engine))
