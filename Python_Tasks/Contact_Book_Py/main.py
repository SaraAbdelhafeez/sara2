import user_input
import insert_bulk 
import delete_record
import update_record

def get_action():
    action = int()
    while True:
        # take the action number from user
        action = int(input('''
        What do you want to do ? 
        1) insert a new record
        2) update an existing record
        3) delete a record
        '''))
        # make sure that the user entered the correct action number
        if action == 1 or action == 2 or action == 3:
            break
        else:
            # in case the number is wronge it will ask him again
            print("Please Enter 1 or 2 or 3")
            continue
    return action
def get_input_method():
    input_number = int()  
    while True:
        # take the input method number from user
        input_number = int(input('''
        Which method you want to insert the data ?
        1) user input
        2) bulk file
        '''))
        # make sure that the user entered the correct input method number
        if input_number == 1 or input_number == 2:
            break
        else:
            # in case the number is wronge it will ask him again
            print("Please Enter 1 or 2")
            continue
    return input_number

while True:

    user_action = get_action()

    if user_action == 1:
        input_method = get_input_method()
        if input_method == 1:
            user_input.new_record()
        elif input_method == 2:
            date_file = input("Please Enter the path of the file that has data: ")
            insert_bulk.new_record(date_file)
    
    elif user_action == 2:
        update_record.update()
    
    elif user_action == 3:
        delete_record.delete()

    # after user finished his action ask him again ..
    if(input("Do you want to take another action ? ( y / n ) ").casefold() == 'n'):
        break


