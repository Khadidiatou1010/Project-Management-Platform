# Contraintes d’intégrité — ProjectFlow

Cette partie liste les contraintes d’intégrité du MPD. Les tableaux ci-dessous sont conçus pour un affichage stable (GitHub, VS Code, Obsidian, etc.).

## Rappel (1 paragraphe)

Les contraintes d’intégrité sont des règles appliquées par le SGBD pour empêcher l’enregistrement de données incohérentes. Elles couvrent l’intégrité d’entité (chaque ligne est unique via une clé primaire), l’intégrité référentielle (les clés étrangères ne peuvent pointer que vers des enregistrements existants), l’intégrité de domaine (valeurs obligatoires, unicité, plages/ensembles autorisés) et l’intégrité métier (règles propres au contexte, comme la cohérence des dates ou l’exclusivité « projet OU tâche » pour un document). En cas de violation, l’insertion ou la mise à jour est refusée.

## Tableau global des contraintes

| Table | Type d’intégrité | Mécanisme | Contrainte (SQL / résumé) | Sens métier |
|---|---|---|---|---|
| activite | Domaine | NOT NULL | `NOT NULL sur: date_heure, id_tache, id_utilisateur, type_activite` | Champs obligatoires (valeur requise). |
| activite | Entité | PRIMARY KEY | `PRIMARY KEY (id_activite)` | Identifie de façon unique chaque enregistrement. |
| activite | Domaine / Métier | CHECK | `CONSTRAINT ck_act_type CHECK (type_activite IN ('COMMENTAIRE','MAJ_STATUT','MAJ_AVANCEMENT','AJOUT_DOCUMENT','REASSIGNATION'))` | Limite les types d’activité à une liste autorisée. |
| activite | Référentielle | FOREIGN KEY | `CONSTRAINT fk_act_user FOREIGN KEY (id_utilisateur) REFERENCES utilisateur(id_utilisateur)` | Empêche activite.id_utilisateur de référencer une valeur inexistante (doit exister dans utilisateur(id_utilisateur)). |
| activite | Référentielle | FOREIGN KEY | `CONSTRAINT fk_act_task FOREIGN KEY (id_tache) REFERENCES tache(id_tache)` | Empêche activite.id_tache de référencer une valeur inexistante (doit exister dans tache(id_tache)). |
| appartenir | Domaine | NOT NULL | `NOT NULL sur: date_affectation, id_equipe, id_utilisateur` | Champs obligatoires (valeur requise). |
| appartenir | Entité | PRIMARY KEY | `PRIMARY KEY (id_utilisateur, id_equipe)` | Identifie de façon unique chaque enregistrement. |
| appartenir | Référentielle | FOREIGN KEY | `CONSTRAINT fk_app_user FOREIGN KEY (id_utilisateur) REFERENCES utilisateur(id_utilisateur)` | Empêche appartenir.id_utilisateur de référencer une valeur inexistante (doit exister dans utilisateur(id_utilisateur)). |
| appartenir | Référentielle | FOREIGN KEY | `CONSTRAINT fk_app_team FOREIGN KEY (id_equipe) REFERENCES equipe(id_equipe)` | Empêche appartenir.id_equipe de référencer une valeur inexistante (doit exister dans equipe(id_equipe)). |
| assigner | Domaine | NOT NULL | `NOT NULL sur: date_affectation, id_tache, id_utilisateur, role_tache` | Champs obligatoires (valeur requise). |
| assigner | Entité | PRIMARY KEY | `PRIMARY KEY (id_utilisateur, id_tache)` | Identifie de façon unique chaque enregistrement. |
| assigner | Référentielle | FOREIGN KEY | `CONSTRAINT fk_assign_user FOREIGN KEY (id_utilisateur) REFERENCES utilisateur(id_utilisateur)` | Empêche assigner.id_utilisateur de référencer une valeur inexistante (doit exister dans utilisateur(id_utilisateur)). |
| assigner | Référentielle | FOREIGN KEY | `CONSTRAINT fk_assign_task FOREIGN KEY (id_tache) REFERENCES tache(id_tache)` | Empêche assigner.id_tache de référencer une valeur inexistante (doit exister dans tache(id_tache)). |
| document | Domaine | NOT NULL | `NOT NULL sur: chemin_fichier, date_upload, id_utilisateur, nom_fichier` | Champs obligatoires (valeur requise). |
| document | Entité | PRIMARY KEY | `PRIMARY KEY (id_document)` | Identifie de façon unique chaque enregistrement. |
| document | Domaine / Métier | CHECK | `CONSTRAINT ck_doc_xor CHECK ((id_tache IS NULL) <> (id_projet IS NULL))` | Un document est rattaché à une tâche OU à un projet, pas les deux. |
| document | Référentielle | FOREIGN KEY | `CONSTRAINT fk_doc_task FOREIGN KEY (id_tache) REFERENCES tache(id_tache)` | Empêche document.id_tache de référencer une valeur inexistante (doit exister dans tache(id_tache)). |
| document | Référentielle | FOREIGN KEY | `CONSTRAINT fk_doc_projet FOREIGN KEY (id_projet) REFERENCES projet(id_projet)` | Empêche document.id_projet de référencer une valeur inexistante (doit exister dans projet(id_projet)). |
| document | Référentielle | FOREIGN KEY | `CONSTRAINT fk_doc_user FOREIGN KEY (id_utilisateur) REFERENCES utilisateur(id_utilisateur)` | Empêche document.id_utilisateur de référencer une valeur inexistante (doit exister dans utilisateur(id_utilisateur)). |
| equipe | Domaine | NOT NULL | `NOT NULL sur: date_creation, nom_equipe` | Champs obligatoires (valeur requise). |
| equipe | Entité | PRIMARY KEY | `PRIMARY KEY (id_equipe)` | Identifie de façon unique chaque enregistrement. |
| equipe | Domaine | UNIQUE | `UNIQUE (nom_equipe)` | Empêche deux équipes d’avoir le même nom. |
| notification | Domaine | NOT NULL | `NOT NULL sur: date_heure, id_utilisateur, message, statut, type_notification` | Champs obligatoires (valeur requise). |
| notification | Entité | PRIMARY KEY | `PRIMARY KEY (id_notification)` | Identifie de façon unique chaque enregistrement. |
| notification | Domaine / Métier | CHECK | `CONSTRAINT ck_notif_statut CHECK (statut IN ('LU','NON_LU'))` | Limite le statut de lecture des notifications à une liste autorisée. |
| notification | Référentielle | FOREIGN KEY | `CONSTRAINT fk_notif_user FOREIGN KEY (id_utilisateur) REFERENCES utilisateur(id_utilisateur)` | Empêche notification.id_utilisateur de référencer une valeur inexistante (doit exister dans utilisateur(id_utilisateur)). |
| projet | Domaine | NOT NULL | `NOT NULL sur: budget_alloue, date_debut, date_fin_prevue, description_projet, id_equipe, priorite, statut, titre_projet` | Champs obligatoires (valeur requise). |
| projet | Entité | PRIMARY KEY | `PRIMARY KEY (id_projet)` | Identifie de façon unique chaque enregistrement. |
| projet | Domaine | DEFAULT | `DEFAULT 0 sur budget_alloue` | Valeur par défaut appliquée si non fournie. |
| projet | Domaine / Métier | CHECK | `CONSTRAINT ck_projet_budget CHECK (budget_alloue >= 0)` | Empêche les budgets négatifs. |
| projet | Domaine / Métier | CHECK | `CONSTRAINT ck_projet_dates CHECK (date_fin_prevue >= date_debut)` | Empêche une date de fin prévue antérieure à la date de début. |
| projet | Domaine / Métier | CHECK | `CONSTRAINT ck_projet_statut CHECK (statut IN ('EN_PLANIFICATION','EN_COURS','EN_PAUSE','TERMINE'))` | Limite les statuts de projet à une liste autorisée. |
| projet | Domaine / Métier | CHECK | `CONSTRAINT ck_projet_priorite CHECK (priorite IN ('HAUTE','MOYENNE','BASSE'))` | Limite les priorités de projet à une liste autorisée. |
| projet | Référentielle | FOREIGN KEY | `CONSTRAINT fk_projet_equipe FOREIGN KEY (id_equipe) REFERENCES equipe(id_equipe)` | Empêche projet.id_equipe de référencer une valeur inexistante (doit exister dans equipe(id_equipe)). |
| projet_membre | Domaine | NOT NULL | `NOT NULL sur: date_affectation, id_projet, id_utilisateur, role_projet` | Champs obligatoires (valeur requise). |
| projet_membre | Entité | PRIMARY KEY | `PRIMARY KEY (id_projet, id_utilisateur)` | Identifie de façon unique chaque enregistrement. |
| projet_membre | Domaine / Métier | CHECK | `CONSTRAINT ck_pm_role CHECK (role_projet IN ('CHEF_PROJET','MEMBRE'))` | Limite les rôles dans un projet à une liste autorisée. |
| projet_membre | Référentielle | FOREIGN KEY | `CONSTRAINT fk_pm_projet FOREIGN KEY (id_projet) REFERENCES projet(id_projet)` | Empêche projet_membre.id_projet de référencer une valeur inexistante (doit exister dans projet(id_projet)). |
| projet_membre | Référentielle | FOREIGN KEY | `CONSTRAINT fk_pm_user FOREIGN KEY (id_utilisateur) REFERENCES utilisateur(id_utilisateur)` | Empêche projet_membre.id_utilisateur de référencer une valeur inexistante (doit exister dans utilisateur(id_utilisateur)). |
| tache | Domaine | NOT NULL | `NOT NULL sur: id_projet, pourcentage_avancement, priorite, statut, titre_tache` | Champs obligatoires (valeur requise). |
| tache | Entité | PRIMARY KEY | `PRIMARY KEY (id_tache)` | Identifie de façon unique chaque enregistrement. |
| tache | Domaine | DEFAULT | `DEFAULT 0 sur pourcentage_avancement` | Valeur par défaut appliquée si non fournie. |
| tache | Domaine / Métier | CHECK | `CONSTRAINT ck_tache_avancement CHECK (pourcentage_avancement BETWEEN 0 AND 100)` | Force l’avancement d’une tâche à rester entre 0 et 100. |
| tache | Domaine / Métier | CHECK | `CONSTRAINT ck_tache_dates CHECK (date_fin_prevue IS NULL OR date_debut_prevue IS NULL OR date_fin_prevue >= date_debut_prevue)` | Empêche une date de fin prévue antérieure à la date de début (si les deux dates sont renseignées). |
| tache | Domaine / Métier | CHECK | `CONSTRAINT ck_tache_statut CHECK (statut IN ('A_FAIRE','EN_COURS','TERMINE','BLOQUE'))` | Limite les statuts de tâche à une liste autorisée. |
| tache | Domaine / Métier | CHECK | `CONSTRAINT ck_tache_priorite CHECK (priorite IN ('HAUTE','MOYENNE','BASSE'))` | Limite les priorités de tâche à une liste autorisée. |
| tache | Référentielle | FOREIGN KEY | `CONSTRAINT fk_tache_projet FOREIGN KEY (id_projet) REFERENCES projet(id_projet)` | Empêche tache.id_projet de référencer une valeur inexistante (doit exister dans projet(id_projet)). |
| utilisateur | Domaine | NOT NULL | `NOT NULL sur: date_inscription, email_utilisateur, nom_utilisateur, prenom_utilisateur, role_utilisateur` | Champs obligatoires (valeur requise). |
| utilisateur | Entité | PRIMARY KEY | `PRIMARY KEY (id_utilisateur)` | Identifie de façon unique chaque enregistrement. |
| utilisateur | Domaine | UNIQUE | `UNIQUE (email_utilisateur)` | Empêche deux utilisateurs d’avoir le même email. |
| utilisateur | Domaine / Métier | CHECK | `CONSTRAINT ck_user_role CHECK (role_utilisateur IN ('ADMIN','CHEF_PROJET','MEMBRE'))` | Limite les rôles d’utilisateur à une liste autorisée. |

