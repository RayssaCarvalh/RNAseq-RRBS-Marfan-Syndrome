#!/bin/bash

#PBS -N index
#PBS -q short
#PBS -l nodes=1:ppn=16
#PBS -l mem=64gb
#PBS -l walltime=24:00:00
#PBS -j oe
#PBS -o /home/rayssa/rna/TOOL5/out/log.txt

mkdir -p /home/rayssa/rna/TOOL5/out
mkdir -p /home/rayssa/rna/TOOL5/index
mkdir -p /home/rayssa/rna/TOOL5/reference

genref=http://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_mouse/latest_release/GRCm39.primary_assembly.genome.fa.gz
gtffile=http://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_mouse/latest_release/gencode.vM28.primary_assembly.annotation.gtf.gz

ref=/home/rayssa/rna/TOOL5/reference              #this is a C57BL/6 primary assembly (PRI) - GTF and FASTA
result=/home/rayssa/rna/TOOL5/index


#Download reference genome from GenCode

(cd "$ref/"
wget -N "$genref"
wget -N "$gtffile"
echo Download OK
gunzip *.gz)


#Bismark - Preparar genoma de referencia
STAR --runMode genomeGenerate --runThreadN 16 --genomeDir "$result" --genomeFastaFiles "$ref"/*.fa --sjdbGTFfile "$ref"/*.gtf --sjdbOverhang 50


echo all DONE
