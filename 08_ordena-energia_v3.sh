#!/bin/bash
#
# ultima alteracao
# 16/11/2017
#
# nome: 08_ordena-energia_v3.sh
#
#
# command line: sh 08_ordena-energia_v3.sh ou  ./08_ordena-energia_v3.sh
##################################################################################
#  	Script desenvolvido por:
#       Eric Allison Philot
#       Fabio Filippi Matiolo
#
#  	e-mail: ericphilot@hotmail.com
#
# Descricao:
# Cria um arquivo com as energias e os nomes dos complexos (solucoes do docking) ordenados
# por energia.
# Estruturas dos complexos contidas nas pasta
# $raiz/docking/primeiras_50
#--------------------------------------------------------------------------------- 
# variaveis
#
# input
# Estruturas do complexo obtidas pelo docking localizadas na pasta
# $raiz/docking/primeiras_50
#
# output
# 1) "$raiz/docking/energy_sorted.txt"
# 2) "$raiz/pos_docking/energy_sorted.txt"
# Esse arquivo contem a energia do complexo e o nome do complexo.
# 1ª coluna: energia do complexo
# 2ª coluna: nome do complexo
##################################################################################


# definicao da variavel/diretorio raiz - automatico
# diretorio raiz de execucao dos scripts
raiz=$(pwd)

echo " "
echo "###########################################################################"
echo "Etapa 08: Cria um arquivo com as energias e os nomes dos complexos ordenados"
echo "por energia."
echo " "
echo " "
echo " "
echo "###########################################################################"

# caminho
# habilitar opcao ligante ou receptor uma por vez
caminho="$raiz/docking/"

echo "caminho : $caminho"
echo " "
echo "###########################################################################"
echo " "

cd "$caminho"




rm energy_sorted.txt

cd ./primeiras_50

# remove arquivos temporarios
rm ord_temp1.txt ord_temp2.txt ord_temp3.txt ord_temp4.txt ord_temp5.txt ord_temp6.txt energy_sorted.txt

# Loop for files
for f in *.pdb; do # begin for 1

  # coleta valor de energia do pdb do complexo
  cat $f | grep "Energy" | uniq | awk '{print $3}' >> ord_temp1.txt

  # coleta nome do arquivo do complexo
  echo $f >> ord_temp2.txt

done # end for 1


# retira virgula colocada ao final do valor de energia
sed 's/\,//' ord_temp1.txt > ord_temp3.txt


# junta energia com nomes
paste ord_temp3.txt ord_temp2.txt > ord_temp4.txt



#--------------------------------------------------#
# para ordenar por energia
sed 's/\./,/g' ord_temp4.txt > ord_temp5.txt

sort -n -k 1 ord_temp5.txt > ord_temp6.txt

sed 's/\,/./g' ord_temp6.txt > ../energy_sorted.txt
cp ../energy_sorted.txt "$raiz/pos_docking/energy_sorted.txt"
#--------------------------------------------------#


# remove arquivos temporarios
rm ord_temp1.txt ord_temp2.txt ord_temp3.txt ord_temp4.txt ord_temp5.txt ord_temp6.txt
