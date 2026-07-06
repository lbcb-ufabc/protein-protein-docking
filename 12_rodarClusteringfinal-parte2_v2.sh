#!/bin/bash
#
# ultima alteracao
# 16/11/2017
#
# nome: 12_rodarClusteringfinal-parte2_v2.sh
#
#
# command line: sh 12_rodarClusteringfinal-parte2_v2.sh ou  ./12_rodarClusteringfinal-parte2_v2.sh
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
# 
# Gera os pdbs das estruturas de cada cluster e pdb com a estrutural central de cada
# cluster.
#--------------------------------------------------------------------------------- 
# variaveis:
# cutoff : raio de corte utilizado na clusterizacao
# ref: caminho da estrutura de referencia
# ncluster: numero de cluster gerados no script anterior
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
# 2) cluster.pdb: estrutura central de cada cluster
# Writing middle structure for each cluster to cluster.pdb
# 3) cluster.pdb%02d.pdb: todas as estruturas de cada cluster
# por exemplo: cluster.pdb01.pdb ... /cluster.pdb47.pdb
# Writing all structures for all clusters to cluster.pdb%02d.pdb
##################################################################################


# definicao da variavel/diretorio raiz - automatico
# diretorio raiz de execucao dos scripts
raiz=$(pwd)


# definicao do raio de corte utilizado no clusterizacao
cutoff=0.3

# definicao da variavel ref: caminho da estrutura de referencia
ref="$raiz/pos_docking/primeiras_10/m54_-3.0_m8_-2.1_0001.pdb"

# definicao da variavel ncluster: numero de cluster gerados no script anterior
# 11_rodarClusteringfinal-parte1_v1.sh
ncluster=51


echo " "
echo "###########################################################################"
echo "Etapa 12: clusteriza as estruturas dos complexos gerados no docking e gera os"
echo "arquivos pdbs de cada cluster e o arquivo com a estrutura central de cada"
echo "cluster - utiliza o arquivo de trajetoria."
echo " "
echo " "
echo "definir a variavel cutoff - cutoff da clusterizacao"
echo " "
echo "definir a variavel ref - caminho da estrutura de referencia para clusterizacao"
echo " "
echo "defenir a varival ncluster com o numero de clusters encontrados na etapa anterior"
echo " "
echo "###########################################################################"
echo " "

# caminho
caminho="$raiz/pos_docking/"

echo "caminho : $caminho"
echo " "
echo "ref : $ref"
echo " "
echo "cutoff : $cutoff"
echo " "
echo "ncluster : $ncluster"
echo " "
echo "###########################################################################"
echo " "

cd "$caminho"

cd primeiras_10

# gromacs versao 4.5.1
# comandos abaixo funcionam - comentado somente por causa da versao do gromacs

# usa como referencia a estrutura de entrada
#echo 1 | g_cluster-4.5.1 -f all2.pdb -s "$ref" -method gromos -cutoff "$cutoff" -dist rmsd-dist-av -cl cluster.pdb -nst 0 -wcl "$ncluster"
#mv cluster.log clusterN1_"$cutoff"sr.log


# gromacs versao 5.1.1 / 5.1.3
# usa como referencia a estrutura de entrada

echo 1 1 | gmx cluster -f all2.pdb -s "$ref" -method gromos -cutoff "$cutoff" -dist rmsd-dist-av -cl cluster.pdb -nst 0 -wcl "$ncluster"
mv cluster.log clusterN1_"$cutoff"sr.log

# remove arquivos de output de clusterizacao nao utilizados
rm rmsd-dist-av.xvg rmsd-clust.xpm

# remove arquivos de backup do gromacs caso ja tenha rodado o comando anteriormente
rm \#*
