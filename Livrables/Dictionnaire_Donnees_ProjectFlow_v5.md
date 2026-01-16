# Dictionnaire des données — ProjectFlow (v5)

> Conforme au format demandé : **description** + tableau (Attribut, Type, Domaine, Contrainte, Clé primaire/étrangère).

> Aligné sur le **MPD recommandé**.


## Entité `UTILISATEUR`

**Description :** Personne utilisant la plateforme (admin, chef de projet ou membre).

| Attribut | Description | Type | Domaine | Contrainte | Clé primaire / clé étrangère |
|---|---|---|---|---|---|
| id_utilisateur | Identifiant unique de l’utilisateur. | INT | Entier | PRIMARY KEY, AUTO_INCREMENT | PK |
| nom_utilisateur | Nom de famille. | VARCHAR(50) | Texte (≤ 50) | NOT NULL |  |
| prenom_utilisateur | Prénom. | VARCHAR(50) | Texte (≤ 50) | NOT NULL |  |
| email_utilisateur | Email (unique). | VARCHAR(255) | Email (≤ 255) | NOT NULL, UNIQUE |  |
| telephone_utilisateur | Téléphone. | VARCHAR(50) | Texte (≤ 50) | NULL autorisé |  |
| role_utilisateur | Rôle applicatif. | VARCHAR(20) | Enum: ADMIN \ | CHEF_PROJET \ | MEMBRE |
| date_inscription | Date d’inscription. | DATE | Date | NOT NULL |  |

## Entité `EQUIPE`

**Description :** Regroupe des utilisateurs dans une équipe de travail.

| Attribut | Description | Type | Domaine | Contrainte | Clé primaire / clé étrangère |
|---|---|---|---|---|---|
| id_equipe | Identifiant unique de l’équipe. | INT | Entier | PRIMARY KEY, AUTO_INCREMENT | PK |
| nom_equipe | Nom de l’équipe. | VARCHAR(80) | Texte (≤ 80) | NOT NULL, UNIQUE |  |
| description | Description de l’équipe. | VARCHAR(255) | Texte (≤ 255) | NULL autorisé |  |
| date_creation | Date de création. | DATE | Date | NOT NULL |  |

## Table d’association `APPARTENIR`

**Description :** Association **N–N** entre utilisateurs et équipes, avec date d’affectation.

| Attribut | Description | Type | Domaine | Contrainte | Clé primaire / clé étrangère |
|---|---|---|---|---|---|
| id_utilisateur | Utilisateur membre de l’équipe. | INT | Entier | NOT NULL | PK, FK → UTILISATEUR(id_utilisateur) |
| id_equipe | Équipe concernée. | INT | Entier | NOT NULL | PK, FK → EQUIPE(id_equipe) |
| date_affectation | Date d’affectation. | DATE | Date | NOT NULL |  |

## Entité `PROJET`

**Description :** Projet porté par une équipe (planning, budget, statut, priorité).

| Attribut | Description | Type | Domaine | Contrainte | Clé primaire / clé étrangère |
|---|---|---|---|---|---|
| id_projet | Identifiant unique du projet. | INT | Entier | PRIMARY KEY, AUTO_INCREMENT | PK |
| titre_projet | Titre du projet. | VARCHAR(120) | Texte (≤ 120) | NOT NULL |  |
| description_projet | Description détaillée. | VARCHAR(500) | Texte (≤ 500) | NOT NULL |  |
| date_debut | Date de démarrage. | DATE | Date | NOT NULL |  |
| date_fin_prevue | Date de fin prévue. | DATE | Date | NOT NULL, CHECK (>= date_debut) |  |
| budget_alloue | Budget alloué. | DECIMAL(15,2) | Montant | NOT NULL, DEFAULT 0, CHECK (>=0) |  |
| statut | Statut du projet. | VARCHAR(20) | Enum autorisée | NOT NULL, CHECK |  |
| priorite | Priorité du projet. | VARCHAR(10) | Enum autorisée | NOT NULL, CHECK |  |
| id_equipe | Équipe porteuse. | INT | Entier | NOT NULL | FK → EQUIPE(id_equipe) |

## Table d’association `PROJET_MEMBRE`

**Description :** Association entre un projet et ses membres, avec rôle dans le projet et date d’affectation.

| Attribut | Description | Type | Domaine | Contrainte | Clé primaire / clé étrangère |
|---|---|---|---|---|---|
| id_projet | Projet concerné. | INT | Entier | NOT NULL | PK, FK → PROJET(id_projet) |
| id_utilisateur | Utilisateur membre du projet. | INT | Entier | NOT NULL | PK, FK → UTILISATEUR(id_utilisateur) |
| role_projet | Rôle dans le projet. | VARCHAR(20) | Enum: CHEF_PROJET \ | MEMBRE | NOT NULL, CHECK |
| date_affectation | Date d’affectation. | DATE | Date | NOT NULL |  |

## Entité `TACHE`

**Description :** Tâche rattachée à un projet (statut, priorité, avancement).

