#!/bin/bash
#SBATCH --job-name=RV
#SBATCH --output=logs.dock
#SBATCH -o dock.out
#SBATCH --mem-per-cpu=4G 
#SBATCH --time 170
#####SBATCH --nodes 1 

cp -r ./template ./$SLURM_ARRAY_TASK_ID
cd ./$SLURM_ARRAY_TASK_ID
time /share/siegellab/tiffy/rosetta_bin_linux_2018.09.60072_bundle/main/source/bin/rosetta_scripts.default.linuxgccrelease @flags -parser:protocol dock2.xml -nstruct 10 -ignore_zero_occupancy F
cd ..
