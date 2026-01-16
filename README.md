# 📚 Projet BDD1 — Plateforme de gestion des projets, tâches & activités

> **Équipe** : Dior Mbengue, Khadidiatou Coulibaly, Seunkam Pahane Kenrencia Dyvana
> **Module** : Base de données 1 (ENSAE Dakar), dispensé par M. Baye Demba Diack 
> **Livrable** : Conception, modélisation et documentation d’une base de données complète (pas d’implémentation logicielle requise pour le rendu officiel). 

## 🎯 Objectif

Concevoir et documenter une base de données permettant de gérer :

* des **projets** (budget, durée, statut, priorité),
* des **tâches** (assignations multiples, backlog, avancement),
* des **activités / logs** (commentaires, changements, actions),
* des **équipes** et **utilisateurs** (rôles),
* des **documents** liés aux projets ou tâches,
* des **notifications** (optionnel mais recommandé).  

Le projet est réalisé dans un contexte “entreprise” : tout est organisé et documenté afin que le travail soit **compréhensible, vérifiable et réplicable** par une autre équipe. 

---

## 🧩 Périmètre & livrables attendus

Le repository contient l’ensemble des livrables demandés :

* ✅ **Analyse fonctionnelle** (étude du besoin)
* ✅ **Diagramme de contexte**
* ✅ **MCD** (Modèle Conceptuel de Données) *avec cardinalités*
* ✅ **MLD** (Modèle Logique de Données) *tables / clés*
* ✅ **MPD** (Modèle Physique de Données) *types SQL suggérés*
* ✅ **Dictionnaire des données**
* ✅ **Contraintes d’intégrité**
* ✅ **Use cases** (scénarios utilisateurs)
* ✅ **Propositions d’amélioration / extensions**
* ✅ **30 requêtes SQL** : 10 simples + 10 intermédiaires + 10 avancées (**à rédiger**)
* ✅ **Maquettes Figma** (quelques écrans)  

> ℹ️ Note : le rendu officiel est **100% modélisation** (pas de développement d’application requis). Une implémentation MVP peut être fournie **en annexe** si autorisée. 

---

## 🏗️ Concepts obligatoires modélisés

Le modèle couvre les fonctionnalités imposées par l’énoncé :

* **Utilisateurs** : nom, prénom, email, téléphone, rôle (Admin/Chef de projet/Membre), date d’inscription
* **Équipes** : création / adhésion ; une équipe gère plusieurs projets
* **Projets** : titre, description, budget, dates, statut, priorité ; un projet appartient à une seule équipe, avec plusieurs utilisateurs associés
* **Tâches** : liées à un projet ; statut, priorité, avancement ; assignation à 0..n utilisateurs (backlog possible)
* **Activités (logs)** : actions/commentaires, date/heure, utilisateur, type d’action
* **Documents** : attachés à un projet **ou** à une tâche (métadonnées d’upload)
* **Notifications** : optionnel (message, type, lu/non lu, utilisateur, date/heure)  

---

## 🧠 Choix techniques (DB & “dialecte SQL”)

* **Dialecte recommandé (MPD)** : **PostgreSQL**

  * Avantages : contraintes `CHECK`, intégrité, types et conventions robustes.
* **Requêtes SQL** : rédigées majoritairement en **SQL standard** (compatibles MySQL/PostgreSQL à quelques détails près).
* Un mémo “dialectes” est disponible dans `07_SQL_Dialectes_CheatSheet.md` pour comprendre les différences (`SERIAL` vs `AUTO_INCREMENT`, `LIMIT/OFFSET`, etc.).

---

## 🗂️ Structure du repository

```text
.
├── README.md
├── 00_README.md
├── 01_Analyse_Fonctionnelle/
│   ├── Analyse_Fonctionnelle.pdf
│   └── Analyse_Fonctionnelle_Template.docx
├── 02_Modelisation/
│   ├── README_Modelisation.md
│   ├── exports/
│   │   ├── Diagramme_Contexte.png
│   │   ├── MCD.png
│   │   ├── MLD.png
│   │   └── MPD.png
│   └── sources/
│       ├── MCD.drawio        (ou .dbdiagram / .mwb)
│       ├── MLD.drawio
│       └── MPD.drawio
├── 03_Dictionnaire_Donnees/
│   ├── Dictionnaire_Donnees.xlsx
│   └── Dictionnaire_Donnees.pdf
├── 04_Contraintes_Integrite/
│   └── Contraintes_Integrite.pdf
├── 05_Use_Cases/
│   ├── Use_Cases.pdf
│   └── Use_Cases_Template.docx
├── 06_Requetes_SQL/
│   ├── Requetes_SQL.sql
│   └── Requetes_SQL.pdf
├──07_Maquettes_Figma/
├── README_Maquettes.md
└── captures/
│    ├── ecran_01_connexion.png
│    ├── ecran_02_tableau_de_bord.png
│    ├── ecran_03_liste_projets.png
│    ├── ecran_04_detail_projet.png
│    ├── ecran_05_taches_projet.png
│    └── ...
├── 08_Annexes/
│   ├── SQL_Dialectes_CheatSheet.md
│   ├── Conventions_Nommage.md
│   └── Checklist_Final.md
├── 09_Ameliorations_Extensions/
│   └── Ameliorations.pdf
└── MVP_optional/                 (annexe si autorisée)
    ├── schema_postgresql_mvp.sql
    ├── seed.sql
    └── demo_queries.sql
```