## Détail par table


### `ACTIVITE`

| Type d’intégrité | Mécanisme | Contrainte | Sens |
|---|---|---|---|
| Domaine | NOT NULL | `NOT NULL sur: date_heure, id_tache, id_utilisateur, type_activite` | Champs obligatoires (valeur requise). |
| Entité | PRIMARY KEY | `PRIMARY KEY (id_activite)` | Identifie de façon unique chaque enregistrement. |
| Domaine / Métier | CHECK | `CONSTRAINT ck_act_type CHECK (type_activite IN ('COMMENTAIRE','MAJ_STATUT','MAJ_AVANCEMENT','AJOUT_DOCUMENT','REASSIGNATION'))` | Limite les types d’activité à une liste autorisée. |
| Référentielle | FOREIGN KEY | `CONSTRAINT fk_act_user FOREIGN KEY (id_utilisateur) REFERENCES utilisateur(id_utilisateur)` | Empêche activite.id_utilisateur de référencer une valeur inexistante (doit exister dans utilisateur(id_utilisateur)). |
| Référentielle | FOREIGN KEY | `CONSTRAINT fk_act_task FOREIGN KEY (id_tache) REFERENCES tache(id_tache)` | Empêche activite.id_tache de référencer une valeur inexistante (doit exister dans tache(id_tache)). |

