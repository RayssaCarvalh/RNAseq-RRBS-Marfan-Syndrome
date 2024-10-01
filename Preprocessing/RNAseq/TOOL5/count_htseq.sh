#!/bin/bash

#SBATCH --job-name=count
#SBATCH --partition=long
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --mem=64gb
#SBATCH --time=720:00:00
#SBATCH -e /home/rayssa/rna/TOOL5/out/slurm-%j.err
#SBATCH -o /home/rayssa/rna/TOOL5/out/slurm-%j.out

mkdir -p /home/rayssa/rna/TOOL5/HTseqCount
mkdir -p /home/rayssa/rna/TOOL5/sorted

dirGens=/home/rayssa/rna/TOOL5/alignment
dirResult=/home/rayssa/rna/TOOL5/sorted
dirResultCount=/home/rayssa/rna/TOOL5/HTseqCount
gtffile=/home/rayssa/rna/TOOL5/reference
dirApps=/home/rayssa/tools/miniconda3/bin

"$dirApps"/samtools --version

####SORT WITH SAMTOOLS NA NAO CONCATENADA####

#(cd "$dirGens"/

#for file in *.bam
#do
#  fileName=$(basename "$file" .bam)
#  "$dirApps"/samtools sort -@ 16 -o "$dirResult"/"$fileName".sorted.bam "$file"
#done)

echo DONE PART ONE before

"$dirApps"/htseq-count --version

(cd "$dirResult"/

for file in *.bam
do
  "$dirApps"/htseq-count -f bam -r pos -m union -s no -t exon "$dirResult"/"$file" "$gtffile"/*.gtf > "$dirResultCount"/sorted-"$file"-STAR-HTSeq.txt
done)

echo DONE PART TWO
