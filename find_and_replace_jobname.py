job_name = input("Enter new job name: ")


scripts = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14]

for x in scripts:
    # Replace in md_80ns_r1.sh
    replaced_in = open("md_80ns_r"+str(x)+".sh", "rt")
    data = replaced_in.read()
    data = data.replace("md_80ns_r", job_name+"_r")
    replaced_in.close()
    replaced_out = open("md_80ns_r"+str(x)+".sh", "wt")
    replaced_out.write(data)
    replaced_out.close()