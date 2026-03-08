import pandas as pd

start_date = '2015-01-01'
end_date = '2025-12-31'

date_range = pd.date_range(start = start_date, end = end_date)
date_dimension = pd.DataFrame(date_range, columns = ['Date'])

date_dimension['DayOfWeek'] = date_dimension['Date'].dt.dayofweek.astype(int)
date_dimension['Month'] = date_dimension['Date'].dt.month
date_dimension['Quarter'] = date_dimension['Date'].dt.quarter
date_dimension['Year'] = date_dimension['Date'].dt.year
date_dimension['IsWeekend'] = date_dimension['DayOfWeek'].isin([5, 6]).astype(int)
date_dimension['DateID'] = date_dimension['Date'].dt.strftime('%Y%m%d').astype(int)

cols = ['DateID'] + [col for col in date_dimension.columns if col != 'DateID']
date_dimension = date_dimension[cols]

date_dimension.to_csv(r'C:\Users\yuval\OneDrive\שולחן העבודה\DWBI PROJECT\DimDate.csv',
                      index=False)