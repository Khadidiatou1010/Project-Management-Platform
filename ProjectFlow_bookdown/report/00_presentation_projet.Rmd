# 🎓 Le projet en soi

## 🎯 Objectif général

Les étudiants doivent concevoir, modéliser et documenter une base de données complète permettant de gérer :

- les projets,
- les tâches,
- les activités,
- les équipes et utilisateurs,
- l’avancement,
- les commentaires / échanges,
- les documents associés.

Le travail est **100% modélisation** : aucune implémentation logicielle n’est requise.

## 🧩 Travail attendu

Les étudiants doivent fournir :

- Étude du besoin (analyse fonctionnelle)
- MCD (Modèle Conceptuel de Données)
- MLD (Modèle Logique de Données)
- MPD (Modèle Physique de Données)
- Dictionnaire des données
- Contraintes d’intégrité
- Scénarios utilisateurs (Use cases)
- Propositions d’amélioration / extension
- 10 requêtes SQL simples, 10 moyennes, 10 avancées (à rédiger seulement)
- Quelques écrans par exe avec (Figma)

## 📘 Contexte du projet

Une institution publique et plusieurs ONG souhaitent collaborer pour mettre en place une **plateforme nationale de gestion de projets**.

Cette plateforme doit permettre :

- de suivre les projets (objectifs, budget, durée, statut)
- de gérer les tâches, assignées à un ou plusieurs membres
- de suivre les activités liées aux tâches
- de gérer des équipes
- de permettre aux utilisateurs de commenter / suivre l’avancement
- d’archiver les documents liés aux projets

La plateforme doit être **collaborative**, **sécurisée**, et permettre un **historique des actions**.

## 🏗️ Fonctionnalités détaillées à modéliser

Les étudiants doivent impérativement modéliser les concepts suivants :

### Gestion des utilisateurs / équipes

Chaque utilisateur doit avoir :

- nom
- prénom
- email
- téléphone
- rôle : Admin, Chef de projet, Membre
- date d’inscription

Les utilisateurs créent ou rejoignent des équipes.  
Une équipe peut gérer plusieurs projets.

### 🔹 Gestion des projets

Un projet doit contenir :

- titre
- description
- budget alloué
- date de début
- date de fin prévue
- statut (En planification, En cours, En pause, Terminé)
- priorité

Chaque projet appartient à une seule équipe mais peut avoir plusieurs utilisateurs associés (chef(s), membres).

### 🔹 Gestion des tâches

Une tâche est liée à un projet, avec :

- titre
- description
- date de début prévue
- date de fin prévue
- pourcentage d'avancement
- statut (À faire, En cours, Terminé, Bloqué)
- priorité (Haute, Moyenne, Basse)

Une tâche peut être assignée :

- à un ou plusieurs utilisateurs (participation collaborative)
- ou à personne (backlog)

### 🔹 Gestion des activités (logs)

Chaque tâche génère plusieurs activités :

- commentaire / action
- date / heure
- utilisateur ayant réalisé l’action
- type : (Commentaire, Mise à jour du statut, Ajout de document, Réassignation, etc.)

### 🔹 Gestion des documents

Les projets et tâches doivent permettre d'attacher des documents :

- nom du fichier
- type
- taille
- date d’upload
- utilisateur ayant déposé le fichier
- lié à un projet ou à une tâche

### 🔹 Notifications (optionnel mais recommandé)

Une notification peut être générée lors :

- d’une nouvelle tâche
- d’un changement de statut
- d’un nouveau commentaire
- d’un upload de document

Contenu minimal :

- message
- type
- statut (Lu / Non lu)
- utilisateur concerné
- date/heure

## 📑 Livrables demandés

Les étudiants doivent rendre un dossier contenant :

### ✏️ Analyse fonctionnelle

- résumé du contexte
- description des besoins
- liste des acteurs
- liste des fonctionnalités

### 📊 Modélisation complète

- Diagramme de contexte
- MCD complet (avec cardinalités)
- MLD (tables, colonnes, clés)
- MPD (tables optimisées, types SQL suggérés)

### 📘 Dictionnaire des données

Pour chaque entité :

- description
- attributs
- type
- contrainte
- domaine
- clé primaire / clé étrangère

### 🧪 Jeux de requêtes à rédiger

Les étudiants doivent proposer :

- ✔️ 10 requêtes simples (ex : lister les projets, afficher les tâches d’un projet…)
- ✔️ 10 requêtes intermédiaires (ex : nombre de tâches par statut…)
- ✔️ 10 requêtes avancées (ex : liste des projets en retard, top utilisateurs actifs…)

### 🚀 Propositions d'amélioration du modèle

Idées possibles en terme de perspectives après ce projet :

- Kanban digital
- Rapport PDF automatique
- Système de validation des projets
- Évaluation des membres
- Gestion des risques
- Intégration IA (suggestion de planning, prévision retards…)
