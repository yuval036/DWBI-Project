import os 
import glob 
import pandas as pd 
import pyodbc

daily_dir = r'C:\Users\yuval\OneDrive\שולחן העבודה\DWBI PROJECT\DailyData'
files = glob.glob(os.path.join(daily_dir, '*.csv'))

conn = pyodbc.connect(
    "DRIVER={ODBC Driver 17 for SQL Server};"
    "SERVER=localhost;"
    "DATABASE=DWBI;"
    "Trusted_Connection=yes;"
)

cursor = conn.cursor()

for f in files:
	df = pd.read_csv(f)
	
	cursor.execute("TRUNCATE TABLE stage.FactOrdersRow;")
	conn.commit()

	for _, row in df.iterrows():
		cursor.execute(
			"""
			INSERT INTO stage.FactOrdersRow(
				OrderDateID,
				ProductID, 
				StoreID, 
				CustomerID, 
				QuantityOrdered, 
				DiscountPercent,
				ShippingPercent
			)
			VALUES (?, ?, ?, ?, ?, ?, ?)
			""",
			int(row["DateID"]),
			int(row["ProductID"]),
			int(row["StoreID"]),
			int(row["CustomerID"]),
			int(row["QuantityOrdered"]),
			float(row["DiscountPercent"]),
			float(row["ShippingPercent"])
		)
		conn.commit()

		cursor.execute(
			"""
			INSERT INTO fact.FactOrders(
				OrderDateID,
				ProductID, 
				StoreID, 
				CustomerID, 
				QuantityOrdered, 
				DiscountPercent, 
				ShippingPercent				
			)
			SELECT
				s.OrderDateID, 
				s.ProductID,
				s.StoreID, 
				s.CustomerID, 
				s.QuantityOrdered, 
				CAST(s.DiscountPercent AS DECIMAL(5,4)),
				CAST(s.ShippingPercent AS DECIMAL(5,4))
			FROM stage.FactOrdersRow AS s		
			JOIN dim.DimDate AS d ON s.OrderDateID = d.DateID 
			JOIN dim.DimProduct AS p ON s.ProductId = p.ProductID
			JOIN dim.DimStore AS st ON s.StoreID = st.StoreID 
			JOIN dim.DimCustomer AS c ON s.CustomerID = c.CustomerID
			"""		
		)
		conn.commit()
conn.close()