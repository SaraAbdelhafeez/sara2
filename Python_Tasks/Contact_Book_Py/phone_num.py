
def get_phone_num():
    phone_numbers = []
    while True:
        phone_numbers.append(input("phone number: "))
        # ask user if he wants to add another phone number
        choice = input("Enter another number?? ( y / n )") 
        if choice.casefold() == 'n':
            break
    return phone_numbers