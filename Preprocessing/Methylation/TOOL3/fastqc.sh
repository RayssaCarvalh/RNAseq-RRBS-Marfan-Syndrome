#!/bin/bash

#PBS -N fastqc
#PBS -q long
#PBS -l walltime=1:00:00:00
#PBS -l mem=64gb
#PBS -l nodes=1:ppn=1
#PBS -o /home/rrbs/TOOL3/out/
#PBS -e /home/rrbs/TOOL3/out

###Instalando FastQC################################################################
#mkdir -p /home/ToolsRay                                               #
#cd /home/ToolsRay/                                                    #
#wget https://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.9.zip #
#unzip fastqc_v0.11.9.zip                                                          #
#chmod 755 FastQC/fastqc							   #
####################################################################################

echo "Versao do FastQC"
/home/ToolsRay/FastQC/fastqc --version


mkdir -p /home/rrbs/TOOL3/out		  #criando pasta out
mkdir -p /home/rrbs/TOOL3/outFastqc   	  #criando pasta de output
mkdir -p /home/rrbs/TOOL3/outFastqc/outFastqcNoFilter   #criando pasta de output
mkdir -p /home/rrbs/TOOL3/outFastqc/Casava   #criando pasta de output
mkdir -p /home/rrbs/TOOL3/outFastqc/Merged   #criando pasta de output


outputCa=/home/rrbs/TOOL3/outFastqc/Casava/		    #criando a variavel com o local de output - Para casava com filtro
outputNo=/home/rrbs/TOOL3/outFastqc/outFastqcNoFilter/  #criando a variavel com o local de output - Para NoFilter
outputMe=/home/rrbs/TOOL3/outFastqc/Merged/		    #criando a variavel com o local de output - Para o mesclado

sampleDir=/home/rrbs/Users/path/to/samples
concDir=/home/rrbs/TOOL2/cat/
fastqcDir=/home/ToolsRay/FastQC/ #criando a variavel com o local do FastQC


echo "FastQC na amostras concatenadas"
$fastqcDir/fastqc $concDir/*.fastq.gz --noextract --format fastq --outdir $outputMe --threads 12


cd $sampleDir

for d in *
do
  if [ -d "$d" ]
  then
    (echo "$d"
    echo "FastQC Casava com Filtro"
    $fastqcDir/fastqc --casava $d/*.fastq.gz --noextract --format fastq --outdir $outputCa --threads 12

    echo "FastQC sem Filtro"
    $fastqcDir/fastqc --casava $d/*.fastq.gz --nofilter --noextract --format fastq --outdir $outputNo --threads 12
    )    
  fi
done


#______________________________________________________________________
###Instalando MultiQC################################################
#conda install -c bioconda multiqc                                  #
#####################################################################

mkdir -p /home/rrbs/TOOL3/outMulti

MultiQCdir=/home/tools/miniconda3/bin/
outM=/home/rrbs/TOOL3/outMulti/

echo "Versao do MultiQC"
$MultiQCdir/multiqc --version

cd /home/rrbs/TOOL3/outFastqc/

for d in *
do
  if [ -d "$d" ]
  then
    (cd $d
    echo "MultiQC in $d"
    $MultiQCdir/multiqc -o $outM --filename "$d" .
    )
  fi
done
