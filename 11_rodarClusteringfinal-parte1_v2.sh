#!/bin/bash
#
# ultima alteracao
# 15/11/2017
#
# nome: 11_rodarClusteringfinal-parte1_v2.sh
#
#
# command line: sh 11_rodarClusteringfinal-parte1_v2.sh ou  ./11_rodarClusteringfinal-parte1_v2.sh
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
# Clusteriza as estruturas dos complexos gerados no docking no gromacs
# testado na versao: 4.5.1 - habilitar
# testano na versao: 5.1.1 e 5.1.3
#--------------------------------------------------------------------------------- 
# variaveis:
# cutoff : raio de corte utilizado na clusterizacao
# ref: caminho da estrutura de referencia
#
# input: 
# 1) arquivo all2.pdb gerado pelo script 10_preparaClusteringfinal_v1.sh
# 2) arquivo pdb de referencia definido na variavel ref. Primeira conformacao no
# ranking de energia ou outra definida segunda algum criteiro. Pode ser a estrutura
# do complexo antes do calculo dos modos. Por exemplo, conformacao de menor energia
# no ranking - energy_rank10.txt, arquivo no pasta
# $raiz/pos_docking/primeiras_10/m8_2.3_m54_-3.0_0001.pdb
#
# output:
# 1) clusterN1_"$cutoff".log : log do cluster considerando pdb referencia e
# o criterio de corte - por exemplo: clusterN1_0.3.log - cutoff: 0.3
#
# OBS: anotar numero de cluster gerados para inserir no proximo script na variavel ncluster
# 12_rodarClusteringfinal-parte2_v1.sh, por exemplo:
# gromacs output
# Finding clusters   47
# Found 47 clusters
##################################################################################

# definicao da variavel/diretorio raiz - automatico
# diretorio raiz de execucao dos scripts
raiz=$(pwd)

# definicao do raio de corte utilizado no clusterizacao
cutoff=0.3

# definicao da variavel ref: caminho da estrutura de referencia
ref="$raiz/pos_docking/primeiras_10/m54_-3.0_m8_-2.1_0001.pdb"



echo " "
echo "###########################################################################"
echo "Etapa 11: clusteriza as estruturas dos complexos gerados no docking - utiliza"
echo " o arquivo de trajetoria."
echo " "
echo " "
echo "definir a variavel cutoff - cutoff da clusterizacao"
echo " "
echo "definir a variavel ref - caminho da estrutura de referencia para clusterizacao"
echo " "
echo " "
echo " "
echo "anotar numero de cluster gerados para inserir no proximo script na varival ncluster"
echo " "
echo "###########################################################################"

# caminho
caminho="$raiz/pos_docking/"

echo "caminho : $caminho"
echo " "
echo "ref : $ref"
echo " "
echo "cutoff : $cutoff"
echo " "
echo "###########################################################################"
echo " "


cd "$caminho"

cd primeiras_10
#cd primeiras_10_2


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

