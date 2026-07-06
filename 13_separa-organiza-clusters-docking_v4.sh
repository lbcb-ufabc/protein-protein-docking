#!/bin/bash
#
# ultima alteracao
# 16/11/2017
#
# nome: 13_separa-organiza-clusters-docking_v4.sh
#
#
# command line: sh 13_separa-organiza-clusters-docking_v4.sh ou  ./13_separa-organiza-clusters-docking_v4.sh
##################################################################################
#  	Script adaptado por Eric Allison Philot.
#       Eric Allison Philot
#       Fabio Filippi Matiolo
#
#  	e-mail: ericphilot@hotmail.com
#
#       script original: Angelica Nakagawa Lima
#
# Descricao:
# Cria a pasta cluster ($raiz/pos_docking/cluster) e organiza os dados. Separa o resultado
# por subpastas com os dados dos clusters e informacoes de energia.
#--------------------------------------------------------------------------------- 
# variaveis:
#
# input: 
# 1) arquivos tipo cluster.pdb*.pdb (cluster.pdb%02d.pdb) gerado pela clusterizacao no gromacs
# contidos na $raiz/pos_docking/primeiras_10/
# 2) nomes-frames.txt : nome dos frames. Arquivo na pasta
# $raiz/pos_docking/primeiras_10/
# 3) energy_sorted.txt: arquivo com a energia ordenada. Arquivo na pasta
# $raiz/pos_docking/primeiras_10/
#
# output:
# 1) pasta cluster no caminho
# $raiz/pos_docking/cluster 
# com os arquivos inform.txt inform_sorted.txt
# 2) subpastas na pasta cluster
# cluster_01 ... /cluster_47 
# 3) arquivos nas subpastas (exemplo)
# cluster.pdb01.pdb: arquivo pdb do cluster 01 obtido pelo gromacs
# cluster_01.txt: arquivo com as seguintes informacoes por coluna
# nome do arquivo pdb do cluster gerado pelo gromacs; frame; nome pdb complexo; frame; energia hex; nome pdb complexo
# por exemplo:
# nome do cluster    frame  nome pdb complexo          frame   energia hex     nome pdb complexo
# cluster.pdb01.pdb    13   m15_2.8_m65_-2.8_0005.pdb    13    -4.026375e+02  m15_2.8_m65_-2.8_0005.pdb
#
# cluster_01_sorted.txt: mesmo arquivo descrito acima ordenado por energia
# arquivos com os pdbs dos complexos que formam o cluster. Por exemplo: m15_2.8_m65_-2.8_0005.pdb
# 
##################################################################################

# definicao da variavel/diretorio raiz - automatico
# diretorio raiz de execucao dos scripts
raiz=$(pwd)


echo " "
echo "###########################################################################"
echo "Etapa 13: Cria a pasta cluster (..../pos_docking/cluster) e organiza os dados."
echo "Separa o resultado por subpastas com os dados dos clusters e informacoes de energia."
echo " "
echo " "
echo " "
echo "###########################################################################"
echo " "
# caminho
caminho="$raiz/pos_docking/"

echo "caminho : $caminho"
echo " "
echo "###########################################################################"
echo " "


cd "$caminho"

cd primeiras_10

#----------------------------------------------------------------------------------
# parte 1
pwd

rm -r ../cluster
mkdir ../cluster

cp cluster.pdb*.pdb ../cluster

cd ../cluster


rm ord_temp1.txt ord_temp2.txt ord_temp3.txt

# Loop for files
for f in *.pdb; do # begin for 1

  # coleta valor de energia do pdb do complexo
  cat $f | grep "TITLE" | awk '{printf "%3d\n", $4}' >> ord_temp1.txt

  # coleta numero de estruturas no cluster
  frames=$(cat $f | grep "TITLE" | wc -l)

  # considerando o numero de estruturas no cluster
  # Loop for all structures in a cluster
  for i in $(seq 1 $frames) ; do

    # coleta nome do arquivo do complexo
    echo $f >> ord_temp2.txt

  done
done # end for 1

paste ord_temp2.txt ord_temp1.txt > ord_temp3.txt



