#!/bin/bash

#PBS -N index
#PBS -q long
#PBS -l walltime=1:00:00:00
#PBS -l mem=64gb
#PBS -l nodes=1:ppn=1
#PBS -o /home/rrbs/TOOL5/out/index
#PBS -e /home/rrbs/TOOL5/out/index

mkdir -p /home/rrbs/TOOL5/out/index
mkdir -p /home/rrbs/TOOL5/reference
mkdir -p /home/rrbs/TOOL5/result

#Installing Bismark####
#conda install bismark#
#######################

genref=https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/001/635/GCF_000001635.27_GRCm39/GCF_000001635.27_GRCm39_genomic.fna.gz  #refseq
ref=/home/rrbs/TOOL5/reference #this is a C57BL/6
dirApps=/home/tools/miniconda3/bin


#Download reference genome from RefSeq
(cd "$ref/"
wget -N "$genref"

for file in *.fna.gz
do
  if [ -f "$file" ]
  then
    fname=$(basename "$file" .fna.gz)
    cp -n "$file" "$fname".fa.gz #TRANSFORMANDO NO FORMATO RECONHECIDO PELO BISMARK
    rm "$file"
  fi
done)

#Bismark - Preparar genoma de referência
"$dirApps"/bismark_genome_preparation --bowtie2 --path_to_aligner "$dirApps"/ --verbose "$ref"/
