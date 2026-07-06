#!/bin/bash
#
# ultima alteracao
# 16/11/2017
#
# nome: 07_hex_v5.sh
#
#
# command line: sh 07_hex_v5.sh ou  ./07_hex_v5.sh
##################################################################################
#  	Script desenvolvido por:
#       Eric Allison Philot
#       Fabio Filippi Matiolo
#
#  	e-mail: ericphilot@hotmail.com
#
# Descricao:
# Cria os arquivos .mac para execucao no hex e executa o docking.
# HEX_VERSION = 8.0.0
#
# web page:
# http://hex.loria.fr/
#
# online manual:
# http://hex.loria.fr/manual800/hex_manual.html
#--------------------------------------------------------------------------------- 
# variaveis:
# gerais 
# nome_ligante informar apenas o nome da molecula do ligante (nome do arquivo ate o ponto)
# nome_receptor: nome da molecula do receptor(nome do arquivo ate o ponto) ex: cnfsub
#
# variaveis docking - relacionadas ao programa hex
# maiores informacoes no manual do programa - outras opcoes e protocolos podem ser utilizados
# online manual: http://hex.loria.fr/manual800/hex_manual.html
#
# distancia_mol: distancia entre as moleculas
# total: numero total de solucoes geradas
# melhores: quantidade desejada das melhores solucoes
# steric_scan: valor da opcao "steric scan"
# final_search: valor da opcao "final search"
#
# verificar outras definicoes no trecho "GERADOR ARQUIVO MAC" abaixo.
#
# input
# pastas:
# receptor: pdbs dos receptor obtidos pela custerizao das etapas anteriores
# no caminho: "$raiz/docking/receptor/"
# ligante: pdbs dos ligantes obtidos pela custerizao das etapas anteriores
# no caminho: "$raiz/docking/ligante/"
#
# output
# pastas:
# hex_log: arquivos log do docking com hex
# hex_mac: arquivos para execucao do docking no hex
# infos: arquivos
# primeiras_50: pdbs das 50 primeiras solucoes de docking para cada docking
# nome dos pdbs gerados:
# ex: m8_2.3_m54_-2_0001.pdb
# <modo do ligante>_<deslocamento>_<modo do receptor>_<deslocamento>_<numero da solucao>
##################################################################################



# definicao da variavel/diretorio raiz - automatico
# diretorio raiz de execucao dos scripts
raiz=$(pwd)


echo " "
echo "###########################################################################"
echo "Etapa 07: Docking proteina-proteina no Hex - versao 8.0.0"
echo " "
echo " "
echo " "
echo "Outras escolhas de parametros e outros protocolos para o hex podem ser utilizados."
echo "###########################################################################"

# caminho
caminho="$raiz/docking/"

echo "caminho : $caminho"
echo " "


# numero de conformacoes do ligante
num_lig=$(ls "$raiz/docking/ligante/"*.pdb | wc -l)
echo "numero de conformacoes do ligante : $num_lig"
echo " "

# numero de conformacoes do receptor
num_rec=$(ls "$raiz/docking/receptor/"*.pdb | wc -l)
echo "numero de conformacoes do receptor : $num_rec"
echo " "

# numero combinacao de docking
comb=$(($num_lig * $num_rec))
echo "numero de combinacoes de docking : $comb"

echo " "
echo "###########################################################################"
echo " "


cd "$caminho"

# remover pastas caso existam
rm -r hex_mac hex_log infos


# armazena arquivos
mkdir hex_mac hex_log


#----------VARIAVEIS----------# 
# informar apenas o nome da molecula do ligante (nome do arquivo ate o ponto)
nome_ligante=cnfsub

# informar apenas o nome da molecula do receptor(nome do arquivo ate o ponto)
nome_receptor=cnfsub

# informar cadeia, resíduos e/ou atomos da origem do receptor [sintaxe - A-X (Cadeia-residuo)
# ou A-X:-CA(Chain-ResidueID:ResidueName-AtomName)]
#origem_receptor=A-70                                                  

# informar cadeia, resíduos e/ou atomos da origem do ligante [sintaxe - A-X (Cadeia-residuo)
# ou A-X:-CA(Chain-ResidueID:ResidueName-AtomName)]
#origem_ligante=R38 K52 R89 H90                                        

