#!/bin/bash

#PBS -N align
#PBS -q long
#PBS -l walltime=720:00:00
#PBS -l mem=64gb
#PBS -l nodes=1:ppn=32
#PBS -j oe
#PBS -o log.txt

mkdir -p /home/rayssa/rna/TOOL5/alignment

genomedir=/home/rayssa/rna/TOOL2/A
indexdir=/home/rayssa/rna/TOOL5/index/
resultdir=/home/rayssa/rna/TOOL5/alignment

cd "$genomedir"

for d in *
do
 (if [ -d "$d" ]
  then
    echo "$d"
    cd "$d"
    e=$(ls *_L003_*.fastq.gz)
    f=$(ls *_L004_*.fastq.gz)
    g=$(ls *_L005_*.fastq.gz)
    h=$(ls *_L006_*.fastq.gz)

    echo STARTING STAR ALIGNMENT
    STAR --runMode alignReads --runThreadN 32 --readFilesCommand zcat --outSAMtype BAM Unsorted --genomeDir "$indexdir" --readFilesIn "$genomedir"/"$d"/"$e","$genomedir"/"$d"/"$f","$genomedir"/"$d"/"$g","$genomedir"/"$d"/"$h" --outFileNamePrefix "$resultdir"/"$d"
    echo DONE
  fi)
done

echo DONE ALL
