import csv
from datetime import datetime
now = datetime.now()

def delete():

    # our keyword is the user name
    key_word = input("Enter user name that you want to update his data: ") 
    file_name = "contactbook_" + now.strftime("%d%m%Y") + ".csv"

    # read the file that we want to delete a record in it 
    with open(file_name,'r') as read:
        csv_reader = csv.reader(read)
        # take a copy from it in an altrnative file execpt the row that we want to delete
        with open ('altrnative.csv','w') as write:
            csv_writer = csv.writer(write)
            for line in csv_reader:
                if line[0] == key_word:
                    continue
                csv_writer.writerow(line)
    # read from the altrnative file 
    with open('altrnative.csv','r') as read2:
        csv_reader2 = csv.reader(read2)
        # write again in the old file the updated rows
        with open (file_name,'w') as write2:
            csv_writer2 = csv.writer(write2)
            for line in csv_reader2:
                csv_writer2.writerow(line)
      