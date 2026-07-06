#!/bin/bash
#
# ultima alteracao
# 16/11/2017
#
# nome: 06_renomeia_cadeia_v5.sh
#
#
# command line: sh 06_renomeia_cadeia_v5.sh ou  ./06_renomeia_cadeia_v5.sh
##################################################################################
#  	Script desenvolvido por:
#       Eric Allison Philot
#       Fabio Filippi Matiolo
#
#  	e-mail: ericphilot@hotmail.com
#
# Descricao:
# Altera formato do arquivo pdb vindo do charmm para o formato de pdb original.
# Renomeia cadeia do ligante para nao conflitar com a(s) cadeia(s) do receptor.
# Caso ja estajam corretas as cadeias desabilitar o comando e corrigir o arquivo
# temporario de entrada no proximo comando.
# Corrige algumas nomenclaturas distintas entre os formatos de pdb
# 
# input: 
# 1) arquivos pdbs 
# nas pastas
# caminho="$raiz/pre_docking/ligante/crit1-mmfp/cluster"
# caminho1="$raiz/pre_docking/receptor/crit1-mmfp/cluster"
#
# output:
# 1) arquivos pdbs com novo formato
# nas pastas
# $raiz/docking/ligante/
# $raiz/docking/receptor
##################################################################################

# definicao da variavel/diretorio raiz - automatico
# diretorio raiz de execucao dos scripts
raiz=$(pwd)

echo " "
echo "###########################################################################"
echo "Etapa 06: altera o formato do arquivo pdb original do charmm para rodar o"
echo "docking no hex - altera algumas nomenclaturas"
echo " "
echo " "
echo " "
echo "O ligante e o receptor nao podem ter a mesma nomenclatura de cadeia."
echo "Caso ocorra tem que alterar o nome da cadeia -  este script faz para"
echo "uma cadeia - para mais cadeias tem que replicar o comando e alterar os"
echo "arquivos temporarios."

# caminhos das pastas do receptor e do ligante
caminho="$raiz/pre_docking/ligante/crit1-mmfp/cluster"
caminho1="$raiz/pre_docking/receptor/crit1-mmfp/cluster"

echo " "
echo "###########################################################################"
echo " "

# remove arquivos pdbs previos na pasta
rm $raiz/docking/receptor/*.pdb
rm $raiz/docking/ligante/*.pdb

# ligante
#----------------------------------------------------------
cd "$caminho"

# Loop for files
for f in *.pdb; do # inicio for 1
  b=`basename $f .pdb`
  lig=${b#$nome_ligante"_"}

  #echo " "
  #echo $f

  cat $f | grep ATOM > temp1.txt
  cat $f | grep HETATM >> temp1.txt


  # mudar cadeias - facilita saida hex
  # para mais cadeias tem que replicar o comando e fazer um arquivo temporario
  # para isso deixando o arquivo final com o nome de entrada igual ao arquivo
  # de proximo comoando - temp.txt ou usar o comando mv para este fim.
  # Caso as cadeias ja estajam corretas desabilite o comando e altere o temporario
  # de entrada no proximo comando.
  sed 's/\PROA/PROF/g' temp1.txt > temp.txt

  #sed 's/\PROB/PROG/g' temp1.txt > temp1.txt
  # mv temp1.txt temp.txt

  awk ' {printf "%-6s%5d  %-4s%3s %1s %3d    %8.3f%8.3f%8.3f%6.2f%6.3f  \n", $1, $2, $3, $4, substr($11,length($11),1), $5, $6, $7, $8, $9,$10}' temp.txt > temp2.txt

  # antigo awk ' {printf "%-6s %4d  %-4s%3s %1s %3d    %8.3f%8.3f%8.3f%6.2f%6.3f  \n", $1, $2, $3, $4, substr($11,length($11),1), $5, $6, $7, $8, $9,$10}' temp.txt > temp2.txt

  sed 's/\HSD/HIS/g' temp2.txt > temp3.txt


  echo "END" >> temp3.txt

  #rm $f temp.txt temp1.txt temp2.txt
  rm temp.txt temp1.txt temp2.txt

  mv temp3.txt "$raiz/docking/ligante/$f"

done # fim do for 1
#----------------------------------------------------------

cd ..



#----------------------------------------------------------
# receptor

cd "$caminho1"

# Loop for files
for f in *.pdb; do # inicio for 1
  b=`basename $f .pdb`
  lig=${b#$nome_ligante"_"}

  #echo " "
  #echo $f

  cat $f | grep ATOM > temp1.txt
  cat $f | grep HETATM >> temp1.txt

  awk ' {printf "%-6s%5d  %-4s%3s %1s %3d    %8.3f%8.3f%8.3f%6.2f%6.3f  \n", $1, $2, $3, $4, substr($11,length($11),1), $5, $6, $7, $8, $9,$10}' temp1.txt > temp2.txt

  # antigo awk ' {printf "%-6s %4d  %-4s%3s %1s %3d    %8.3f%8.3f%8.3f%6.2f%6.3f  \n", $1, $2, $3, $4, substr($11,length($11),1), $5, $6, $7, $8, $9,$10}' temp1.txt > temp2.txt

  sed 's/\HSD/HIS/g' temp2.txt > temp3.txt


  echo "END" >> temp3.txt

  #rm $f temp1.txt temp2.txt
  rm temp1.txt temp2.txt

  mv temp3.txt "$raiz/docking/receptor/$f"

done
#----------------------------------------------------------
