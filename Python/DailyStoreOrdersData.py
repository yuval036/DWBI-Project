import pandas as pd
import numpy as np
import os

DATEID = 20260101
directory = r'C:\Users\yuval\OneDrive\שולחן העבודה\DWBI PROJECT\DailyData'

for i in range(1, 51):
	num_rows = np.random.randint(50, 100)
	data = {
		'DateID': [DATEID] * num_rows,
	'ProductID': np.random.randint(1, 501, size = num_rows),
	'StoreID':[i] * num_rows,
	'CustomerID': np.random.randint(1, 1001, size = num_rows),
	'QuantityOrdered': np.random.randint(1, 21, size = num_rows),
	}
	df = pd.DataFrame(data)
	df['DiscountPercent'] = np.random.uniform(0.02, 0.15, size=num_rows)
	df['ShippingPercent'] = np.random.uniform(0.05, 0.15, size=num_rows)	
	
	file_name = f'Store_{i}_{DATEID}.csv'
	file_path = os.path.join(directory, file_name)
	if os.path.exists(file_path):
		os.remove(file_path)
	df.to_csv(file_path, index = False)
	