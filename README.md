SYSTEME DE GESTION MOBILE MONEY - BASE DE DONNEES SQL

Ce projet modélise le système d'information simplifié d'un service de transfert d'argent de type Mobile Money, adapté aux cas d'usage locaux en Afrique francophone, notamment pour des agences basées à Dakar et Thiès.


OBJECTIF DU PROJET

L'objectif est de démontrer la maîtrise opérationnelle du langage SQL, à travers le Langage de Définition de Données (LDD) et le Langage de Manipulation de Données (LMD), en concevant une base de données relationnelle structurée et en rédigeant des requêtes d'analyse financière.


ARCHITECTURE DES DONNEES

Le schéma relationnel est structuré autour de quatre entités principales :
- Region : Référentiel des zones géographiques d'opération.
- Agent_Local : Opérateurs sur le terrain, rattachés à une région spécifique.
- Client : Utilisateurs finaux du système, qu'ils soient émetteurs ou récepteurs.
- Transaction_Transfert : Table pivot enregistrant les flux financiers entre clients par l'intermédiaire d'un agent.


REQUETES D'ANALYSE

Le script SQL intègre des requêtes complexes démontrant l'utilisation de :
- Jointures multiples (JOIN) pour reconstituer les parcours de transaction de bout en bout.
- Fonctions d'agrégation (SUM, GROUP BY) pour calculer les indicateurs de volume financier par région.
- Opérateurs ensemblistes pour identifier des profils de clients spécifiques, tels que ceux ayant exclusivement émis des transferts.


COMMENT TESTER CE PROJET

1. Clonez ce dépôt sur votre machine locale.
2. Importez le fichier projet_transfert.sql dans votre Système de Gestion de Base de Données (ex: phpMyAdmin, DBeaver).
3. Le script gère de manière autonome la réinitialisation des tables via la commande de suppression conditionnelle, la création de la structure relationnelle et l'insertion d'un jeu de données de démonstration.
