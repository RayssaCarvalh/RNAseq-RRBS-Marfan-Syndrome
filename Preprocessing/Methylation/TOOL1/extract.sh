#!/bin/bash

#PBS -N extrac
#PBS -q long
#PBS -l walltime=1:00:00:00
#PBS -l mem=64gb
#PBS -l nodes=1:ppn=1
#PBS -o /home/rayssa/rrbs/TOOL1/extrac
#PBS -e /home/rayssa/rrbs/TOOL1/extrac

#Script to extract RRBS sequencing files that are compressed
tar -zxvf /home/rayssa/rrbs/RRBS_Profa_Lygia.tar.gz Users/wilsonjr/Desktop/RRBS_Profa_Lygia

#z - compress/decompress files using gzip/gunzip
#x - extract the contents of the tar file
#v - show messages
#f - defines the name of the tar file that will be extracted
