#!/usr/bin/perl

## Note, this is ran on the head node, after having already run the setup_enzdes_ script which gives the main directory and all the template files
#  Also, can specify nstruct 

#USAGE: .run_modeling_parallel.pl list_of_proteins total_number_of_nstructs number_per_job (typicall 1000 100) name_for_qsub

use strict;
use warnings;
use Cwd;
use lib '/share/siegellab/software/fast_cm/perl_lib';
use Parallel::ForkManager;
use Rosetta::META::ReadList;
use Rosetta::QSUB;
use Rosetta::UTIL::ArgCheck;
use Parallel::ForkManager;
use POSIX;

my $usage_string = "ARG1 = list of proteins (autogen previously) ARG2= total nstructs desired  ARG3= how many per folder  ARG4= name for qsub\n";
ArgCheck::check2(4,($#ARGV+1),$usage_string);

my $start_dir = getcwd;
my $nstruct_total = $ARGV[1];
my $nstruct_per_folder = $ARGV[2];

my $list_ref = ReadList::read_list( $ARGV[0] );
my $number_of_proteins = scalar @$list_ref;
my $jobs_per_pro = ceil($nstruct_total/$nstruct_per_folder);
my $total_jobs = $number_of_proteins*$jobs_per_pro;

print "my # proteins in list is $number_of_proteins and the total number of jobs is $total_jobs \n";
my $max_nodes =5;
my $tc_value = $max_nodes;
#my $nstruct_per = 200;
#my $tc_start = 5;
#my $tc_end = 15;

foreach my $protein (@$list_ref){     ##start a fork here that waits for each qsub to finish and for each one that completes, it can then go on to recombine the silent files into a master output file(and clean up)

    chomp($protein);
    my $protein_dir = $start_dir."/models/".$protein."/model/";
#    my $protein_dir = $start_dir."/models/".$protein."/withatompair/";
#    my $protein_dir = $start_dir."/models/".$protein."/model_nofancy/";
    print "my dir for $protein is $protein_dir \n";
    chdir($protein_dir);
    if (! -e "$protein_dir/1/default.out"){
    QSUB::parallel_modeling_cluster( $protein_dir, $protein , $nstruct_total, $nstruct_per_folder,$tc_value,$ARGV[3]);
  }
    else {
	print "this $protein is already modelled \n";
    }
#special usage case below
#    QSUB::parallel_modeling_cluster2( $protein_dir, $protein , $nstruct_per, $tc_start, $tc_end , $ARGV[3]);
}




