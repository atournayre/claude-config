---
model: claude-sonnet-4-5-20250929
allowed-tools: Read, Edit, Bash(git:*), Bash(date:*)
description: Ajouter une entrée de mise à jour à la session actuelle
---

# Mettre à Jour la Session Actuelle

Ajouter une mise à jour de progression à la session de développement active avec horodatage et contexte pertinent.

## Timing

### Début d'Exécution
Afficher immédiatement au lancement :
- 🕐 **Démarrage** : [Date et heure au fuseau horaire Europe/Paris]
- Format : `YYYY-MM-DD HH:MM:SS CEST/CET`

### Fin d'Exécution
Afficher en fin de rapport :
- ✅ **Terminé** : [Date et heure au fuseau horaire Europe/Paris]
- ⏱️ **Durée** : [Temps écoulé au format lisible]
- Formats durée :
  - Moins d'1 minute : `XXs` (ex: 45s)
  - Moins d'1 heure : `XXm XXs` (ex: 2m 30s)
  - Plus d'1 heure : `XXh XXm XXs` (ex: 1h 15m 30s)

### Instructions
- Le timestamp de début DOIT être la première sortie de la commande
- Le timestamp de fin et la durée DOIVENT être inclus dans le rapport final
- Calculer la durée en soustrayant le timestamp de début du timestamp de fin
- Utiliser le fuseau horaire Europe/Paris (CEST en été, CET en hiver)
- Arrondir les secondes (pas de millisecondes)

## Instructions

- **IMPORTANT : Vérifier si une session active existe dans `.claude/sessions/.current-session`**
- **IMPORTANT : Ajouter la mise à jour avec l'horodatage actuel**
- **IMPORTANT : Inclure automatiquement le résumé du statut git**

## Processus

1. Vérifier si la session actuelle existe
2. Si aucune session active :
   - Informer l'utilisateur qu'il n'y a pas de session active
   - Suggérer d'en démarrer une avec `session:start [nom]`
3. Si la session existe, ajouter la mise à jour avec :
   - Horodatage actuel
   - Résumé de la mise à jour (depuis les arguments)
   - Résumé du statut git (fichiers modifiés, staged, commits)
   - Progression de la liste des todos (si applicable)
   - Problèmes rencontrés et solutions
   - Résumé des changements de code

## Format de l'Entrée de Mise à Jour

```markdown
### Mise à jour - [HORODATAGE]

**Résumé :** [Détails de la mise à jour depuis les arguments]

**Changements Git :**
- Fichiers modifiés : [liste]
- Changements staged : [résumé]
- Commits récents : [si applicable]

**Progression :**
- [Accomplissements clés]
- [Problèmes résolus]
- [Prochaines étapes]

**Détails :**
[Contexte supplémentaire ou notes techniques]
```

## Notes de Mise à Jour

$ARGUMENTS

L'objectif est de créer des enregistrements complets mais concis pour référence future.

---
✅ Terminé : [timestamp Europe/Paris avec CEST/CET]
⏱️ Durée : [durée formatée]