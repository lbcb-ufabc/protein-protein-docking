#!/bin/bash
#
# ultima alteracao
# 16/11/2017
#
# nome: 03_rodarClustering_v1.sh
#
#
# command line: sh 03_rodarClustering_v1.sh ou  ./03_rodarClustering_v1.sh
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
# Clusteriza as estruturas selecionadas pelo criterio mmfp no gromacs
# testado na versao: 4.5.1 - habilitar
# testado na versao: 5.1.1 e 5.1.3
#--------------------------------------------------------------------------------- 
# variaveis:
# cutoff : raio de corte utilizado na clusterizacao
# ref: caminho da estrutura de referencia
#
# input: 
# 1) arquivo all2.pdb gerado pelo script 02_preparaClustering_v3.sh
# 2) arquivo pdb de referencia definido na variavel ref
#
# output:
# 1) clusterN1_"$cutoff".log : log do cluster considerando pdb referencia e
# o criterio de corte - por exemplo: clusterN1_0.3.log - cutoff: 0.3
##################################################################################

# definicao do raio de corte utilizado no clusterizacao
cutoff=0.3

# definicao da variavel ref: caminho da estrutura de referencia
ref="../cnf.pdb"

# definicao da variavel/diretorio raiz - automatico
# diretorio raiz de execucao dos scripts
raiz=$(pwd)

echo " "
echo "###########################################################################"
echo "Etapa 03: clusteriza as estruturas selecionadas - utiliza o arquivo de trajetoria "
echo " "
echo " "
echo "definir a variavel cutoff - cutoff da clusterizacao"
echo " "
echo "definir a variavel ref - caminho da estrutura de referencia para clusterizacao"
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
echo "ref : $ref"
echo " "
echo "cutoff : $cutoff"
echo " "
echo "###########################################################################"
echo " "



cd "$caminho"



# gromacs versao 4.5.1
# comandos abaixo funcionam - comentado somente por causa da versao do gromacs

# usa como referencia a estrutura de entrada
#echo 1 | g_cluster-4.5.1 -f all2.pdb -s "$ref" -method gromos -cutoff "$cutoff" -dist rmsd-dist-av
#mv cluster.log clusterN1_"$cutoff".log


# gromacs versao 5.1.1 / 5.1.3
# usa como referencia a estrutura de entrada

echo 1 | gmx cluster -f all2.pdb -s "$ref" -method gromos -cutoff "$cutoff" -dist rmsd-dist-av
mv cluster.log clusterN1_"$cutoff".log

# remove arquivos de output de clusterizacao nao utilizados
rm rmsd-dist-av.xvg rmsd-clust.xpm
