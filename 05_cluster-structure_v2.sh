#!/bin/bash
#
# ultima alteracao
# 16/11/2017
#
# nome: 05_cluster-structure_v2.sh
#
#
# command line: sh 05_cluster-structure_v2.sh ou  05_cluster-structure_v2.sh
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
# Copia a estrutura representativa de cada cluster para a pasta cluster
# "$raiz/pre_docking/ligante/crit1-mmfp/cluster"
# "$raiz/pre_docking/receptor/crit1-mmfp/cluster"
#--------------------------------------------------------------------------------- 
# input: 
# 1) temp4a.txt : lista com as estruturas representativas de cada cluster
#
# output:
# 1) pasta cluter com as estruturas representativas de cada cluster
# 2) temporary.txt : lista dos pdbs copiados com os frames de referencia
# 3) temporary2.txt : lista dos pdbs copiados
##################################################################################


# definicao da variavel/diretorio raiz - automatico
# diretorio raiz de execucao dos scripts
raiz=$(pwd)

echo " "
echo "###########################################################################"
echo "Etapa 05: Copia a estrutura representativa de cada cluster para a pastar .../crit1-mmfp/cluster "
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
echo "###########################################################################"
echo " "



cd "$caminho"


# remove pasta cluster se houver
rm -r cluster

# cria diretorio para armazenar as estruturas
mkdir cluster

rm temporary.txt temporary2.txt

cat temp4a.txt| while read linha; do # inicio do while

  cat nomes-frames.txt | awk '{if (($2 == "'$linha'"))  print}'  >> temporary.txt

  name=$(cat nomes-frames.txt | awk '{if (($2 == "'$linha'"))  print $1}')

  #echo $name

  cp $name ./cluster

  echo $name >> temporary2.txt

done # fim do while

