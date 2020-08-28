
def numGRO(sequence):
    result = ""
    for character in sequence:
        if character.isalpha():
            result = result + character
        else:
            result = result
    return result

sequence = numGRO(input("Copy and paste your FASTA-style sequence here: "))

print("\n\n\nHere is your sequence without numbers: \n")
print(sequence, "\n\n\n\n")
