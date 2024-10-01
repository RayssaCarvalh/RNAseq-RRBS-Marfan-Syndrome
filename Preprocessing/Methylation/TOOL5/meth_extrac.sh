#!/bin/bash

#PBS -N methextract
#PBS -q long
#PBS -l walltime=6:00:00:00
#PBS -l mem=64gb
#PBS -l nodes=1:ppn=1
#PBS -o /home/rrbs/TOOL5/out/MethExtract
#PBS -e /home/rrbs/TOOL5/out/MethExtract


date  ## echo the date at start
mkdir -p /home/rrbs/TOOL5/out/MethExtract
mkdir -p /home/rrbs/TOOL5/resultMethExtract

dirApps=/home/tools/miniconda3/bin
dirResult=/home/rrbs/TOOL5/resultMethExtract
dirGens=/home/rrbs/TOOL5/result/Conc
ref=/home/rrbs/TOOL5/reference

(cd "$dirGens"/

for file in *.bam
do
  if [ -f "$file" ]
  then
    "$dirApps"/bismark_methylation_extractor --single-end --bedGraph --output "$dirResult"/ --samtools_path "$dirApps"/ --gzip --multicore 10 --genome_folder "$ref"/ "$file"
  fi
done)

echo DONE

date  ## echo the date at end
