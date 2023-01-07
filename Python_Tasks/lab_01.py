# Sara Mahmoud Abdelhafeez
# abdelhafeezsara73@gmail.com

# Receiving the variables from the user
string = input("String: ")
character = input("Character: ")
position = input("Position: ")


def mutate_string(string, index, character):
    string = string[:index] + character + string[index + 1:]    # Combine the string from the begining to the specified index -1 
                                                                # then add the character in the index
                                                                # then combine the rest of string
    return string

print(mutate_string(string, int(position), character))          # Receiving the new string and print it 
