#!/bin/bash

#PBS -N extrac
#PBS -q long
#PBS -l walltime=1:00:00:00
#PBS -l mem=64gb
#PBS -l nodes=1:ppn=1
#PBS -o /home/rayssa/RNAseq/TOOL1/out
#PBS -e /home/rayssa/RNAseq/TOOL1/out

mkdir -p /home/rayssa/RNAseq/TOOL1/out
mkdir -p /home/rayssa/RNAseq/TOOL1/result

#installing 7-zip
#wget https://www.7-zip.org/a/7z2103-linux-x64.tar.xz
##################

#Script to test and extract RNAseq sequencing files that are compressed
/home/rayssa/ToolsRay/7zz t /home/rayssa/RNAseq/RawData/RNA.zip
echo DONE

/home/gustribeiro/ToolsRay/7zz x /home/gustribeiro/RNAseq/RawData/RNA.zip -o/home/gustribeiro/RNAseq/TOOL1/result
echo DONE
