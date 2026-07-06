# Protein–Protein Docking Pipeline

## 📌 Description

This pipeline consists of a set of scripts developed to perform **protein–protein docking**, starting from structures generated in CHARMM (via VMOD) to the generation of clustered docking solutions ranked by energy.

The workflow integrates preprocessing, structure selection, clustering, docking (HEX), and post-processing analysis.

---

## 🎯 When to Use

Use this pipeline when:

* You have **protein structures generated through normal mode analysis (VMOD/CHARMM)**
* You want to:

  * Filter conformations based on MMFP energy
  * Cluster conformations
  * Perform docking using HEX
  * Rank and cluster docking solutions

---

## 📂 What This Pipeline Generates

* Conformations filtered based on MMFP energy
* Clustered ligand and receptor structures
* Docking solutions (HEX)
* Energy-ranked complexes
* Final clustered results
* Representative structures organized by cluster

---

## ⚙️ Requirements
Requirements and software dependencies are described in:
[Requirements](https://github.com/Labbiofisbiocomp/protein-protein-docking/blob/main/requirements.md)

---

## 🔄 Pipeline Overview

```text
CHARMM / VMOD structure generation
        ↓
MMFP filtering (structure selection)
        ↓
Clustering of ligand and receptor (separately)
        ↓
Selection of representative structures
        ↓
Structure preparation (chain renaming / formatting)
        ↓
Docking (HEX)
        ↓
Energy ranking of docking solutions
        ↓
Selection of top-ranked complexes
        ↓
Final clustering of docking solutions
        ↓
Cluster organization and analysis
```

---

## ▶️ How to Run (Step-by-Step)

Execute the scripts in the following order:

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

* Structures generated in CHARMM via VMOD
* Ligand and receptor PDB files
* Reference structures for clustering

---

## 📤 Outputs

* Energy ranking (`energy_sorted.txt`)
* Selected complexes (`primeiras_10/`)
* Final clustered results (`pos_docking/cluster/`)
* Representative structures for each cluster

---

# 🧪 Step Details

---

## 🧱 00_montagem_v2.sh

Creates the directory structure required to run the pipeline.

---

## 🔍 01_seleciona-mmfp_v4.sh

Selects structures based on the MMFP energy criterion.

---

## 🔄 02_preparaClustering_v3.sh

Converts selected structures into trajectory format for clustering.

---

## 🧬 03_rodarClustering_v1.sh

Performs clustering using GROMACS.

---

## 🎯 04_seleciona_estrutura-cluster_v3.sh

Selects representative structures from each cluster.

---

## 📁 05_cluster-structure_v2.sh

Copies representative structures into cluster directories.

---

## 🔧 06_renomeia_cadeia_v5.sh

Adjusts PDB file formatting and renames chains to avoid conflicts between ligand and receptor.

---

## ⚛️ 07_hex_v5.sh

Performs docking using HEX.

---

## 📊 08_ordena-energia_v3.sh

Ranks docking solutions based on energy.

---

## 🏆 09_1_copiar_pdbs_rank_v2.sh

Selects the top-ranked complexes.

---

## 🔄 10_preparaClusteringfinal_v2.sh

Prepares selected complexes for final clustering.

---

## 🧬 11 & 12 Final Clustering

Performs final clustering of the complexes and generates:

* Central cluster structures
* All structures belonging to each cluster

---

## 📂 13_separa-organiza-clusters-docking_v4.sh

Organizes the final results into structured cluster folders, including energy information.

---

## ⚠️ Observations

* Scripts must be executed **in the correct order**
* Make sure the structures follow the expected format

---

## 📌 Notes

This pipeline was developed in the laboratory environment and may require adaptations depending on the computational environment. Pipeline authorship information is available within the scripts.
