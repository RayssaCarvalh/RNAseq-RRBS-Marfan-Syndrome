#!/bin/bash

#PBS -N Trim
#PBS -q long
#PBS -l walltime=1:00:00:00
#PBS -l mem=64gb
#PBS -l nodes=1:ppn=1
#PBS -o /home/rrbs/TOOL4/out
#PBS -e /home/rrbs/TOOL4/out

###Instalando Trim Galore!##########################################
#curl -fsSL https://github.com/FelixKrueger/TrimGalore/archive/0.6.6.tar.gz -o trim_galore.tar.gz
#tar xvzf trim_galore.tar.gz
####################################################################


###Instalando CutAdapt##############################################
#conda create -n cutadaptenv cutadapt
# To activate this environment, use
#
#     $ conda activate cutadaptenv
#
# To deactivate an active environment, use
#
#     $ conda deactivate
###################################################################


mkdir -p /home/rrbs/TOOL4/out		  #criando pasta out and error
mkdir -p /home/rrbs/TOOL4/outTrim   	  #criando pasta de output

mkdir -p /home/rrbs/TOOL4/outTrim/Conc
mkdir -p /home/rrbs/TOOL4/outTrim/NoConc

outDirConc=/home/rrbs/TOOL4/outTrim/Conc/
outDirNoConc=/home/rrbs/TOOL4/outTrim/NoConc


trimDir=/home/ToolsRay/TrimGalore-0.6.6
cutDir=/home/tools/miniconda3/envs/cutadaptenv/bin

sampleDir=/home/rrbs/Users/wilsonjr/Desktop/RRBS_Profa_Lygia/
sampleconcDir=/home/rrbs/TOOL2/cat

echo Versao do CutAdapt
$cutDir/cutadapt --version

echo Versao do Trim Galore!
$trimDir/trim_galore --version

#echo Trim Galore Conc
#$trimDir/trim_galore --rrbs -q 30 --path_to_cutadapt $cutDir/cutadapt --output_dir $outDirConc --cores 4 $sampleconcDir/*.fastq.gz

cd $sampleDir

for d in *
do
  if [ -d "$d" ]
  then
    (cd "$d"
    echo Trim Galore NoConc
    echo "$d"
    mkdir -p $outDirNoConc/"$d"
    $trimDir/trim_galore --rrbs -q 30 --path_to_cutadapt $cutDir/cutadapt --output_dir $outDirNoConc/"$d" --cores 4 *.fastq.gz
    )    
  fi
done
