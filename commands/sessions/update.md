---
allowed-tools: Read, Edit, Bash(git:*), Bash(date:*)
description: Ajouter une entrée de mise à jour à la session actuelle
---

# Mettre à Jour la Session Actuelle

Ajouter une mise à jour de progression à la session de développement active avec horodatage et contexte pertinent.

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