---
model: claude-sonnet-4-5-20250929
description: Build the codebase based on the plan
argument-hint: [path-to-plan]
allowed-tools: Read, Write, Bash
---

# Build
Follow the `Workflow` to implement the `PATH_TO_PLAN` then `Report` the completed work.

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
PATH_TO_PLAN: $ARGUMENTS

## Workflow

### Étape 0: Initialisation du Timing (OBLIGATOIRE - PREMIÈRE ACTION)
```
🕐 Démarrage: [timestamp ISO 8601]
```
- Cette étape DOIT être la toute première action
- Enregistrer le timestamp pour calcul ultérieur

- If no `PATH_TO_PLAN` is provided, STOP immediately and ask the user to provide it.
- Read the plan at `PATH_TO_PLAN`. Think hard about the plan and implement it into the codebase.

## Quality Assurance
- Run all quality checks (linters, static analysis, tests)
- Fix ALL errors and warnings until all checks pass
- Ensure the code is error-free before considering the task complete
- DO NOT proceed to reporting until all quality checks are green

# Report
- Confirm all quality checks have passed
- Summarize the work you've just done in a concise bullet point list.
- Report the files and total lines changed with `git diff —-stat`

---
✅ Terminé : [timestamp ISO 8601]
⏱️ Durée : [durée formatée]