### `APPARTENIR`

| Type d’intégrité | Mécanisme | Contrainte | Sens |
|---|---|---|---|
| Domaine | NOT NULL | `NOT NULL sur: date_affectation, id_equipe, id_utilisateur` | Champs obligatoires (valeur requise). |
| Entité | PRIMARY KEY | `PRIMARY KEY (id_utilisateur, id_equipe)` | Identifie de façon unique chaque enregistrement. |
| Référentielle | FOREIGN KEY | `CONSTRAINT fk_app_user FOREIGN KEY (id_utilisateur) REFERENCES utilisateur(id_utilisateur)` | Empêche appartenir.id_utilisateur de référencer une valeur inexistante (doit exister dans utilisateur(id_utilisateur)). |
| Référentielle | FOREIGN KEY | `CONSTRAINT fk_app_team FOREIGN KEY (id_equipe) REFERENCES equipe(id_equipe)` | Empêche appartenir.id_equipe de référencer une valeur inexistante (doit exister dans equipe(id_equipe)). |

### `ASSIGNER`

| Type d’intégrité | Mécanisme | Contrainte | Sens |
|---|---|---|---|
| Domaine | NOT NULL | `NOT NULL sur: date_affectation, id_tache, id_utilisateur, role_tache` | Champs obligatoires (valeur requise). |
| Entité | PRIMARY KEY | `PRIMARY KEY (id_utilisateur, id_tache)` | Identifie de façon unique chaque enregistrement. |
| Référentielle | FOREIGN KEY | `CONSTRAINT fk_assign_user FOREIGN KEY (id_utilisateur) REFERENCES utilisateur(id_utilisateur)` | Empêche assigner.id_utilisateur de référencer une valeur inexistante (doit exister dans utilisateur(id_utilisateur)). |
| Référentielle | FOREIGN KEY | `CONSTRAINT fk_assign_task FOREIGN KEY (id_tache) REFERENCES tache(id_tache)` | Empêche assigner.id_tache de référencer une valeur inexistante (doit exister dans tache(id_tache)). |

