#!/bin/bash
#
# ultima alteracao
# 16/11/2017
#
# nome: 10_preparaClusteringfinal_v2.sh
#
#
# command line: sh 10_preparaClusteringfinal_v2.sh ou  ./10_preparaClusteringfinal_v2.sh
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
# Transforma estruturas dos complexos geradas pelo hex (ex: m8_2.3_m54_-2_0001.pdb)
# em trajetoria para ser clusterizada no gromacs.
#--------------------------------------------------------------------------------- 
# variaveis:
#
# input: estruturas selecionadas localizadas na pasta
# $raiz/pos_docking/primeiras_10
#
# output:
# 1) arquivo all2.pdb: estruturas selecionadas - em forma de trajetoria
# 2) nomes-frames.txt - correlaciona o frame com o arquivo pdb de qual ele foi gerado
# 3) nomes-frames1.txt  - correlaciona o frame com o arquivo pdb de qual ele foi gerado
#
##################################################################################

# definicao da variavel/diretorio raiz - automatico
# diretorio raiz de execucao dos scripts
raiz=$(pwd)

echo " "
echo "###########################################################################"
echo "Etapa 10: converte as estruturas dos complexos gerados no docking em trajetoria"
echo "para clusterizacao. "
echo " "
echo " "
echo "###########################################################################"

# caminho
caminho="$raiz/pos_docking/"

echo "caminho : $caminho"
echo " "
echo "###########################################################################"
echo " "

cd "$caminho"


cd primeiras_10
#cd primeiras_10_2

# frame (begin number: -1 )
frame=-1

rm nomes-frames.txt all2.pdb all.pdb all1.pdb nomes-frames1.txt

# Loop for files
for f in *.pdb; do # begin for 1


  printf "%-30s   %5d\n" $f $frame >> nomes-frames.txt
  printf "%-30s   #%5d#\n" $f $frame >> nomes-frames1.txt

  cat $f >> all.pdb
  echo END >> all.pdb


  frame=$(expr $frame + 1)

done # end for 1

cat all.pdb | egrep '(ATOM|END)' > all1.pdb
sed 's/END/ENDMDL/g' all1.pdb > all2.pdb


rm all1.pdb all.pdb
