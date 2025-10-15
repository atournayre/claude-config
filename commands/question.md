---
model: claude-sonnet-4-5-20250929
allowed-tools: Bash(git ls-files:*), Read
description: Répondre aux questions sur la structure du projet et la documentation sans coder
---

# Question

Répondre à la question de l'utilisateur en analysant la structure du projet et la documentation. Cette invite est conçue pour fournir des informations et répondre aux questions sans apporter de modifications au code.

## Timing

### Début d'Exécution
Afficher immédiatement au lancement :
- 🕐 **Démarrage** : [Date et heure au format ISO 8601]
- Format : `YYYY-MM-DD HH:MM:SS`

### Fin d'Exécution
Afficher en fin de rapport :
- ✅ **Terminé** : [Date et heure au format ISO 8601]
- ⏱️ **Durée** : [Temps écoulé au format lisible]
- Formats durée :
  - Moins d'1 minute : `XXs` (ex: 45s)
  - Moins d'1 heure : `XXm XXs` (ex: 2m 30s)
  - Plus d'1 heure : `XXh XXm XXs` (ex: 1h 15m 30s)

### Instructions
- Le timestamp de début DOIT être la première sortie de la commande
- Le timestamp de fin et la durée DOIVENT être inclus dans le rapport final
- Calculer la durée en soustrayant le timestamp de début du timestamp de fin
- Arrondir les secondes (pas de millisecondes)

## Variables

$ARGUMENTS

## Instructions

- **IMPORTANT : Il s'agit uniquement d'une tâche de réponse à des questions - NE PAS écrire, éditer ou créer de fichiers**
- **IMPORTANT : Se concentrer sur la compréhension et l'explication du code existant et de la structure du projet**
- **IMPORTANT : Fournir des réponses claires et informatives basées sur l'analyse du projet**
- **IMPORTANT : Si la question nécessite des modifications de code, expliquer ce qui devrait être fait conceptuellement sans implémenter**

## Workflow

- Examiner la structure du projet depuis !`git ls-files`
- Comprendre l'objectif du projet depuis le @docs/README.md
- Connecter la question aux parties pertinentes du projet
- Fournir des réponses complètes basées sur l'analyse

## Format de réponse

- Réponse directe à la question
- Preuves à l'appui de la structure du projet
- Références à la documentation pertinente
- Explications conceptuelles le cas échéant

---
✅ Terminé : [timestamp ISO 8601]
⏱️ Durée : [durée formatée]