### `DOCUMENT`

| Type d’intégrité | Mécanisme | Contrainte | Sens |
|---|---|---|---|
| Domaine | NOT NULL | `NOT NULL sur: chemin_fichier, date_upload, id_utilisateur, nom_fichier` | Champs obligatoires (valeur requise). |
| Entité | PRIMARY KEY | `PRIMARY KEY (id_document)` | Identifie de façon unique chaque enregistrement. |
| Domaine / Métier | CHECK | `CONSTRAINT ck_doc_xor CHECK ((id_tache IS NULL) <> (id_projet IS NULL))` | Un document est rattaché à une tâche OU à un projet, pas les deux. |
| Référentielle | FOREIGN KEY | `CONSTRAINT fk_doc_task FOREIGN KEY (id_tache) REFERENCES tache(id_tache)` | Empêche document.id_tache de référencer une valeur inexistante (doit exister dans tache(id_tache)). |
| Référentielle | FOREIGN KEY | `CONSTRAINT fk_doc_projet FOREIGN KEY (id_projet) REFERENCES projet(id_projet)` | Empêche document.id_projet de référencer une valeur inexistante (doit exister dans projet(id_projet)). |
| Référentielle | FOREIGN KEY | `CONSTRAINT fk_doc_user FOREIGN KEY (id_utilisateur) REFERENCES utilisateur(id_utilisateur)` | Empêche document.id_utilisateur de référencer une valeur inexistante (doit exister dans utilisateur(id_utilisateur)). |

