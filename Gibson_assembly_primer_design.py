### This script can be used to quickly and easily producing forward and reverse primers for the Gibson Assembly of an input gene block between the NdeI and EcoRI restriction sites of a pET-28 expression vector.
def numGRO(sequence):
    result = ""
    for character in sequence:
        if character.isalpha():
            result = result + character
        else:
            result = result
    return result

gene_sequence = numGRO(input("Enter the coding sequence of the protein of interest: "))

A = "agcggcctggtgccgcgcggcagccatatg"
B = "gccgcaagcttgtcgacggagctcgaattc"

C_input = gene_sequence[:22]
if C_input[:3] == "atg":
    C = C_input[3:22]
else:
    C = C_input[:19]

D_input = gene_sequence[-19:]

D = ""
for i in D_input:
    if i == "a":
        D = D + "t"
    elif i == "t":
        D = D + "a"
    elif i == "g":
        D = D + "c"
    elif i == "c":
        D = D + "g"
    else:
        print("Error: Unrecognized nucleotide.")

print(C_input[:3])
print(C_input)
print(C)
print("\n\n\n Forward Primer (from NdeI on): " + A + C)
print("\n\n Reverse Primer (up to EcoRI): " + B + D + "\n\n\n")

