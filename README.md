# 🚀 ProjectFlow : Plateforme Nationale de Gestion de Projets

## 📌 Présentation du Projet
Ce projet consiste en la conception et la modélisation complète d'une base de données collaborative destinée à une institution publique et plusieurs ONG. L'objectif est de centraliser la gestion des projets nationaux, le suivi des tâches, les activités des équipes et l'archivage sécurisé des documents associés.

---

## 📂 Structure des Livrables

Le dépôt est organisé par étapes clés de conception, aboutissant à un document global consolidé.

### 📁 00_Etude_du_besoin
* **Analyse fonctionnelle :** Résumé du contexte et description précise des besoins métiers.
* **Acteurs & Fonctionnalités :** Identification des rôles (Admin, Chef de projet, Membre) et cartographie des services offerts par la plateforme.

### 📁 01_Dictionnaire et contraintes
* **Dictionnaire des données :** Définition exhaustive de chaque entité, attribut, type et domaine.
* **Contraintes d'intégrité :** Documentation des règles métier garantissant la cohérence absolue des données (ex: règle d'exclusivité projet/tâche pour les documents).

### 📁 02_Modélisation
* **MCD :** Diagramme Conceptuel avec cardinalités précises.
* **MLD :** Passage au modèle logique avec définition des tables et des clés.
* **MPD :** Modèle physique optimisé avec types SQL suggérés pour l'implémentation.

### 📁 03_Ecrans et améliorations
* **Maquettes UI :** Visualisation de l'interface utilisateur, incluant tableaux de bord et gestion détaillée des indicateurs.
* **Perspectives :** Propositions d'évolution vers le Kanban digital, l'intégration d'IA pour la prévision des retards et le reporting automatisé.

### 📁 04_Requêtes
* **Exploitation SQL :** 30 requêtes prêtes à l'emploi classées par niveau :
    * **Simples :** Listes et filtres de base.
    * **Intermédiaires :** Agrégations et statistiques.
    * **Avancées :** Détection de retards et classement des utilisateurs les plus actifs.

---

## 🏆 Le Document Global
Le fichier situé dans le dossier **Global** réunit l'intégralité du travail dans un format cohérent et paginé, idéal pour une présentation finale ou une consultation rapide.

---

## 🛠️ Technologies & Concepts Clés
* **Modélisation :** Entité-Association, Normalisation et Intégrité Référentielle.
* **SGBDR :** SQL standard.
* **Outils :** RStudio (RMarkdown) pour la documentation technique et Figma pour le design.

---

> **Note :** Ce travail est 100% axé sur la modélisation et la documentation technique conformément au cahier des charges de l'ENSAE Dakar pour l'année 2025-2026.