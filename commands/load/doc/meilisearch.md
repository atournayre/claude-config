---
model: claude-sonnet-4-5-20250929
description: Charge la documentation Meilisearch depuis leur site web dans des fichiers markdown locaux que nos agents peuvent utiliser comme contexte.
allowed-tools: Task, WebFetch, Write, Edit, Bash (ls*), mcp_firecrawl-mcp_firecrawl_scrape
---

# Charger la Documentation Meilisearch

Charge la documentation Meilisearch depuis leur site web dans des fichiers markdown locaux que nos agents peuvent utiliser comme contexte.

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

## Variables

README_PATH: docs/meilisearch/README.md
DELETE_OLD_MEILISEARCH_DOCS_AFTER_HOURS: 24

## Flux de Travail

1. Lire le fichier `README_PATH`

2. Vérifier si des fichiers docs/meilisearch/<nom-de-fichier>.md existent déjà

1. S'ils existent, vérifier s'ils ont été créés dans les dernières `DELETE_OLD_MEILISEARCH_DOCS_AFTER_HOURS` heures

2. Si c'est le cas, les ignorer - noter qu'ils ont été ignorés

3. Sinon, les supprimer et noter qu'ils ont été supprimés

3. Pour chaque URL dans `README_PATH` qui n'a pas été ignorée, utiliser l'outil Task en parallèle et suivre le `scrape_loop_prompt` comme prompt exact pour chaque Task

<scrape_loop_prompt>

Utiliser l'agent @meilisearch-docs-scraper en lui passant l'URL comme prompt

</scrape_loop_prompt>

4. Une fois toutes les tâches terminées, répondre selon le Format de Rapport

## Format de Rapport

```yaml
task: "Chargement de la documentation Meilisearch"
status: "terminé"
details:
  total_urls: "[nombre total d'URLs dans README.md]"
  processed: "[nombre d'URLs traitées]"
  skipped: "[nombre d'URLs ignorées car récentes]"
  deleted: "[nombre de fichiers supprimés car anciens]"
  created: "[nombre de nouveaux fichiers créés]"
  errors: "[nombre d'erreurs]"
files:
  created:
    - path: "[chemin du fichier]"
      source: "[URL source]"
      size: "[taille en KB]"
  skipped:
    - path: "[chemin du fichier]"
      reason: "[raison - ex: 'créé il y a 2 heures']"
  deleted:
    - path: "[chemin du fichier]"
      reason: "[raison - ex: 'créé il y a 30 heures']"
  errors:
    - url: "[URL en erreur]"
      error: "[message d'erreur]"
statistics:
  documentation_files: "[nombre total de fichiers .md dans docs/meilisearch/]"
  total_size: "[taille totale en MB]"
  coverage: "[pourcentage de couverture des URLs]"
notes:
  - "Documentation Meilisearch disponible dans docs/meilisearch/ pour les agents"
  - "Fichiers individuels pour éviter les conflits"
  - "[autres notes importantes]"

---
✅ Terminé : [timestamp Europe/Paris avec CEST/CET]
⏱️ Durée : [durée formatée]
```
