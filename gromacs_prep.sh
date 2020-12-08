#! /bin/sh

# This is a script for preparing the .gro and .top files required for submission to Stampede2,
# based on the GROMACS tutorial provided by Dr. Lemkul at the Virginia Tech 
# Department of Biochemistry. It includes changes specific to ACP-KS simulations, such
# as the use of the charmm36-191214.ff package (with PNS) developed by Coire Gavin-Hanner,
# as well as processing of I-TASSER-generated structures (find-and-replace).

# Ask user for name of .pdb file
echo Enter the name of the .pdb file you would like to process. Note: omit ".pdb":
read filename

echo Enter the name of the job that should appear on Stampede2:
read jobname

# Remove water molecules (although there likely aren't any)
grep -v HOH $filename.pdb > clean.pdb

# Process .pdb files after I-TASSER generation. These files typically use a slightly differrent
# syntax for atoms, particulalry protons, often in SER or CYS residues.
python find_and_replace.py

# Generate initial .gro and .top and choose water model
(echo 1) | gmx pdb2gmx -f replaced.pdb -o processed.gro -water tip3p

# Initialize a cubic box
gmx editconf -f processed.gro -o newbox.gro -c -d 1.0 -bt cubic

# Add solvent (water)
gmx solvate -cp newbox.gro -cs spc216.gro -o solv.gro -p topol.top

# Add ions. Assemble .tpr file, then add NA and CL to neutralize
gmx grompp -f ions.mdp -c solv.gro -p topol.top -o ions.tpr
(echo 13) | gmx genion -s ions.tpr -o solv_ions.gro -p topol.top -pname NA -nname CL -neutral

# Energy minimization
gmx grompp -f minim.mdp -c solv_ions.gro -p topol.top -o em.tpr
gmx mdrun -v -deffnm em

# Now the necessary files generated by this process (all .itp, em.gro, and topol.top)
# can be ported to Stampede2 for job submission.
cp *.itp ../to_Stampede
cp topol.top ../to_Stampede
cp em.gro ../to_Stampede

cd ../to_Stampede

# Rename jobs
(echo \"${jobname}\") | python find_and_replace_jobname.py