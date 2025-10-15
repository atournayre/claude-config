---
model: claude-sonnet-4-5-20250929
allowed-tools: Bash, Read
description: Charger le contexte pour une nouvelle session d'agent en analysant la structure du code, la documentation et le README
---

# Contexte par défaut

## Purpose

Définir le contexte pour une nouvelle session d'agent en analysant la structure du code, la documentation et le README.

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

## Workflow
- Exécutes !`git ls-files` pour lister les fichiers du projet
- Lis @docs/README.md

## Rapport

- Fournir un résumé de votre compréhension du projet

---
✅ Terminé : [timestamp ISO 8601]
⏱️ Durée : [durée formatée]