#----------------------------------------------------------------------------------
# parte 2


rm temporary.txt temporary2.txt 


cat ord_temp3.txt | awk '{print $2}' > auxiliar1.txt

cat auxiliar1.txt | while read linha; do # inicio do while

#  echo $linha
 
  cat ../primeiras_10/nomes-frames.txt | awk '{if (($2 == "'$linha'"))  print}'  >> temporary.txt


done # fim do while


awk '{printf "%-30s    %4d \n", $1, $2}' temporary.txt > temporary1.txt

paste ord_temp3.txt temporary1.txt > temporary2.txt

#rm auxiliar1.txt

#----------------------------------------------------------------------------------
# parte 3


rm temporary10.txt


cat temporary2.txt | awk '{print $3}' > auxiliar2.txt

cat auxiliar2.txt | while read linha; do # inicio do while

#  echo $linha
 
  cat ../energy_sorted.txt | awk '{if (($2 == "'$linha'"))  print}'  >> temporary10.txt


done # fim do while


paste temporary2.txt temporary10.txt > temporary11.txt


awk '{printf "%-20s    %4d      %-30s    %4d     %15s     %30s\n", $1, $2, $3, $4, $5, $6}' temporary11.txt > temporary12.txt

mv temporary12.txt inform.txt


#--------------------------------------------------#
# para ordenar por energia
sed 's/\./,/g' inform.txt > temporary13.txt

sort -n -k 5 temporary13.txt > temporary14.txt

sed 's/\,/./g' temporary14.txt > inform_sorted.txt
#--------------------------------------------------#



rm auxiliar1.txt auxiliar2.txt
rm ord_temp1.txt ord_temp2.txt ord_temp3.txt
rm temporary.txt temporary1.txt temporary2.txt temporary10.txt temporary11.txt temporary13.txt temporary14.txt

#----------------------------------------------------------------------------------
# parte 4

## 18/09/2015
awk ' {print $1}' inform.txt | uniq > inform_temp.txt


cat inform_temp.txt | while read A1; do # inicio do while

  # coletar informacao para criar as pastas por cluster
  b=`basename $A1 .pdb`
  c=${b#cluster.pdb}


  # revome caso existam as pastas para cada cluster
  rm -r cluster_"$c"

  # cria pastas para cada cluster
  mkdir cluster_"$c"

  # copiar cluster do gromacs
  cp $A1 ./cluster_"$c"

  # copiar arquivos separados de cada cluster
##  cp ../$A3 ./cluster_"$c" 


  # cria arquivo com informacao do cluster na pasta do cluster
  cat inform.txt | grep "$A1" > ./cluster_"$c"/./cluster_"$c".txt

  # cria arquivo com informacao do cluster na pasta do cluster
  cat inform_sorted.txt | grep "$A1" > ./cluster_"$c"/./cluster_"$c"_sorted.txt

done # fim do while



cat inform.txt | while read A1 A2 A3 A4 A5 A6; do # inicio do while

  # coletar informacao para criar as pastas por cluster
  b=`basename $A1 .pdb`
  c=${b#cluster.pdb}

  # cria pastas para cada cluster
##  mkdir cluster_"$c"

  # copiar cluster do gromacs
##  cp $A1 ./cluster_"$c"

  # copiar arquivos separados de cada cluster
  cp ../primeiras_10/$A3 ./cluster_"$c" 


  # cria arquivo com informacao do cluster na pasta do cluster
#  cat inform.txt | grep "$A1" > ./cluster_"$c"/./cluster_"$c".txt

  # cria arquivo com informacao do cluster na pasta do cluster
#  cat inform_sorted.txt | grep "$A1" > ./cluster_"$c"/./cluster_"$c"_sorted.txt

done # fim do while

#----------------------------------------------------------------------------------

mv ../primeiras_10/cluster.pdb cluster.pdb

rm inform_temp.txt

# apaga os pdbs dos clusters que já estão copiados na pasta cluster no nos diretorios
# de cada cluster nesta pasta

rm cluster.pdb*
rm ../primeiras_10/cluster.pdb*