| Attribut | Description | Type | Domaine | Contrainte | Clé primaire / clé étrangère |
|---|---|---|---|---|---|
| id_tache | Identifiant unique de la tâche. | INT | Entier | PRIMARY KEY, AUTO_INCREMENT | PK |
| titre_tache | Titre de la tâche. | VARCHAR(120) | Texte (≤ 120) | NOT NULL |  |
| description_tache | Description de la tâche. | VARCHAR(500) | Texte (≤ 500) | NULL autorisé |  |
| date_debut_prevue | Début prévu. | DATE | Date | NULL autorisé |  |
| date_fin_prevue | Fin prévue. | DATE | Date | NULL autorisé, CHECK (si début renseigné alors fin ≥ début) |  |
| pourcentage_avancement | Avancement (%) | INT | Entier | NOT NULL, DEFAULT 0, CHECK (0..100) |  |
| statut | Statut de la tâche. | VARCHAR(20) | Enum autorisée | NOT NULL, CHECK |  |
| priorite | Priorité de la tâche. | VARCHAR(10) | Enum autorisée | NOT NULL, CHECK |  |
| id_projet | Projet parent. | INT | Entier | NOT NULL | FK → PROJET(id_projet) |

## Table d’association `ASSIGNER`

**Description :** Association **N–N** entre utilisateurs et tâches, avec date d’affectation et rôle dans la tâche.

| Attribut | Description | Type | Domaine | Contrainte | Clé primaire / clé étrangère |
|---|---|---|---|---|---|
| id_utilisateur | Utilisateur assigné. | INT | Entier | NOT NULL | PK, FK → UTILISATEUR(id_utilisateur) |
| id_tache | Tâche concernée. | INT | Entier | NOT NULL | PK, FK → TACHE(id_tache) |
| date_affectation | Date d’assignation. | DATE | Date | NOT NULL |  |
| role_tache | Rôle dans la tâche. | VARCHAR(50) | Texte (≤ 50) | NOT NULL |  |

## Entité `ACTIVITE`

**Description :** Journal (logs) des actions réalisées sur les tâches.

| Attribut | Description | Type | Domaine | Contrainte | Clé primaire / clé étrangère |
|---|---|---|---|---|---|
| id_activite | Identifiant unique de l’activité. | INT | Entier | PRIMARY KEY, AUTO_INCREMENT | PK |
| contenu | Commentaire / action (texte). | VARCHAR(300) | Texte (≤ 300) | NULL autorisé |  |
| date_heure | Date et heure. | DATETIME | Date & heure | NOT NULL |  |
| type_activite | Type d’action. | VARCHAR(30) | Enum autorisée | NOT NULL, CHECK |  |
| id_utilisateur | Auteur. | INT | Entier | NOT NULL | FK → UTILISATEUR(id_utilisateur) |
| id_tache | Tâche concernée. | INT | Entier | NOT NULL | FK → TACHE(id_tache) |

## Entité `DOCUMENT`

**Description :** Document téléversé, rattaché à **une tâche OU un projet** (règle XOR), et à un utilisateur auteur.

| Attribut | Description | Type | Domaine | Contrainte | Clé primaire / clé étrangère |
|---|---|---|---|---|---|
| id_document | Identifiant unique du document. | INT | Entier | PRIMARY KEY, AUTO_INCREMENT | PK |
| nom_fichier | Nom du fichier. | VARCHAR(255) | Texte (≤ 255) | NOT NULL |  |
| type_fichier | Type/extension. | VARCHAR(80) | Texte (≤ 80) | NULL autorisé |  |
| taille_octets | Taille du fichier en octets. | BIGINT | Entier | NULL autorisé |  |
| date_upload | Date et heure d’upload. | DATETIME | Date & heure | NOT NULL |  |
| chemin_fichier | Chemin/URI de stockage. | VARCHAR(500) | Texte (≤ 500) | NOT NULL |  |
| id_tache | Tâche rattachée (optionnel). | INT | Entier | NULL autorisé | FK → TACHE(id_tache) |
| id_projet | Projet rattaché (optionnel). | INT | Entier | NULL autorisé | FK → PROJET(id_projet) |
| id_utilisateur | Auteur du téléversement. | INT | Entier | NOT NULL | FK → UTILISATEUR(id_utilisateur) |

## Entité `NOTIFICATION`

**Description :** Notification envoyée à un utilisateur (assignation, changement de statut, etc.).

| Attribut | Description | Type | Domaine | Contrainte | Clé primaire / clé étrangère |
|---|---|---|---|---|---|
| id_notification | Identifiant unique de la notification. | INT | Entier | PRIMARY KEY, AUTO_INCREMENT | PK |
| message | Message affiché. | VARCHAR(400) | Texte (≤ 400) | NOT NULL |  |
| type_notification | Type de notification. | VARCHAR(50) | Texte (≤ 50) | NOT NULL |  |
| statut | Statut de lecture. | VARCHAR(10) | Enum: LU \ | NON_LU | NOT NULL, CHECK |
| date_heure | Date et heure d’émission. | DATETIME | Date & heure | NOT NULL |  |
| id_utilisateur | Destinataire. | INT | Entier | NOT NULL | FK → UTILISATEUR(id_utilisateur) |
