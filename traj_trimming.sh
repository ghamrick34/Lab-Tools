(echo 1 \| 13; echo q;) | gmx make_ndx -f npt.gro -o pdb.ndx
# this 24 number will change from system to system and needs to be read out from .ndx file
(echo 18; echo 0;) | gmx trjconv -f traj_comp.xtc -s 960-1040ns.tpr -n pdb.ndx -o nojump.xtc -pbc nojump -center
(echo 1; echo 0;) | gmx trjconv -f nojump.xtc -s 960-1040ns.tpr -n pdb.ndx -o nojumpwhole.xtc -pbc whole -center
(echo 1; echo 0;) | gmx trjconv -f nojumpwhole.xtc -s 960-1040ns.tpr -n pdb.ndx -o nojumpwholeatom.xtc -pbc atom -ur compact -center
(echo 1; echo 0;) | gmx trjconv -f nojumpwholeatom.xtc -s 960-1040ns.tpr -n pdb.ndx -o nojumpwholeatomwhole.xtc -pbc whole -center