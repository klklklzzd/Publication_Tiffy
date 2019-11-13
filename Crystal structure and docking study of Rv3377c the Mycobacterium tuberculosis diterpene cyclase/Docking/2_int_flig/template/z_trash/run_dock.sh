#!/bin/bash
#SBATCH --job-name=m1_A
#SBATCH --output=logs.dock
#SBATCH -o dock.out
#SBATCH --mem 4G 
#SBATCH --time 100
#####SBATCH --nodes 1 

#cp -r ./template ./$SLURM_ARRAY_TASK_ID
#cd ./$SLURM_ARRAY_TASK_ID
time ~/Rosetta/main/source/bin/rosetta_scripts.default.linuxgccrelease @flags -parser:protocol dock2.xml -nstruct 5 -ignore_zero_occupancy F
#cd ..
