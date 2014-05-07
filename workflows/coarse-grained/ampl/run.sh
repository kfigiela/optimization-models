#!/bin/csh
#$ -M kfigiela@nd.edu
#$ -pe smp 1
#$ -m abe

module load ampl

fsync -d 30 $SGE_STDOUT_PATH &

ampl model.ampl