# informar resíduo de interação do ligante [sintaxe - A-X = cadeia-resíduo]
#interface_ligante=                                                    

# informar resíduo de interação do ligante [sintaxe - A-X = cadeia-resíduo]
###----interface_receptor=C-34                                                



# distancia entre as moleculas
distancia_mol=10.0000

# número total de soluções geradas
total=500                                                              

# quantidade desejada das melhores opções
melhores=50 

# valor da opção "steric scan"
steric_scan=25

# valor da opção "final search"
final_search=30


#---------GERADOR ARQUIVO MAC----------#

rm -r primeiras_"$melhores" 

mkdir primeiras_"$melhores" 

#mkdir todas 

mkdir infos

echo " "

a=1

# Loop for files
for f in ./ligante/*.pdb; do # inicio do for 1
  b=`basename $f .pdb`
  lig=${b#$nome_ligante"_"}

  # Loop for files
  for j in ./receptor/*.pdb; do # inicio do for 2
    d=`basename $j .pdb`
    rec=${d#$nome_receptor"_"}

    #ligante=$nome_ligante.pdb                       
    ligante=$f 

    #receptor=$nome_receptor.pdb                    
    receptor=$j

    # se houver arquivos aberto fecha todos
    echo close_all > "$lig"_"$rec"_doc.mac   

    # abre o receptor
    echo open_receptor   $receptor >> "$lig"_"$rec"_doc.mac
        
    # abre o ligante
    echo open_ligand     $ligante>> "$lig"_"$rec"_doc.mac
 
    # ajusta o receptor ao ligante (duvida)
    #echo fit_ligand>> "$lig"_"$rec"_doc.mac

    # ajusta o numero de solucoes
    echo max_docking_solutions $total >> "$lig"_"$rec"_doc.mac

    # muda a origem do recptor
    #echo receptor_origin $origem_receptor >> "$lig"_"$rec"_doc.mac   

    # muda a origem do ligante
    #echo ligand_origin $origem_ligante  >> "$lig"_"$rec"_doc.mac

    # muda a interface do ligante
    #echo ligand_interface $interface_ligante >> "$lig"_"$rec"_doc.mac

    # muda a interface do receptor
    ###----echo receptor_interface $interface_receptor  >> "$lig"_"$rec"_doc.mac




    # tipo de correlação - 3=shape_electro                                                            
    echo docking_refine 3 >> "$lig"_"$rec"_doc.mac

    # opção 2 = CPU+GPU
    echo docking_fft_device 2 >> "$lig"_"$rec"_doc.mac

    echo docking_main_scan $steric_scan  >> "$lig"_"$rec"_doc.mac

    echo docking_main_search $final_search  >> "$lig"_"$rec"_doc.mac

    # distancia entre as moleculas
    echo molecule_separation $distancia_mol  >> "$lig"_"$rec"_doc.mac

    # executa o docking
    echo activate_docking  >> "$lig"_"$rec"_doc.mac

    # salva as melhores soluções
    echo save_range 1 $melhores `pwd`/primeiras_"$melhores" "$lig"_"$rec"_ pdb  >> "$lig"_"$rec"_doc.mac

    # salva todas as soluções
    #echo save_range 1 $total `pwd`/todas "$lig"_"$rec"_ pdb   >> "$lig"_"$rec"_doc.mac

    # salva matriz.hex
    echo save_matrix `pwd`/infos/"$lig"_"$rec"_matrix.hex   >> "$lig"_"$rec"_doc.mac 
 
    # salva transformation.hex
    echo save_transform `pwd`/infos/"$lig"_"$rec"_transformation.hex   >> "$lig"_"$rec"_doc.mac
	

#---------- EXECUTAR O HEX COM O MAC CRIADO--------------------------#

    echo "  "
    echo $a $lig $rec

    # incremeta contador
    a=$(expr $a + 1)

    # executa o hex utilizando o arquivo .mac
    hex <"$lig"_"$rec"_doc.mac >"$lig"_"$rec".log

    # move os arquivos para as pastas
    mv "$lig"_"$rec".log ./hex_log
    mv "$lig"_"$rec"_doc.mac ./hex_mac

  done # final do for 2
done # final do for 1

echo " "

#--------------------------------------------------------------------#
