#!/bin/bash
#
# ultima alteracao
# 16/11/2017
#
# nome: 02_preparaClustering_v3.sh
#
#
# command line: sh 02_preparaClustering_v3.sh ou  ./02_preparaClustering_v3.sh
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
# Transforma estruturas geradas no charmm que foram selecionadas etapa anterior
# (01_seleciona-mmfp_v4.sh) em trajetoria para ser clusterizada no gromacs.
# 
#--------------------------------------------------------------------------------- 
# variaveis:
#
# input: estruturas selecionadas localizadas nas pastas
# caminho="$raiz/pre_docking/ligante/crit1-mmfp"
# caminho="$raiz/pre_docking/receptor/crit1-mmfp"
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

#---------------------------------------------------------------------------------------#
# definicao da variavel destino

echo " "
echo "###########################################################################"
echo "Etapa 02: converte estruturas selecionadas em trajetoria para clusterizacao "
echo " "
echo " "
echo "variavel caminho entre ligante e receptor "
echo " "
echo "1  -  ligante"
echo "2  -  receptor"
echo " "
read -p 'ligante ou receptor : ' var 

echo " "

# ligante
if [ $var = "1" ]; then
  caminho="$raiz/pre_docking/ligante/crit1-mmfp"
fi

# receptor
if [ $var = "2" ]; then
  caminho="$raiz/pre_docking/receptor/crit1-mmfp"
fi

echo "caminho : $caminho"

echo " "
echo "###########################################################################"
echo " "


# entra na pasta
cd "$caminho"

# frame (begin number: -1 )
frame=-1

# remove os arquivos
rm nomes-frames.txt all2.pdb all.pdb all1.pdb nomes-frames1.txt

# Loop for files
for f in *.pdb; do # begin for 1


  printf "%-23s   %5d\n" $f $frame >> nomes-frames.txt
  printf "%-23s   #%5d#\n" $f $frame >> nomes-frames1.txt

  cat $f >> all.pdb

  # incrementa a valor do frame
  frame=$(expr $frame + 1)

done # end for 1

# copia tudo que tem ATOM ou END
cat all.pdb | egrep '(ATOM|END)' > all1.pdb
# substitui END por ENDMDL 
sed 's/END/ENDMDL/g' all1.pdb > all2.pdb

# remove os arquivos
rm all1.pdb all.pdb

