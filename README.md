# Pipeline de Docking Proteína–Proteína

## 📌 Descrição

Este pipeline foi desenvolvido para realizar **docking proteína–proteína**, integrando desde o pré-processamento de estruturas geradas por **CHARMM/VMOD** até a obtenção de complexos clusterizados e classificados por energia.

O workflow automatiza etapas de seleção estrutural, clusterização, preparação dos arquivos de entrada, execução do docking utilizando **HEX** e organização dos resultados para análises posteriores.

---
## ⚙️ Requisitos
Os requisitos e dependências estão disponíveis em:

[Requirements](https://github.com/Labbiofisbiocomp/protein-protein-docking/blob/main/requirements.md)

---
# 📖 Sobre o projeto

Este pipeline foi desenvolvido para:

- selecionar conformações com base na energia MMFP;
- realizar clusterização independente de ligantes e receptores;
- executar docking proteína–proteína utilizando o HEX;
- classificar soluções de docking por energia;
- gerar estruturas representativas organizadas por clusters.

---

# 📂 Estrutura do repositório

```text
.
├── requirements.md
├── 00_montagem_v2.sh
├── 01_seleciona-mmfp_v4.sh
├── 02_preparaClustering_v3.sh
├── 03_rodarClustering_v1.sh
├── 04_seleciona_estrutura-cluster_v3.sh
├── 05_cluster-structure_v2.sh
├── 06_renomeia_cadeia_v5.sh
├── 07_hex_v5.sh
├── 08_ordena-energia_v3.sh
├── 09_1_copiar_pdbs_rank_v2.sh
├── 10_preparaClusteringfinal_v2.sh
├── 11_rodarClusteringfinal-parte1_v2.sh
├── 12_rodarClusteringfinal-parte2_v2.sh
├── 13_separa-organiza-clusters-docking_v4.sh
└── README.md
```

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

## ▶️ Como executar
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
## 📥 Inputs

* Estruturas geradas no CHARMM via VMOD
* Arquivos PDB de ligante e receptor
* Estruturas de referência para clusterização

---

## 📤 Outputs

* Ranking de energia (`energy_sorted.txt`)
* Complexos selecionados (`primeiras_10/`)
* Resultados finais clusterizados (`pos_docking/cluster/`)
* Estruturas representativas por cluster

---
## 🧪 Estrutura dos arquivos

- `00_montagem_v2.sh` → Cria a estrutura de diretórios do pipeline.
- `01_seleciona-mmfp_v4.sh` → Seleciona estruturas com base na energia MMFP.
- `02_preparaClustering_v3.sh` → Prepara as estruturas para clusterização.
- `03_rodarClustering_v1.sh` → Executa a clusterização utilizando GROMACS.
- `04_seleciona_estrutura-cluster_v3.sh` → Seleciona estruturas representativas dos clusters.
- `05_cluster-structure_v2.sh` → Organiza as estruturas selecionadas.
- `06_renomeia_cadeia_v5.sh` → Ajusta e renomeia cadeias dos arquivos PDB.
- `07_hex_v5.sh` → Executa o docking proteína–proteína utilizando HEX.
- `08_ordena-energia_v3.sh` → Ordena as soluções por energia.
- `09_1_copiar_pdbs_rank_v2.sh` → Seleciona os complexos mais bem classificados.
- `10_preparaClusteringfinal_v2.sh` → Prepara os complexos para a clusterização final.
- `11_rodarClusteringfinal-parte1_v2.sh` → Primeira etapa da clusterização final.
- `12_rodarClusteringfinal-parte2_v2.sh` → Segunda etapa da clusterização final.
- `13_separa-organiza-clusters-docking_v4.sh` → Organiza os resultados finais em diretórios por cluster.

---

## ⚠️ Observações importantes

* Os scripts devem ser executados na ordem apresentada.
* Certifique-se de que as estruturas de entrada estejam corretamente formatadas antes de iniciar o pipeline.
* Dependendo da quantidade de estruturas processadas, algumas etapas podem demandar tempo significativo.
* Verifique os resultados intermediários antes de prosseguir para as etapas seguintes.
  
---

## 📌 Notas

Este pipeline foi desenvolvido no laboratório e pode exigir adaptações dependendo do ambiente computacional.
Autoria: Script desenvolvido por Eric Allison Philot. E-mail: ericphilot@hotmail.com
