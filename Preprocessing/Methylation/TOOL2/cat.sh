#!/bin/bash

#PBS -N cat
#PBS -q long
#PBS -l walltime=1:00:00:00
#PBS -l mem=64gb
#PBS -l nodes=1:ppn=1
#PBS -o /home/rrbs/TOOL2/out
#PBS -e /home/rrbs/TOOL2/out

#####  IT IS NOT NECESSARY TO MERGE LANES TO USE ALIGNMENT TOOLS  ####
 
mkdir -p /home/rrbs/TOOL2/cat
mkdir -p /home/rrbs/TOOL2/out

dircat=/home/rrbs/TOOL2/cat/
dir=/home/rrbs/path/to/samples #Directory where are the samples
cd $dir 							    #Changing the directory

##############################################################################################
#For the files in the folder, check if it is a directory. If it is: Merge the fastq.gz files.#
#Change the directory according to the sample. Merge only files of the same sample           #
##############################################################################################

for d in *                              					#For each file in the directory
do
	if [ -d "$d" ]                  					#if it's directory
    	then
	                                					# Will not run if no directories are available
		echo "$d"
      		echo "__________________________________________________________"
		(cd $d                  					#Precisa do parenteses para criar um subshell abrindo cada diretório, direto não vai
		                        					#Inside the sample directory
		rm -f $dircat/Conc_"${d}".fastq.gz				#remove if this file already exists
		for a in *fastq.gz      					#For each fastq.gz file
										#(Posso arrumar aqui para usar em paired end (R1 e R2 posteriormente) -com um if talvez? if *R1* ... ;then)
		do
			aname=$(basename "$a" .fastq.gz)
			echo "$aname"						#Nome do Arquivo
        		zcat $a | wc -l						#Quantidade de lihas dos arquivos individuais
			zcat $a | gzip --fast >> $dircat/Conc_"${d}".fastq.gz   #&& rm $a #####Merge the files of the same samples in a file named:Conc_Name_of_the_Sample
		done
		)
	fi
	echo "Quantidade de Linhas apos o cat command"
	zcat $dircat/Conc_"${d}".fastq.gz | wc -l
done
