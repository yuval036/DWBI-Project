import pandas as pd
import random
import csv

num_rows = int(input("Enter the number of rows you want to genetate: "))
excel_file_path = r"C:\Users\yuval\OneDrive\שולחן העבודה\DWBI PROJECT\ProductsNames&CategoriesNames.xlsx"
category_sheet_name = "Categories"
product_sheet_name = "Products"
product_column = "Product Name"
category_column = "Category Name"

df_product = pd.read_excel(excel_file_path, sheet_name =product_sheet_name)
df_category = pd.read_excel(excel_file_path, sheet_name = category_sheet_name)

product_list = df_product[product_column].dropna().tolist()
category_list = df_category[category_column].dropna().tolist()

with open("DimProduct.csv", mode = 'w', newline = '', encoding='utf-8') as file:
	writer = csv.writer(file)
	header = ['ProductName', 'Category', 'Brand', 'UnitPrice']
	writer.writerow(header)
	for _ in range(num_rows):
		row = [
			random.choice(product_list),
            		random.choice(category_list),
			random.choice(['Nova', 'Vertex', 'PrimeLine', 'Everest' ,'UrbanCore']),
			random.randint(50, 1000)
		]
		writer.writerow(row)