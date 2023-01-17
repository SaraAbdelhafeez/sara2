import delete_record
import user_input
def update():
    # in this fun the record that we want to update we delete it and re-insert it 
    delete_record.delete()
    print("Enter the new user's data")
    user_input.new_record()