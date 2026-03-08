import random
import csv 
from faker import Faker 

fake = Faker()
num_rows = int(input("Enter the number of rows you want to genetate: "))
header = ['Firs Name', 'Last Name', 'Gender', 'DateOfBirth', 'Email', 'Phon Number', 'Address', 'City', 'State', 'Country', 'ZipCode', 'LoyaltyProgramID']
with open('DimCustomers.csv', mode = 'w', newline = '') as file:
	writer = csv.writer(file)
	writer.writerow(header)
	for _ in range(num_rows):
		row = [
			fake.first_name(), 
			fake.last_name(),
			random.choice(['M', 'F']),
			fake.date(),
			fake.email(),
			fake.phone_number(),
			 fake.street_address(),
 			fake.city(),		
 			fake.state(),
			fake.country(),
			fake.postcode(),
			random.randint(1, 5) 
		]
		writer.writerow(row)