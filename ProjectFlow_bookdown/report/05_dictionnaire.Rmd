# Dictionnaire des données


Le **dictionnaire des données** est un **document explicatif** (souvent un tableau Word/Excel) qui décrit chaque champ du MPD : sa signification métier, son type, s’il est obligatoire, ses valeurs possibles (domaines/énumérations), ses contraintes, ses liens (FK), et parfois des exemples. Il ne remplace pas les modèles : il sert à rendre le schéma **compréhensible et réplicable** par d’autres (développeurs, analystes, nouveaux membres de l’équipe).


## Entité `UTILISATEUR`

**Description :** Représente une personne utilisant la plateforme (admin, chef de projet ou membre).

**Règles & contraintes clés :**
- Clé primaire : `id_utilisateur`.
- Unicité : `email_utilisateur`.
- Règles : email unique ; rôle dans {ADMIN, CHEF_PROJET, MEMBRE}.

| Attribut | Description | Type | Domaine | Contraintes | Clé (PK/FK) | Nullable | Exemple |
|---|---|---|---|---|---|---|---|
| id_utilisateur | Identifiant unique de l’utilisateur. | INT | Entier |  | PK | Oui |  |
| nom_utilisateur | Nom de famille. | VARCHAR(50) | Texte libre (max 50 caractères) | NOT NULL |  | Non |  |
| prenom_utilisateur | Prénom. | VARCHAR(50) | Texte libre (max 50 caractères) | NOT NULL |  | Non |  |
| email_utilisateur | Adresse email (unique). | VARCHAR(50) | Texte libre (max 50 caractères) | NOT NULL; UNIQUE |  | Non | dior.ndiaye@example.sn |
| telephone_utilisateur | Numéro de téléphone (format libre). | VARCHAR(50) | Texte libre (max 50 caractères) |  |  | Oui |  |
| role_utilisateur | Rôle applicatif (droits). | VARCHAR(50) | Enum: ADMIN \| CHEF_PROJET \| MEMBRE | NOT NULL; CHECK IN (ADMIN, CHEF_PROJET, MEMBRE) |  | Non | CHEF_PROJET |
| date_inscription | Date d’inscription sur la plateforme. | DATE | Date | NOT NULL |  | Non |  |

## Entité `EQUIPE`

**Description :** Regroupe des utilisateurs au sein d’une même équipe de travail.

**Règles & contraintes clés :**
- Clé primaire : `id_equipe`.

| Attribut | Description | Type | Domaine | Contraintes | Clé (PK/FK) | Nullable | Exemple |
|---|---|---|---|---|---|---|---|
| id_equipe | Identifiant unique de l’équipe. | INT | Entier |  | PK | Oui |  |
| nom_equipe | Nom de l’équipe (unique). | VARCHAR(50) | Texte libre (max 50 caractères) | NOT NULL |  | Non | Programme Santé & Terrain |
| description | Description courte de l’équipe. | VARCHAR(50) | Texte libre (max 50 caractères) |  |  | Oui |  |
| date_creation | Date de création de l’équipe. | DATE | Date | NOT NULL |  | Non |  |

## Entité `APPARTENIR`

**Description :** Association utilisateur↔équipe (N–N) avec date d’affectation.

**Règles & contraintes clés :**
- Clé primaire composite : (id_utilisateur, id_equipe).
- Références (FK) : `id_utilisateur` → UTILISATEUR(id_utilisateur), `id_equipe` → EQUIPE(id_equipe).
- Règle : une ligne par paire (via clé primaire composite).

| Attribut | Description | Type | Domaine | Contraintes | Clé (PK/FK) | Nullable | Exemple |
|---|---|---|---|---|---|---|---|
| id_utilisateur | Utilisateur membre de l’équipe. | INT | Entier |  | PK, FK → UTILISATEUR(id_utilisateur) | Oui |  |
| id_equipe | Équipe concernée. | INT | Entier |  | PK, FK → EQUIPE(id_equipe) | Oui |  |
| date_affectation | Date d’affectation. | DATE | Date | NOT NULL |  | Non |  |

## Entité `PROJET`

**Description :** Projet porté par une équipe, avec planning, budget, statut et priorité.

**Règles & contraintes clés :**
- Clé primaire : `id_projet`.
- Références (FK) : `id_equipe` → EQUIPE(id_equipe).
- Règles : budget ≥ 0 ; date_fin_prevue ≥ date_debut ; statut/priorité dans des listes autorisées.

