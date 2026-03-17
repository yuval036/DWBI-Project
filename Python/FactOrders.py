import pandas as pd
import numpy as np

num_rows = int(input("Enter the number of rows you want to genetate: "))
random_dates = np.random.choice( np.arange(np.datetime64('2015-01-01'), np.datetime64('2025-12-31')), size = num_rows)
date_series = pd.to_datetime(random_dates)

date_ids = date_series.strftime('%Y%m%d').astype(int)

data = {
    'CustomerID': np.random.randint(1, 1001, size = num_rows),
    'StoreID': np.random.randint(1, 51, size = num_rows),
	'OrderDateID': date_ids,
	'ProductID': np.random.randint(1, 501, size = num_rows),
	'Quantity': np.random.randint(1, 21, size = num_rows),
}

df = pd.DataFrame(data)

df['DiscountPercent'] = np.round(np.random.uniform(0.02, 0.15, size=num_rows), 2)
df['ShippingPercent'] = np.round(np.random.uniform(0.05, 0.15, size=num_rows), 2)

df['UnitPrice'] = np.random.uniform(10, 500, size=num_rows)
df['BaseAmount'] = df['Quantity'] * df['UnitPrice']

df['DiscountAmount'] = df['BaseAmount'] * df['DiscountPercent']
df['ShippingAmount'] = df['BaseAmount'] * df['ShippingPercent']

df['TotalAmount'] = df['BaseAmount'] - df['DiscountAmount'] + df['ShippingAmount']

df = df.drop(columns=['UnitPrice', 'BaseAmount'])

df.to_csv('FactOrders.csv', index = False)