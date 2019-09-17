#!/bin/bash
#SBATCH --job-name=2meh
#SBATCH --output=logs.dock
#SBATCH -o dock.out
#SBATCH --mem 4G
#SBATCH --time 30
#SBATCH -p gc128

cp -r ./template ./$SLURM_ARRAY_TASK_ID
cd ./$SLURM_ARRAY_TASK_ID
time  /home/teobrien/Rosetta/main/source/bin/rosetta_scripts.default.linuxgccrelease @flags -parser:protocol meh_dock.xml -nstruct 5  -ignore_zero_occupancy F 
#time  /home/bertolan/rosetta_new/Rosetta/main/source/bin/rosetta_scripts.default.linuxgccrelease @flags -parser:protocol meh_dock.xml -nstruct 5  -ignore_zero_occupancy F #-out:level 3
cd ..