| Attribut | Description | Type | Domaine | Contraintes | Clé (PK/FK) | Nullable | Exemple |
|---|---|---|---|---|---|---|---|
| id_projet | Identifiant unique du projet. | INT | Entier |  | PK | Oui |  |
| titre_projet | Titre du projet. | VARCHAR(50) | Texte libre (max 50 caractères) | NOT NULL |  | Non | Digitalisation suivi vaccins |
| description_projet | Description du projet. | VARCHAR(150) | Texte libre (max 150 caractères) | NOT NULL |  | Non |  |
| date_debut | Date de démarrage. | DATE | Date |  |  | Oui |  |
| date_fin_prevue | Date de fin prévue. | DATE | Date | CHECK (date_fin_prevue >= date_debut) |  | Oui |  |
| budget_alloue | Budget alloué (≥ 0). | DECIMAL(15,7) | Montant (nombre décimal) | CHECK (budget_alloue >= 0) |  | Oui | 15000000.00 |
| statut | Statut du projet. | VARCHAR(50) | Enum: EN_PLANIFICATION \| EN_COURS \| EN_PAUSE \| TERMINE | NOT NULL; CHECK IN (EN_PLANIFICATION, EN_COURS, EN_PAUSE, TERMINE) |  | Non | EN_COURS |
| priorite | Priorité du projet. | VARCHAR(50) | Enum: HAUTE \| MOYENNE \| BASSE | CHECK IN (HAUTE, MOYENNE, BASSE) |  | Oui |  |
| id_equipe | Équipe porteuse du projet. | INT | Entier | NOT NULL | FK → EQUIPE(id_equipe) | Non |  |

## Entité `TACHE`

**Description :** Tâche rattachée à un projet, avec statut, priorité et % d’avancement.

**Règles & contraintes clés :**
- Clé primaire : `id_tache`.
- Références (FK) : `id_projet` → PROJET(id_projet).
- Règles : avancement 0..100 ; statut/priorité dans des listes autorisées ; cohérence des dates si renseignées.

| Attribut | Description | Type | Domaine | Contraintes | Clé (PK/FK) | Nullable | Exemple |
|---|---|---|---|---|---|---|---|
| id_tache | Identifiant unique de la tâche. | INT | Entier |  | PK | Oui |  |
| titre_tache | Titre de la tâche. | VARCHAR(50) | Texte libre (max 50 caractères) | NOT NULL |  | Non | Configurer modèle de données |
| description_tache | Description de la tâche. | VARCHAR(150) | Texte libre (max 150 caractères) |  |  | Oui |  |
| date_debut_prevue | Date de début prévue. | DATE | Date |  |  | Oui |  |
| date_fin_prevue | Date de fin prévue. | DATE | Date |  |  | Oui |  |
| pourcentage_avancement | Avancement en % (0–100). | INT | Entier | NOT NULL; CHECK (pourcentage_avancement BETWEEN 0 AND 100) |  | Non | 35 |
| priorite | Priorité de la tâche. | VARCHAR(50) | Enum: HAUTE \| MOYENNE \| BASSE | CHECK IN (HAUTE, MOYENNE, BASSE) |  | Oui |  |
| id_projet | Projet parent. | INT | Entier | NOT NULL | FK → PROJET(id_projet) | Non |  |
| statut | Statut de la tâche. | VARCHAR(20) | Enum: A_FAIRE \| EN_COURS \| TERMINE \| BLOQUE | NOT NULL; CHECK IN (A_FAIRE, EN_COURS, TERMINE, BLOQUE) |  | Non | EN_COURS |

## Entité `ASSIGNER`

**Description :** Association utilisateur↔tâche (N–N) avec date et rôle dans la tâche.

**Règles & contraintes clés :**
- Clé primaire composite : (id_utilisateur, id_tache).
- Références (FK) : `id_utilisateur` → UTILISATEUR(id_utilisateur), `id_tache` → TACHE(id_tache).
- Règle : une ligne par paire (via clé primaire composite).

| Attribut | Description | Type | Domaine | Contraintes | Clé (PK/FK) | Nullable | Exemple |
|---|---|---|---|---|---|---|---|
| id_utilisateur | Utilisateur assigné. | INT | Entier |  | PK, FK → UTILISATEUR(id_utilisateur) | Oui |  |
| id_tache | Tâche concernée. | INT | Entier |  | PK, FK → TACHE(id_tache) | Oui |  |
| date_affectation | Date d’assignation. | DATE | Date | NOT NULL |  | Non |  |
| role_tache | Rôle dans la tâche (ex: Responsable, Contributeur). | VARCHAR(50) | Texte libre (max 50 caractères) | NOT NULL |  | Non |  |

## Entité `ACTIVITE`

**Description :** Journal des actions/événements (logs) réalisés sur les tâches.

**Règles & contraintes clés :**
- Clé primaire : `id_activite`.
- Références (FK) : `id_utilisateur` → UTILISATEUR(id_utilisateur), `id_tache` → TACHE(id_tache).
- Règle : type_activite dans une liste autorisée ; toujours rattachée à un utilisateur et une tâche.