### `EQUIPE`

| Type d’intégrité | Mécanisme | Contrainte | Sens |
|---|---|---|---|
| Domaine | NOT NULL | `NOT NULL sur: date_creation, nom_equipe` | Champs obligatoires (valeur requise). |
| Entité | PRIMARY KEY | `PRIMARY KEY (id_equipe)` | Identifie de façon unique chaque enregistrement. |
| Domaine | UNIQUE | `UNIQUE (nom_equipe)` | Empêche deux équipes d’avoir le même nom. |

### `NOTIFICATION`

| Type d’intégrité | Mécanisme | Contrainte | Sens |
|---|---|---|---|
| Domaine | NOT NULL | `NOT NULL sur: date_heure, id_utilisateur, message, statut, type_notification` | Champs obligatoires (valeur requise). |
| Entité | PRIMARY KEY | `PRIMARY KEY (id_notification)` | Identifie de façon unique chaque enregistrement. |
| Domaine / Métier | CHECK | `CONSTRAINT ck_notif_statut CHECK (statut IN ('LU','NON_LU'))` | Limite le statut de lecture des notifications à une liste autorisée. |
| Référentielle | FOREIGN KEY | `CONSTRAINT fk_notif_user FOREIGN KEY (id_utilisateur) REFERENCES utilisateur(id_utilisateur)` | Empêche notification.id_utilisateur de référencer une valeur inexistante (doit exister dans utilisateur(id_utilisateur)). |

### `PROJET`

| Type d’intégrité | Mécanisme | Contrainte | Sens |
|---|---|---|---|
| Domaine | NOT NULL | `NOT NULL sur: budget_alloue, date_debut, date_fin_prevue, description_projet, id_equipe, priorite, statut, titre_projet` | Champs obligatoires (valeur requise). |
| Entité | PRIMARY KEY | `PRIMARY KEY (id_projet)` | Identifie de façon unique chaque enregistrement. |
| Domaine | DEFAULT | `DEFAULT 0 sur budget_alloue` | Valeur par défaut appliquée si non fournie. |
| Domaine / Métier | CHECK | `CONSTRAINT ck_projet_budget CHECK (budget_alloue >= 0)` | Empêche les budgets négatifs. |
| Domaine / Métier | CHECK | `CONSTRAINT ck_projet_dates CHECK (date_fin_prevue >= date_debut)` | Empêche une date de fin prévue antérieure à la date de début. |
| Domaine / Métier | CHECK | `CONSTRAINT ck_projet_statut CHECK (statut IN ('EN_PLANIFICATION','EN_COURS','EN_PAUSE','TERMINE'))` | Limite les statuts de projet à une liste autorisée. |
| Domaine / Métier | CHECK | `CONSTRAINT ck_projet_priorite CHECK (priorite IN ('HAUTE','MOYENNE','BASSE'))` | Limite les priorités de projet à une liste autorisée. |
| Référentielle | FOREIGN KEY | `CONSTRAINT fk_projet_equipe FOREIGN KEY (id_equipe) REFERENCES equipe(id_equipe)` | Empêche projet.id_equipe de référencer une valeur inexistante (doit exister dans equipe(id_equipe)). |

