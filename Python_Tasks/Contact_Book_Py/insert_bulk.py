import csv
from datetime import datetime

now = datetime.now()

def new_record(data_file): 
    
    # read data from file that it's path is data_file

    with open(data_file, 'r') as data_file:     
        csv_reader = csv.reader(data_file, delimiter=',')  

        # the file will saved with the date in which it is created
        file_name = "contactbook_" + now.strftime("%d%m%Y") + ".csv"

        # add the data in the created file
        with open(file_name, 'a') as file:
            csv_writer = csv.writer(file)

            for line in csv_reader:
                csv_writer.writerow(line)

