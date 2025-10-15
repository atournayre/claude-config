---
model: claude-3-5-haiku-20241022
allowed-tools: Bash(git:*)
description: Comprendre l'état actuel du dépôt git
---

# Statut Git

Lire les `Fichiers` et exécuter les `Commandes` puis résumer l'état actuel du dépôt git.

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

## Commandes

- Statut actuel : !`git status`
- Diff actuelle : !`git diff HEAD origin/main`
- Branche actuelle : !`git branch --show-current`

## Fichiers
@README.md

---
✅ Terminé : [timestamp ISO 8601]
⏱️ Durée : [durée formatée]