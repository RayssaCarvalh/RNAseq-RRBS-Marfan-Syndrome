#!/bin/bash

#SBATCH --job-name=fastqc
#SBATCH --partition=long
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --mem=64gb
#SBATCH --time=720:00:00
#SBATCH -e /home/rayssa/rna/TOOL3/out/slurm-%j.err
#SBATCH -o /home/rayssa/rna/TOOL3/out/slurm-%j.out


###Instalando FastQC################################################################
mkdir -p /home/rayssa/ToolsRay                                               #
cd /home/rayssa/ToolsRay/                                                    #
wget https://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.9.zip #
unzip fastqc_v0.11.9.zip                                                          #
chmod 755 FastQC/fastqc							   #
####################################################################################

echo "Versao do FastQC"
/home/rayssa/ToolsRay/FastQC/fastqc --version


mkdir -p /home/rayssa/rna/TOOL3/out		  #criando pasta out
mkdir -p /home/rayssa/rna/TOOL3/resultFastqc   	  #criando pasta de result do fastQC


resultfast=/home/rayssa/rna/TOOL3/resultFastqc

sampleDirA=/home/rayssa/rna/TOOL2/result/A

fastqcDir=/home/rayssa/ToolsRay/FastQC/ #criando a variavel com o local do FastQC



cd $sampleDirA

for d in *
do
  if [ -d "$d" ]
  then
    mkdir -p $resultfast/A/$d
    (
    echo "$d"
    cd $d
    for f in *L00[3-6]*.gz
    do
      if [ -f "$f" ]
      then
        echo FastQC "$f"
        $fastqcDir/fastqc $f --noextract --format fastq --outdir $resultfast/A/$d --threads 12
      fi
    done
    )
  fi
done


#______________________________________________________________________
###Instalando MultiQC################################################
conda install -c bioconda multiqc                                  #
#####################################################################

mkdir -p /home/rayssa/rna/TOOL3/resultMultiqc     #criando pasta de result do MultiQC

MultiQCdir=/home/rayssa/tools/miniconda3/bin/

resultmult=/home/rayssa/rna/TOOL3/resultMultiqc

echo "Versao do MultiQC"
$MultiQCdir/multiqc --version

cd $resultfast/A

for d in *
do
  if [ -d "$d" ]
  then
    mkdir -p $resultmult/A/$d
    (cd $d
    echo "MultiQC in $d"
    $MultiQCdir/multiqc -o $resultmult/A/$d --filename "$d" .
    )
  fi
done



####Para a B
sampleDirB=/home/rayssa/rna/TOOL2/result/B

cd $sampleDirB

for d in *
do
  if [ -d "$d" ]
  then
    mkdir -p $resultfast/B/$d
    (
    echo "$d"
    cd $d
    for f in *L00[3-6]*.gz
    do
      if [ -f "$f" ]
      then
        echo FastQC "$f"
        $fastqcDir/fastqc $f --noextract --format fastq --outdir $resultfast/B/$d --threads 12
      fi
    done
    )
  fi
done


#______________________________________________________________________
cd $resultfast/B

for d in *
do
  if [ -d "$d" ]
  then
    mkdir -p $resultmult/B/$d
    (cd $d
    echo "MultiQC in $d"
    $MultiQCdir/multiqc -o $resultmult/B/$d --filename "$d" .
    )
  fi
done
