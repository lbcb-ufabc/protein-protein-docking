#!/bin/bash
#
# ultima alteracao
# 16/11/2017
#
# nome: 09_1_copiar_pdbs_rank_v2.sh
#
#
# command line: sh 09_1_copiar_pdbs_rank_v2.sh ou  09_1_copiar_pdbs_rank_v2.sh
##################################################################################
#  	Script desenvolvido por:
#       Eric Allison Philot
#       Fabio Filippi Matiolo
#
#  	e-mail: ericphilot@hotmail.com
#
# Descricao:
# copia um numero de conformacoes igual ao numero de combinacoes de docking vezes 10, ou seja,
# numero de conformacoes do receptor x numero de conformacoes do ligante x 10, considerando o
# ranking das solucoes. Copia os pdbs dos complexos na pasta $raiz/pos_docking/primeiras_10
# 
# input:
# energy_sorted.txt gerado pelo 08_ordena-energia_v3.sh
# 
# Output:
# 1) arquivo energy_rank10.txt
# 2) pasta primeiras_10 com os pdbs selecionados por ranking geral de energia
##################################################################################

# definicao da variavel/diretorio raiz - automatico
# diretorio raiz de execucao dos scripts
raiz=$(pwd)


echo " "
echo "###########################################################################"
echo "Etapa 09: copia um numero de conformacoes igual numero de conformacoes do receptor"
echo "vezes numero de conformacoes do ligante vezes 10, considerando o  ranking das solucoes."
echo " "
echo " "
echo " "
echo "###########################################################################"
# caminho
caminho="$raiz/docking/"

echo "caminho : $caminho"
echo " "
echo " "

# numero de conformacoes do ligante
num_lig=$(ls "$raiz/docking/ligante/"*.pdb | wc -l)
echo "numero de conformacoes do ligante : $num_lig"
echo " "

# numero de conformacoes do receptor
num_rec=$(ls "$raiz/docking/receptor/"*.pdb | wc -l)
echo "numero de conformacoes do receptor : $num_rec"
echo " "

# numero combinacao de docking x 10
comb=$(($num_lig * $num_rec * 10))
echo "numero de combinacoes de docking x 10 : $comb"


echo " "
echo "###########################################################################"
echo " "


cd "$caminho"

# alterar conforme descrito acina
head -n "$comb" ./energy_sorted.txt > energy_rank10.txt

cp energy_rank10.txt "$raiz/pos_docking/energy_rank10.txt"
          
rm -r "$raiz/pos_docking/primeiras_10"           
mkdir "$raiz/pos_docking/primeiras_10"

#----------------------------------------------------------------------------------
# parte 4

cat energy_rank10.txt | while read A1 A2; do # inicio do while

  # coletar informacao para criar as pastas por cluster
  #b=`basename $A1 .pdb`
  #c=${b#cluster.pdb}

  # cria pastas para cada cluster
  #mkdir cluster_"$c"

  # copiar pdbs ranqueados para pasta
  cp ./primeiras_50/$A2 "$raiz/pos_docking/primeiras_10"

done # fim do while

#----------------------------------------------------------------------------------
