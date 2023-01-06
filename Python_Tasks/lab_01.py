# Sara Mahmoud Abdelhafeez
# abdelhafeezsara73@gmail.com

def mutate_string(string, index, character):

    string = string[:index] + character + string[index + 1:]
    return string

string = input("String: ")
character = input("Character: ")
position = input("Position: ")

print(mutate_string(string, int(position), character))