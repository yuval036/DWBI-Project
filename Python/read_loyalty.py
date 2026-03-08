import pyodbc 
import pandas as pd

connection = pyodbc.connect(
	"DRIVER={ODBC Driver 17 for SQL Server};"
    	"SERVER=localhost;"
    	"DATABASE=DWBI;"
    	"Trusted_Connection=yes;"	
)

query = "SELECT * FROM dim.DimLoyaltyProgram"

df = pd.read_sql(query, con = connection)
print(df)