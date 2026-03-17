import pandas as pd
import random 
import csv
from faker import Faker

fake = Faker()
num_rows = int(input("Enter the number of rows you want to genetate: "))
excel_file_path = r"C:\Users\yuval\OneDrive\שולחן העבודה\DWBI PROJECT\Nouns&Adjectives.xlsx"
excel_sheet_name = "גיליון1"
adjective_column = "Adjective"
noun_column = "Noun"

df = pd.read_excel(excel_file_path, sheet_name = excel_sheet_name)
with open("DimStore.csv", mode = 'w', newline = '') as file:
	writer = csv.writer(file)
	header = ['Store Name', 'StoreType', 'StoreOpeningDate', 'Address', 'City', 'State', 'Country', 'Regin', 'Manager Name']
	writer.writerow(header)
	for _ in range(num_rows):
		random_adjective =df[adjective_column].sample(n=1).values[0]
		random_noun = df[noun_column].sample(n=1).values[0]
		store_name = f"The {random_adjective} {random_noun}"

		row = [
			store_name, 
			random.choice(['Exclusive', 'MBO', 'SMB', 'Outlet Store']),
			fake.date(),
			 fake.street_address(),
			fake.city(),
			fake.state(),
			fake.country(),
			random.choice(['North', 'South', 'East', 'West']),
			fake.first_name()
		]
		writer.writerow(row)
