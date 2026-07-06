#!/bin/bash
#
# ultima alteracao
# 16/11/2017
#
# nome: 04_seleciona_estrutura-cluster_v3.sh
#
#
# command line: sh 04_seleciona_estrutura-cluster_v3.sh ou  .04_seleciona_estrutura-cluster_v3.sh
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
# Seleciona as estruturas representativas de cada cluster encontrada no passo anterior
# (03_rodarClustering_v1.sh) de clusterizacao no gromacs.
#
# Testado nos outputs do gromacs
# testado na versao: 4.5.1
# testano na versao: 5.1.1 e 5.1.3
#--------------------------------------------------------------------------------- 
# variaveis:
# arquivo: nome do arquivo gerado na etapa anterior (03_rodarClustering_v1.sh),
#  por exemplo clusterN1_"$cutoff".log
#
# input: 
# 1) arquivo clusterN1_"$cutoff".log, por exemplo: clusterN1_0.3.log, clusterN1_0.5.log, etc
#
# output:
# 1) temp4a.txt : lista com as estruturas representativas de cada cluster
##################################################################################

# definicao da variavel ref: caminho da estrutura de referencia
arquivo="clusterN1_0.3.log"

# definicao da variavel/diretorio raiz - automatico
# diretorio raiz de execucao dos scripts
raiz=$(pwd)

echo " "
echo "###########################################################################"
echo "Etapa 04: seleciona a estrutura representativa de cada cluster "
echo " "
echo " "
echo "definir a variavel arquivo - arquivo gerado na etapa anterior - ex: clusterN1_0.3.log"
echo " "
echo " "
echo " "
echo "variavel caminho entre ligante e receptor "
echo " "
echo "1  -  ligante"
echo "2  -  receptor"
echo " "
read -p 'ligante ou receptor : ' var 

echo " "
echo " "
echo "###########################################################################"
echo " "
# ligante
if [ $var = "1" ]; then
  caminho="$raiz/pre_docking/ligante/crit1-mmfp"
fi

# receptor
if [ $var = "2" ]; then
  caminho="$raiz/pre_docking/receptor/crit1-mmfp"
fi
echo " "

echo "caminho : $caminho"
echo " "
echo "arquivo : $arquivo"
echo " "
echo " "
echo " "
echo "OBS: pode aparecer um erro no final da execucao do script mas nao causa problema"
echo " "
echo "###########################################################################"
echo " "


cd "$caminho"


#verificar se o numero sorteado já foi selecionado
verif=0
verif1=0
verif2=0
verif3=0


tail --lines=+12 "$arquivo" > temp1.txt    
grep -v "|             |" temp1.txt > temp2.txt
grep -v "|   1       |" temp2.txt > tempi.txt
grep "|   1       |" temp1.txt > temp3.txt
awk '{print $6}' tempi.txt > temp4.txt
awk '{print $5}' temp3.txt >> temp4.txt

cp temp4.txt temp4a.txt


members="$(cat temp4.txt | wc -l)"
#while ($members < 200);  do

#coloca o numero da linha
grep -n '^' temp1.txt > temp5.txt

#coloca um espaço entre o numero da linha e :
sed 's/:/ :/g' temp5.txt > temp6.txt

#pega somente as linhas que tem o numero do cluster
grep -v "|             |" temp6.txt > temp7.txt


# final number of selected structures
let h=100-$members
o=1
i=1
let h1=$h+1

#for i in $(seq $o $h) ; do

while [ $i != $h1 ]
do # inicio while 1

  #echo i $i
  #numero da linha
  min=$(cat temp7.txt | awk 'FNR == '"$i"' {print $1}')
  #echo "min: $min"

  #numero da proxima linha
  let j=$i+1
  max=$(cat temp7.txt | awk 'FNR == '"$j"' {print $1}')
  #echo $max


  let max1=$max-2

  #geracao do primeiro numero aleatorio (linha)
  ran1=$RANDOM
  ran1=$[ $min + $ran1 % ($max1 + 1 - $min) ]
  #echo $ran1

  #geracao do segundo numero aleatorio (coluna)
  ran2=$RANDOM
  ran2=$[ 6 + $ran2 % (12 + 1 - 6) ]
  #echo $ran2

  #verificacao caso o numero aleatorio for igual a linha que tem o numero do cluster
  if [ "$ran1" == "$min" ] ; then
    let ran3=$ran2+5
    cluster=$(cat temp6.txt | awk 'FNR == '"$ran1"' {print $'"$ran3"'}')
  else
    cluster=$(cat temp6.txt | awk 'FNR == '"$ran1"' {print $'"$ran2"'}')
  fi
  #echo $cluster


  #verificar se o numero sorteado já foi selecionado
  verif=0
  #echo verif1=$verif

  #cat temp4.txt | while read ncluster; do
  while read -r ncluster; do # inicio while 2
    if [ "$ncluster" == "$cluster" ] ; then
      #echo cluster=$cluster ncluster=$ncluster 
      verif=$ncluster
      #echo verif2=$verif
      #echo teste1 $verif
    fi
    #echo teste2 $verif
  done < <(cat temp4.txt) # fim while 2

  #echo teste3 $verif

  #echo verif3=$verif
  if [ "$verif" == 0 ] ; then
    echo $cluster >> temp4.txt
    let i=$i+1
  fi


done # fim while 1

cp temp4.txt cluster_elements.txt

# remove arquivos de output nao utilizados
rm temp7.txt temp4.txt cluster_elements.txt tempi.txt
rm temp6.txt temp5.txt temp3.txt temp2.txt temp1.txt