| Attribut | Description | Type | Domaine | Contraintes | Clé (PK/FK) | Nullable | Exemple |
|---|---|---|---|---|---|---|---|
| id_activite | Identifiant unique de l’activité/log. | INT | Entier |  | PK | Oui |  |
| action_commentaire | Commentaire / description d’action. | VARCHAR(300) | Texte libre (max 300 caractères) |  |  | Oui |  |
| date_heure | Date et heure. | DATETIME | Date & heure | NOT NULL |  | Non |  |
| type_activite | Type d’activité. | VARCHAR(50) | Enum: COMMENTAIRE \| MAJ_STATUT \| MAJ_AVANCEMENT \| AJOUT_DOCUMENT \| REASSIGNATION | NOT NULL; CHECK IN (COMMENTAIRE, MAJ_STATUT, MAJ_AVANCEMENT, AJOUT_DOCUMENT, REASSIGNATION) |  | Non |  |
| id_utilisateur | Auteur. | INT | Entier | NOT NULL | FK → UTILISATEUR(id_utilisateur) | Non |  |
| id_tache | Tâche concernée. | INT | Entier | NOT NULL | FK → TACHE(id_tache) | Non |  |

## Entité `DOCUMENT`

**Description :** Document téléversé, rattaché à une tâche OU à un projet, et à un utilisateur auteur.

**Règles & contraintes clés :**
- Clé primaire : `id_document`.
- Références (FK) : `id_tache` → TACHE(id_tache), `id_projet` → PROJET(id_projet), `id_utilisateur` → UTILISATEUR(id_utilisateur).
- Règle : rattachement exclusif à un PROJET OU une TÂCHE (pas les deux).

| Attribut | Description | Type | Domaine | Contraintes | Clé (PK/FK) | Nullable | Exemple |
|---|---|---|---|---|---|---|---|
| id_document | Identifiant unique du document. | INT | Entier |  | PK | Oui |  |
| nom_fichier | Nom du fichier. | VARCHAR(50) | Texte libre (max 50 caractères) | NOT NULL |  | Non | schema_mcd.png |
| type_fichier | Type/MIME ou extension. | VARCHAR(50) | Texte libre (max 50 caractères) |  |  | Oui |  |
| date_upload | Date et heure de téléversement. | DATETIME | Date & heure |  |  | Oui |  |
| chemin_fichier | Chemin/URI de stockage. | VARCHAR(50) | Texte libre (max 50 caractères) | NOT NULL |  | Non | /files/2026/01/schema_mcd.png |
| id_tache | Tâche rattachée (optionnel). | INT | Entier |  | FK → TACHE(id_tache) | Oui |  |
| id_projet | Projet rattaché (optionnel). | INT | Entier |  | FK → PROJET(id_projet) | Oui |  |
| id_utilisateur | Utilisateur auteur du téléversement. | INT | Entier | NOT NULL | FK → UTILISATEUR(id_utilisateur) | Non |  |
| taille_octets | Taille du fichier en octets (optionnel). | BIGINT | Entier (grande capacité) |  |  | Oui |  |
| (Règle table) | Un document doit être rattaché à un projet OU à une tâche (pas les deux). |  |  | CHECK ((id_tache IS NULL) <> (id_projet IS NULL)) |  |  | id_tache=101, id_projet=NULL |

## Entité `NOTIFICATION`

**Description :** Notification envoyée à un utilisateur (assignation, changement de statut, etc.).

**Règles & contraintes clés :**
- Clé primaire : `id_notification`.
- Références (FK) : `id_utilisateur` → UTILISATEUR(id_utilisateur).
- Règle : statut de lecture dans {LU, NON_LU}.

| Attribut | Description | Type | Domaine | Contraintes | Clé (PK/FK) | Nullable | Exemple |
|---|---|---|---|---|---|---|---|
| id_notification | Identifiant unique de notification. | INT | Entier |  | PK | Oui |  |
| message | Message affiché à l’utilisateur. | VARCHAR(400) | Texte libre (max 400 caractères) | NOT NULL |  | Non |  |
| type_notification | Type de notification. | VARCHAR(50) | Texte libre (max 50 caractères) | NOT NULL |  | Non |  |
| statut | Statut de lecture. | VARCHAR(50) | Enum: LU \| NON_LU | NOT NULL; CHECK IN (LU, NON_LU) |  | Non | NON_LU |
| date_heure | Date et heure d’émission. | DATETIME | Date & heure | NOT NULL |  | Non |  |
| id_utilisateur | Destinataire. | INT | Entier | NOT NULL | FK → UTILISATEUR(id_utilisateur) | Non |  |
