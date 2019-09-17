#!/bin/bash
#SBATCH --job-name=ks
#SBATCH --output=logs.dock
#SBATCH -o dock.out
#SBATCH --mem-per-cpu=4G 
#SBATCH --time 100
#SBATCH -p production 

cp -r ./template ./$SLURM_ARRAY_TASK_ID
cd ./$SLURM_ARRAY_TASK_ID
/share/siegellab/tiffy/rosetta_bin_linux_2018.09.60072_bundle/main/source/bin/rosetta_scripts.default.linuxgccrelease @flags -parser:protocol ks_dock.xml -nstruct 1 -ignore_zero_occupancy F
cd ..
