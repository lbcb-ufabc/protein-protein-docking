#!/bin/bash
#
# ultima alteracao
# 16/11/2017
#
# nome: 01_seleciona-mmfp_v4.sh
#
#
# command line: sh 01_seleciona-mmfp_v4.sh ou  ./01_seleciona-mmfp_v4.sh
##################################################################################
#  	Script desenvolvido por:
#       Eric Allison Philot
#       Fabio Filippi Matiolo
#
#  	e-mail: ericphilot@hotmail.com
#
# Descricao:
# Seleciona estruturas geradas no charmm com o script do vmod - utilizando
# como criterio de selecao a energia mmfp.
# O valor do corte do mmfp eh definido na variavel mmfpcut.
# O script entra nas pastas disp-along-mode"$i" e copia as estruturas que
# satisfazem o criterio de selecao para a pasta definida na variavel folder.
#
#--------------------------------------------------------------------------------- 
# variaveis:
# origem: local com as pastas geradas pelo vmod charmm
#
# mmfpcut: mmfp cut-off - criterio de selecao
# name: nome utilizado nas estruturas que passaram pelo criterio de selecao
# folder: pasta para guardar as estruturas selecionadas e arquivo mmfp.txt
# 
# begin_mode: modo inicial a ser considerado - rang of modes
# end_mode: modo final a ser considerado - rang of modes
# 
#
# input: 
# estruturas geradas no charmm com o script do vmod dentro das
# pastas disp-along-mode"$i" dentro da pasta definida na variavel
# origem.
# pastas com nome do tipo: disp-along-mode7, disp-along-mode15, disp-along-mode67.
# estruturas com nomes do tipo: mini_-2.9.pdb, mini_-1.pdb, mini_2.7.pdb, etc.
#
# output:
# 1) pasta com as estruturas selecionadas segundo o criterio de selecao - mmfp cut-off.
# nome da pasta: definido na variavel folder
# nome das estruturas: <name>_modo_descolcamento.pdb
# por exemplo: cnfsub_m65_0.6.pdb
#
# 2) arquivo mmfp.txt
#
# arquivo: mmfp.txt
# primeira coluna: modo
# segunda coluna: deslocamento
# terceira coluna: energia mmfp2
#
##################################################################################

# definicao da variavel/diretorio raiz - automatico
# diretorio raiz de execucao dos scripts
raiz=$(pwd)


#---------------------------------------------------------------------------------------#


echo " "
echo "###########################################################################"
echo "Etapa 01: seleciona estruturas pelo criterio mmfp "
echo " "
echo " "
echo "alterar variavel origem"
echo " "
echo " "
echo "variavel destino entre ligante e receptor "
echo " "
echo "1  -  ligante"
echo "2  -  receptor"
echo " "
read -p 'ligante ou receptor : ' var 

echo " "

# ligante
if [ $var = "1" ]; then
  destino="$raiz/pre_docking/ligante"
fi

# receptor
if [ $var = "2" ]; then
  destino="$raiz/pre_docking/receptor"
fi


echo " "
echo "###########################################################################"
echo " "
#---------------------------------------------------------------------------------------#

# definicao da variavel origem
# local com as pastas geradas pelo vmod charmm
origem="/media/lbcb/eb8e6708-bbdd-46b1-ae92-d7c43b3ff791/user/eric/hd2/fabio/protocolo_v2/cnf_sub_teste02/modos"
echo "origem : $origem"

echo "destino : $destino"
echo " "


# mmfp cut-off - criterio de selecao
mmfpcut=0.8


echo "mmfp cut-off  : $mmfpcut"
echo " "
echo "###########################################################################"
echo " "

#name - nome utilizado nas estruturas que passaram pelo criterio de selecao
name=cnfsub

#folder - pasta para guardar as estruturas selecionadas e arquivo mmfp.txt
folder=crit1-mmfp

# remover pasta caso exista existente
rm -r "$destino/$folder"

# create folder to put selected pdbs
mkdir "$destino/$folder"


# rang of modes - para modos sequenciais
begin_mode=7
end_mode=67


# remove temporary files
rm teste.txt teste1.txt teste2.txt teste3.txt


cd "$origem"

# Loop for all modes
for i in $(seq $begin_mode $end_mode) ; do # inicio for 1

# Loop for specific modes
# para modos especificos nao sequenciais utilizar o comando for abaixo
# for i in 6 7 8 10 18 20 50 51 52 53 54 55 112 114 115 116 149 150 151 152 153 154; do # for 1


  # entra na pasta com as estruturas
  cd disp-along-mode"$i"

  # Loop for files
    for f in *.out; do # inicio for 2

      # extrai informcao sobre o deslocamento
      b=`basename $f .out`
      c=${b#disp_}

      # extrai informcao sobre a energia mmfp
      mmfp=$(cat "$f" | grep "ENER MMFP2>" | awk '{print $3}')

      # compara se a energia mmfp da estrutura satisfaz o criterio de corte
      if [ $mmfp '<' $mmfpcut ]; then # inicio do if

         # escreve informcao sobre o modo, deslocamento e energia mmfp
         echo $i  $c  $mmfp >> "$destino/$folder"/teste.txt 

         # copia o arquivo selecionado - renomeando-o
         cp mini_"$c".pdb "$destino/$folder"/"$name"_m"$i"_"$c".pdb

      fi # fim do if
    

    done # fim do for 2

  cd ..

done # fim do for 1

# entra na pasta que salvou as estruturas
cd "$destino/$folder"

# ordena arquivo pela enegia mmfp
sed 's/\./,/g' teste.txt > teste1.txt
sort -n -k 3 teste1.txt > teste2.txt
sed 's/\,/./g' teste2.txt > teste3.txt

# formatacao de saida do arquivo
awk '{printf "%-3s %4s %10s \n", $1, $2, $3}' teste3.txt > mmfp.txt

# remove temporary files
rm teste.txt teste1.txt teste2.txt teste3.txt

