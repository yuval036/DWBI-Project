import pandas as pd
import numpy as np

num_rows = int(input("Enter the number of rows you want to genetate: "))
random_dates = np.random.choice( np.arange(np.datetime64('2015-01-01'), np.datetime64('2025-12-31')), size = num_rows)
date_series = pd.to_datetime(random_dates)

date_ids = date_series.strftime('%Y%m%d').astype(int)

data = {
	'DateID': date_ids,
	'ProductID': np.random.randint(1, 501, size = num_rows),
	'StoreID': np.random.randint(1, 51, size = num_rows),
	'CustomerID': np.random.randint(1, 1001, size = num_rows),
	'QuantityOrdered': np.random.randint(1, 21, size = num_rows),
}

df = pd.DataFrame(data)

df['DiscountPercent'] = np.random.uniform(0.02, 0.15, size=num_rows)
df['ShippingPercent'] = np.random.uniform(0.05, 0.15, size=num_rows)

df.to_csv('FactOrders.csv', index = False)