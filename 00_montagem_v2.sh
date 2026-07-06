#!/bin/bash
#
# ultima alteracao
# 16/11/2017
#
# nome: 00_montagem_v2.sh
#
#
# command line: sh 00_montagem_v2.sh ou  ./00_montagem_v2.sh
##################################################################################
#  	Script desenvolvido por Eric Allison Philot.
#  	e-mail: ericphilot@hotmail.com
#
# Descricao:
# Cria a estruturas de pastas para rodar o docking proteina-proteina
# protocolo pp_docking_protocol.
#
# Protocolo desenvolvido por:
# Eric Allison Philot
# Fabio Filippi Matiolo
#
##################################################################################


echo " "
echo "###########################################################################"
echo "Etapa 00: cria a estrutura de pastas para a execucao do protocolo"
echo " "
echo " "
echo "###########################################################################"


# definicao da variavel/diretorio raiz - automatico
# diretorio raiz de execucao dos scripts
raiz=$(pwd)

# cria pasta pre-docking e subpastas ligante e receptor
mkdir "$raiz/pre_docking"
mkdir "$raiz/pre_docking/ligante"
mkdir "$raiz/pre_docking/receptor"

# cria pasta docking e subpastas ligante e receptor
mkdir "$raiz/docking"
mkdir "$raiz/docking/ligante"
mkdir "$raiz/docking/receptor"

# cria pasta pos-docking
mkdir "$raiz/pos_docking"


