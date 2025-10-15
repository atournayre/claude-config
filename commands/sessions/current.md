---
model: claude-3-5-haiku-20241022
allowed-tools: Read, Bash(date:*)
description: Afficher le statut et les détails de la session actuelle
---

# Statut de la Session Actuelle

Afficher le statut de la session actuelle en vérifiant l'existence d'une session active et en affichant les informations pertinentes.

## Instructions

- **IMPORTANT : Vérifier d'abord si `.claude/sessions/.current-session` existe**
- **IMPORTANT : Garder une sortie concise et informative**
- **IMPORTANT : Calculer la durée de la session avec précision**

## Processus

1. Vérifier si `.claude/sessions/.current-session` existe
2. Si aucune session active :
   - Informer l'utilisateur qu'il n'y a pas de session active
   - Suggérer d'en démarrer une avec `session:start [nom]`
3. Si une session active existe :
   - Afficher le nom et le fichier de la session
   - Calculer et afficher la durée depuis le début
   - Afficher les dernières mises à jour du fichier de session
   - Afficher les objectifs/tâches actuels si disponibles
   - Rappeler les commandes de session disponibles

## Informations à Afficher

- Nom du fichier et titre de la session
- Heure de début et durée
- Entrées de progression récentes
- Objectifs ou buts actuels
- Prochaines actions disponibles

## Rappel des Commandes Disponibles

- Mettre à jour : `session:update [notes]`
- Terminer : `session:end`
- Lister toutes : `session:list`

Garder la sortie propre et concentrée sur les informations exploitables.