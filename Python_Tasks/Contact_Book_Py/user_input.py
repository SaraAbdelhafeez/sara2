import csv
from datetime import datetime
from phone_num import get_phone_num
now = datetime.now()

def new_record():
    # receive the fields from user
    user_name = input("User Name: ")
    address = input("Address: ")
    email = input("Email: ")
    insertion_date = now.strftime("%d/%m/%Y %H:%M:%S")
    phone_numbers = get_phone_num()
    

    record = {
        "User Name": user_name, 
        "Address": address, 
        "Email": email, 
        "Phone Numbers": phone_numbers, 
        "Last Edit": insertion_date
    }
    field_names = [
        "User Name", 
        "Address", 
        "Email", 
        "Phone Numbers", 
        "Last Edit"
        ]
    file_name = "contactbook_" + now.strftime("%d%m%Y") + ".csv"
    
    with open(file_name, 'a') as file:
        csv_writer = csv.DictWriter(file, fieldnames=field_names)
        #csv_writer.writeheader()
        csv_writer.writerow(record)
