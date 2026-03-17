import os
import pandas as pd
import numpy as np

target_date = '2026-01-01'
order_date_id = int(target_date.replace('-', ''))

output_folder = r"C:\Users\yuval\OneDrive\שולחן העבודה\DWBI PROJECT\Data\DailyOrders"
os.makedirs(output_folder, exist_ok=True)

num_stores = 50
min_orders = 20
max_orders = 100

for store_id in range(1, num_stores + 1):

    num_orders = np.random.randint(min_orders, max_orders + 1)

    customer_ids = np.random.randint(1, 1001, size=num_orders)
    product_ids = np.random.randint(1, 501, size=num_orders)
    quantities = np.random.randint(1, 21, size=num_orders)

    discount_percents = np.round(np.random.uniform(0.02, 0.15, size=num_orders), 2)
    shipping_percents = np.round(np.random.uniform(0.05, 0.15, size=num_orders), 2)

    unit_prices = np.round(np.random.uniform(10, 500, size=num_orders), 2)

    base_amount = quantities * unit_prices

    discount_amount = np.round(base_amount * discount_percents, 2)
    shipping_amount = np.round(base_amount * shipping_percents, 2)

    total_amount = np.round(base_amount - discount_amount + shipping_amount, 2)

    df = pd.DataFrame({
        'CustomerID': customer_ids,
        'StoreID': store_id,
        'OrderDateID': order_date_id,
        'ProductID': product_ids,
        'Quantity': quantities,
        'DiscountPercent': discount_percents,
        'ShippingPercent': shipping_percents,
	  'DiscountAmount': discount_amount,
        'ShippingAmount': shipping_amount,
        'TotalAmount': total_amount
    })

    file_name = f"Store_{store_id}_{order_date_id}.csv"
    file_path = os.path.join(output_folder, file_name)

    df.to_csv(file_path, index=False)