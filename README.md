# Pipeline de Docking Proteína–Proteína

## 📌 Descrição

Este pipeline consiste em um conjunto de scripts desenvolvidos para realizar **docking proteína–proteína**, iniciando a partir de estruturas geradas no CHARMM (via VMOD) até a obtenção de soluções de docking clusterizadas e ordenadas por energia.

Ele integra etapas de pré-processamento, seleção de estruturas, clusterização, docking (HEX) e análise pós-processamento.

---

## 🎯 Quando usar

Utilize este pipeline quando:

* Você possui **estruturas de proteínas geradas via modos normais (VMOD/CHARMM)**
* Deseja:

  * Filtrar conformações com base na energia (MMFP)
  * Clusterizar conformações
  * Realizar docking com HEX
  * Ordenar e clusterizar soluções de docking

---

## 📂 O que este pipeline gera

* Conformações filtradas com base na energia MMFP
* Estruturas de ligante e receptor clusterizadas
* Soluções de docking (HEX)
* Complexos ordenados por energia
* Resultados finais clusterizados
* Estruturas representativas organizadas por cluster

---

## ⚙️ Requisitos

[Requirements](https://github.com/Labbiofisbiocomp/protein-protein-docking/blob/main/requirements.md)

---

## 🔄 Visão geral do pipeline

```text
CHARMM / VMOD geração de estruturação
        ↓
MMFP filtro (seleção de estrutura)
        ↓
Clusterização do ligante e receptor (separadamente)
        ↓
Seleção de estruturas representativas
        ↓
Preparação de estrutura (renomeação de cadeia / formatação)
        ↓
Docking (HEX)
        ↓
Classificação energética de soluções de docking
        ↓
Seleção dos complexos com melhor classificação
        ↓
CLusterização final das soluções de docking
        ↓
Organização e análise de cluster
```

---

## ▶️ Como executar (passo a passo)

Execute os scripts na seguinte ordem:

```bash
sh 00_montagem_v2.sh
sh 01_seleciona-mmfp_v4.sh
sh 02_preparaClustering_v3.sh
sh 03_rodarClustering_v1.sh
sh 04_seleciona_estrutura-cluster_v3.sh
sh 05_cluster-structure_v2.sh
sh 06_renomeia_cadeia_v5.sh
sh 07_hex_v5.sh
sh 08_ordena-energia_v3.sh
sh 09_1_copiar_pdbs_rank_v2.sh
sh 10_preparaClusteringfinal_v2.sh
sh 11_rodarClusteringfinal-parte1_v2.sh
sh 12_rodarClusteringfinal-parte2_v2.sh
sh 13_separa-organiza-clusters-docking_v4.sh
```

---

## 📥 Inputs gerais

* Estruturas geradas no CHARMM via VMOD
* Arquivos PDB de ligante e receptor
* Estruturas de referência para clusterização

---

## 📤 Outputs finais

* Ranking de energia (`energy_sorted.txt`)
* Complexos selecionados (`primeiras_10/`)
* Resultados finais clusterizados (`pos_docking/cluster/`)
* Estruturas representativas por cluster

---

# 🧪 Detalhamento das etapas

---

## 🧱 00_montagem_v2.sh

Cria a estrutura de diretórios necessária para execução do pipeline.

---

## 🔍 01_seleciona-mmfp_v4.sh

Seleciona estruturas com base no critério de energia MMFP.

---

## 🔄 02_preparaClustering_v3.sh

Converte estruturas selecionadas em trajetória para clusterização.

---

## 🧬 03_rodarClustering_v1.sh

Executa a clusterização utilizando GROMACS.

---

## 🎯 04_seleciona_estrutura-cluster_v3.sh

Seleciona estruturas representativas de cada cluster.

---

## 📁 05_cluster-structure_v2.sh

Copia as estruturas representativas para diretórios de cluster.

---

## 🔧 06_renomeia_cadeia_v5.sh

Ajusta o formato dos arquivos PDB e renomeia cadeias para evitar conflitos entre ligante e receptor.

---

## ⚛️ 07_hex_v5.sh

Executa o docking utilizando HEX.

---

## 📊 08_ordena-energia_v3.sh

Ordena as soluções de docking com base na energia.

---

## 🏆 09_1_copiar_pdbs_rank_v2.sh

Seleciona os complexos mais bem ranqueados.

---

## 🔄 10_preparaClusteringfinal_v2.sh

Prepara os complexos selecionados para clusterização final.

---

## 🧬 11 & 12 Clusterização final

Realiza a clusterização final dos complexos e gera:

* Estruturas centrais dos clusters
* Todas as estruturas de cada cluster

---

## 📂 13_separa-organiza-clusters-docking_v4.sh

Organiza os resultados finais em pastas estruturadas por cluster, incluindo informações de energia.

---

## ⚠️ Observações importantes

* Os scripts devem ser executados **na ordem correta**
* Certifique-se de que as estruturas seguem o padrão esperado
  
---

## 📌 Notas

Este pipeline foi desenvolvido no laboratório e pode exigir adaptações dependendo do ambiente computacional. A autoria do pipeline está nos scripts.
