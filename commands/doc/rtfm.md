---
model: claude-sonnet-4-5-20250929
allowed-tools: Bash, WebFetch, WebSearch
argument-hint: [url|doc-name]
description: Lit la documentation technique - RTFM (Read The Fucking Manual)
---

# Documentation Reader - RTFM

## Purpose
Force Claude à lire et comprendre la documentation technique fournie, que ce soit via une URL directe ou en recherchant une documentation par nom.

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
DOC_SOURCE: L'URL ou le nom de la documentation à lire

## Instructions
- Si une URL est fournie directement, utilise WebFetch pour la lire
- Si un nom de documentation est fourni, utilise WebSearch pour la trouver puis WebFetch pour la lire
- Force Claude à lire complètement la documentation avant de répondre
- Fournis un résumé structuré des points clés

## Relevant Files
- Documentation externe via WebFetch/WebSearch

## Codebase Structure
Cette commande ne modifie pas le codebase, elle lit uniquement la documentation externe.

## Workflow

### Étape 0: Initialisation du Timing (OBLIGATOIRE - PREMIÈRE ACTION)
```
🕐 Démarrage: [timestamp ISO 8601]
```
- Cette étape DOIT être la toute première action
- Enregistrer le timestamp pour calcul ultérieur

- Si DOC_SOURCE commence par http/https, utilise directement WebFetch
- Sinon, recherche la documentation avec WebSearch puis lis le résultat avec WebFetch
- Parse et structure l'information de la documentation
- Fournis un résumé concis et actionnable

## Expertise
- Lecture et analyse de documentation technique
- Extraction d'informations clés
- Synthèse et structuration de contenu

## Template
```
# Documentation: [NOM]

## Résumé
[Résumé concis en 2-3 phrases]

## Points clés
- Point important 1
- Point important 2
- Point important 3

## Exemples pratiques
[Exemples d'usage si disponibles]

## Liens utiles
[Références additionnelles si pertinentes]
```

## Examples
- `/rtfm https://docs.anthropic.com/claude/reference` - Lit directement la documentation Claude
- `/rtfm symfony doctrine` - Recherche et lit la documentation Symfony Doctrine
- `/rtfm php 8.3 new features` - Recherche les nouvelles fonctionnalités PHP 8.3

## Report
Résumé structuré de la documentation lue avec points clés et exemples pratiques.

---
✅ Terminé : [timestamp ISO 8601]
⏱️ Durée : [durée formatée]