### `PROJET_MEMBRE`

| Type d’intégrité | Mécanisme | Contrainte | Sens |
|---|---|---|---|
| Domaine | NOT NULL | `NOT NULL sur: date_affectation, id_projet, id_utilisateur, role_projet` | Champs obligatoires (valeur requise). |
| Entité | PRIMARY KEY | `PRIMARY KEY (id_projet, id_utilisateur)` | Identifie de façon unique chaque enregistrement. |
| Domaine / Métier | CHECK | `CONSTRAINT ck_pm_role CHECK (role_projet IN ('CHEF_PROJET','MEMBRE'))` | Limite les rôles dans un projet à une liste autorisée. |
| Référentielle | FOREIGN KEY | `CONSTRAINT fk_pm_projet FOREIGN KEY (id_projet) REFERENCES projet(id_projet)` | Empêche projet_membre.id_projet de référencer une valeur inexistante (doit exister dans projet(id_projet)). |
| Référentielle | FOREIGN KEY | `CONSTRAINT fk_pm_user FOREIGN KEY (id_utilisateur) REFERENCES utilisateur(id_utilisateur)` | Empêche projet_membre.id_utilisateur de référencer une valeur inexistante (doit exister dans utilisateur(id_utilisateur)). |

### `TACHE`

| Type d’intégrité | Mécanisme | Contrainte | Sens |
|---|---|---|---|
| Domaine | NOT NULL | `NOT NULL sur: id_projet, pourcentage_avancement, priorite, statut, titre_tache` | Champs obligatoires (valeur requise). |
| Entité | PRIMARY KEY | `PRIMARY KEY (id_tache)` | Identifie de façon unique chaque enregistrement. |
| Domaine | DEFAULT | `DEFAULT 0 sur pourcentage_avancement` | Valeur par défaut appliquée si non fournie. |
| Domaine / Métier | CHECK | `CONSTRAINT ck_tache_avancement CHECK (pourcentage_avancement BETWEEN 0 AND 100)` | Force l’avancement d’une tâche à rester entre 0 et 100. |
| Domaine / Métier | CHECK | `CONSTRAINT ck_tache_dates CHECK (date_fin_prevue IS NULL OR date_debut_prevue IS NULL OR date_fin_prevue >= date_debut_prevue)` | Empêche une date de fin prévue antérieure à la date de début (si les deux dates sont renseignées). |
| Domaine / Métier | CHECK | `CONSTRAINT ck_tache_statut CHECK (statut IN ('A_FAIRE','EN_COURS','TERMINE','BLOQUE'))` | Limite les statuts de tâche à une liste autorisée. |
| Domaine / Métier | CHECK | `CONSTRAINT ck_tache_priorite CHECK (priorite IN ('HAUTE','MOYENNE','BASSE'))` | Limite les priorités de tâche à une liste autorisée. |
| Référentielle | FOREIGN KEY | `CONSTRAINT fk_tache_projet FOREIGN KEY (id_projet) REFERENCES projet(id_projet)` | Empêche tache.id_projet de référencer une valeur inexistante (doit exister dans projet(id_projet)). |

### `UTILISATEUR`

| Type d’intégrité | Mécanisme | Contrainte | Sens |
|---|---|---|---|
| Domaine | NOT NULL | `NOT NULL sur: date_inscription, email_utilisateur, nom_utilisateur, prenom_utilisateur, role_utilisateur` | Champs obligatoires (valeur requise). |
| Entité | PRIMARY KEY | `PRIMARY KEY (id_utilisateur)` | Identifie de façon unique chaque enregistrement. |
| Domaine | UNIQUE | `UNIQUE (email_utilisateur)` | Empêche deux utilisateurs d’avoir le même email. |
| Domaine / Métier | CHECK | `CONSTRAINT ck_user_role CHECK (role_utilisateur IN ('ADMIN','CHEF_PROJET','MEMBRE'))` | Limite les rôles d’utilisateur à une liste autorisée. |
