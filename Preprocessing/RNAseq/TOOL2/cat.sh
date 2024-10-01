#!/bin/bash

#PBS -N cat
#PBS -q long
#PBS -l walltime=1:00:00:00
#PBS -l mem=64gb
#PBS -l nodes=1:ppn=1
#PBS -o /home/RNAseq/TOOL2/out/
#PBS -e /home/RNAseq/TOOL2/out/

#####  IT IS NOT NECESSARY TO MERGE LANES TO USE ALIGNMENT TOOLS  ####


mkdir -p /home/RNAseq/TOOL2/result/A
mkdir -p /home/RNAseq/TOOL2/result/B
mkdir -p /home/RNAseq/TOOL2/out

dirResult=/home/RNAseq/TOOL2/result
dirA=/home/RNAseq/TOOL1/result/RNA/141103_SN914_0438_AC565GACXX/original.fastq/ #Directory where are the samples A
dirB=/home/RNAseq/TOOL1/result/RNA/141103_SN914_0439_BC55R8ACXX/original.fastq/ #Directory where are the samples B



cd $dirA							    #Changing the directory

for d in *
do
  if [ -d "$d" ]
  then
    mkdir -p $dirResult/A/"$d"
    (
    echo "$d"
    cd "$d"
    for f in *L00[3-6]*.gz
    do
      if [ -f "$f" ]
      then
        newname="$(echo "$f" | cut -c1-30)"
        #echo $newname new
        echo "$f" - Quantidade de linhas arquivo individual
	zcat $f | wc -l						#Quantidade de lihas dos arquivos individuais
        zcat $f | gzip --fast >> "$dirResult"/A/"$d"/$newname.fastq.gz		#####Merge the files of the same Lanes in a file
      fi
    done)

    (cd "$dirResult"/A/"$d"
    for f in *.fastq.gz
    do
      if [ -f "$f" ]
      then
        echo $f - Quantidade de Linhas apos o cat command
        zcat $f | wc -l
      fi 
    done)
  fi
done


cd $dirB

for d in *
do
  if [ -d "$d" ]
  then
    mkdir -p $dirResult/B/"$d"
    (
    echo "$d"
    cd "$d"
    for f in *L00[3-6]*.gz
    do
      if [ -f "$f" ]
      then
        newname="$(echo "$f" | cut -c1-30)"
        #echo $newname new
        echo "$f" - Quantidade de linhas arquivo individual
        zcat $f | wc -l                                         #Quantidade de lihas dos arquivos individuais
        zcat $f | gzip --fast >> "$dirResult"/B/"$d"/$newname.fastq.gz          #####Merge the files of the same Lanes in a file
      fi
    done)

    (cd "$dirResult"/B/"$d"
    for f in *.fastq.gz
    do
      if [ -f "$f" ]
      then
        echo $f - Quantidade de Linhas apos o cat command
        zcat $f | wc -l
      fi
    done)
  fi
done
