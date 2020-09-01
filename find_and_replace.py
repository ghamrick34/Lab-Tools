#input file
fin = open("clean.pdb", "rt")
#output file to write the result to
fout = open("replaced.pdb", "wt")
#for each line in the input file
for line in fin:
	#read replace the string and write to output file
	fout.write(line)
#close input and output files
fin.close()
fout.close()

replaced_in = open("replaced.pdb", "rt")
data = replaced_in.read()
data = data.replace('HG  SER', 'HG1 SER')
data = data.replace('HG  CYS', 'HG1 CYS')
replaced_in.close()
replaced_out = open("replaced.pdb", "wt")
replaced_out.write(data)
replaced_out.close()
