---
model: claude-sonnet-4-5-20250929
allowed-tools: Bash, WebFetch, WebSearch
argument-hint: [url|doc-name]
description: Lit la documentation technique - RTFM (Read The Fucking Manual)
---

# Documentation Reader - RTFM

## Purpose
Force Claude à lire et comprendre la documentation technique fournie, que ce soit via une URL directe ou en recherchant une documentation par nom.

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
