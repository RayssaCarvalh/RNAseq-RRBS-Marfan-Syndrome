#!/bin/bash

#PBS -N align
#PBS -q long
#PBS -l walltime=2:00:00:00
#PBS -l mem=64gb
#PBS -l nodes=1:ppn=16
#PBS -o /home/rrbs/TOOL5/out/align
#PBS -e /home/rrbs/TOOL5/out/align

mkdir -p /home/rrbs/TOOL5/out/align
mkdir -p /home/rrbs/TOOL5/result/NoConc
mkdir -p /home/rrbs/TOOL5/result/Conc

ref=/home/rrbs/TOOL5/reference #this is a C57BL/6 referebce genome
dirApps=/home/tools/miniconda3/bin
dirResult=/home/rrbs/TOOL5/result
dirGens=/home/rrbs/TOOL4/outTrim # sample trimmed path


##01##  #Alinhando os concatenados desde o inicio

#(cd "$dirGens"/Conc/
#
#for file in *.fq.gz
#do
#  if [ -f "$file" ]
#  then
#    "$dirApps"/bismark --fastq --path_to_bowtie2 "$dirApps"/ --samtools_path "$dirApps"/ --gzip --genome_folder "$ref"/ --output_dir "$dirResult"/Conc/ --temp_dir "$dirResult"/ --parallel 4 --single_end "$file"
#  fi
#done)



#Alinhando os que nao foram concatenados

(cd "$dirGens"/NoConc/Sample_Giovana_RRBS_870

for file in *.fq.gz
do
  if [ -f "$file" ]
  then
    "$dirApps"/bismark --fastq --path_to_bowtie2 "$dirApps"/ --samtools_path "$dirApps"/ --gzip --genome_folder "$ref"/ --output_dir "$dirResult"/NoConc/ --temp_dir "$dirResult"/ --parallel 4 --single_end "$file"
  fi
done)

echo DONE