> ✅ **Important** : dans `02_Modelisation/exports/`, les images doivent être **lisibles** (export PNG/PDF), car elles sont évaluées.

---

## 📄 Description rapide des dossiers

### `01_Analyse_Fonctionnelle/`

* Contient le besoin (contexte, acteurs, fonctionnalités, règles de gestion, contraintes non fonctionnelles).
* Document pivot : il justifie toutes les décisions de modélisation.

### `02_Modelisation/`

* `Diagramme_Contexte.png` : acteurs externes + interactions majeures.
* `MCD.png` : entités, attributs, associations, cardinalités.
* `MLD.png` : tables relationnelles, PK/FK, tables d’association (N–N).
* `MPD.png` : types SQL proposés, contraintes (`NOT NULL`, `UNIQUE`, `CHECK`), index éventuels.

### `03_Dictionnaire_Donnees/`

* Dictionnaire complet : pour chaque attribut → description, type, domaine, contraintes, PK/FK, nullable, exemple.

### `04_Contraintes_Integrite/`

* Liste formelle des contraintes : domaine, unicité, référentielles, et règles métier (ex : document lié à projet **ou** tâche).

### `05_Use_Cases/`

* 8–10 scénarios utilisateur détaillés (préconditions, scénario nominal, variantes, postconditions).

### `06_Requetes_SQL/`

* `Requetes_SQL.sql` : 30 requêtes (10 simples / 10 intermédiaires / 10 avancées), cohérentes avec le MLD/MPD. 
### `07_Maquettes_Figma_Interface_Utilisateur/`

* Capture de l'interface utilisaterur : Maquettes des écrans de l’application, fournies à titre illustratif.

### `08_Ameliorations_Extensions/`

* Propositions d’évolution : Kanban, reporting PDF, validation projets, gestion risques, etc. 

### `MVP_optional/` (annexe)

* Script de création des tables + jeu de données + requêtes de démonstration (si autorisé).

---

## 🔁 Comment reproduire / vérifier le travail

1. Lire `01_Analyse_Fonctionnelle/Analyse_Fonctionnelle.pdf`
2. Ouvrir les diagrammes (sources) dans `02_Modelisation/sources/` avec l’outil choisi (draw.io / dbdiagram / Workbench)
3. Vérifier la cohérence :

   * toutes les règles métier → cardinalités (MCD)
   * toutes les relations → PK/FK/tables N–N (MLD)
   * toutes les contraintes → `NOT NULL`, `UNIQUE`, `CHECK` (MPD)
4. Parcourir le dictionnaire : chaque colonne du MLD/MPD doit être décrite.
5. Lire les requêtes SQL : elles doivent refléter les fonctionnalités demandées.

---

## 🧭 Conventions (pour la cohérence du repo)

* Tables en `snake_case` et au pluriel (`users`, `projects`, `task_activities`)
* PK : `<table>_id` ; FK : `<ref_table>_id`
* Tables N–N : `project_members`, `task_assignees`
* Champs dates : `created_at`, `start_date`, `end_date_planned`
* Statuts/priorités : valeurs cohérentes et documentées dans le dictionnaire.

---
## 🔗 Lien vers la maquette Figma

La maquette interactive de la plateforme de gestion de projets est disponible en ligne via Figma :

👉 https://www.figma.com/make/AtIXlJaRMhyH1cMLKPooTY/Project-Management-Platform-UI

Cette maquette permet de visualiser l’enchaînement des écrans, les interactions prévues
et la logique fonctionnelle du système.

⚠️ Cette maquette est fournie à titre illustratif et ne constitue pas une implémentation
fonctionnelle de l’application.
---
## 📌 Notes & limites

* Le sujet impose la modélisation des utilisateurs/équipes/projets/tâches/activités/documents (+ notifications en option). 
* L’implémentation applicative n’est pas requise pour le rendu officiel (MVP en annexe uniquement). 

---

## 🏁 Acknowledgements

Projet réalisé dans le cadre de **Base de données 1 — Projet 1 (ENSAE Dakar)**. 
