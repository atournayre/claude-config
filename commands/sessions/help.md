---
model: claude-3-5-haiku-20241022
description: Afficher l'aide pour les commandes de gestion de session
---

# Aide pour la Gestion de Session

Le système de session aide à documenter le travail de développement pour référence future.

## Commandes Disponibles :

- `session:start [nom]` - Démarrer une nouvelle session avec nom optionnel
- `session:update [notes]` - Ajouter des notes à la session actuelle
- `session:end` - Terminer la session avec un résumé complet
- `session:list` - Lister tous les fichiers de session
- `session:current` - Afficher le statut de la session actuelle
- `session:help` - Afficher cette aide

## Comment Ça Fonctionne :

1. Les sessions sont des fichiers markdown stockés dans `.claude/sessions/`
2. Les fichiers utilisent le format `AAAA-MM-JJ-HHMM-nom.md`
3. Une seule session peut être active à la fois
4. Les sessions suivent la progression, les problèmes, les solutions et les apprentissages

## Meilleures Pratiques :

- Démarrer une session lors du début d'un travail significatif
- Mettre à jour régulièrement avec les changements ou découvertes importantes
- Terminer avec un résumé complet pour référence future
- Revoir les sessions passées avant de commencer un travail similaire

## Exemple de Flux de Travail :

```
session:start refactorisation-auth
session:update Ajout de la restriction OAuth Google
session:update Correction du problème de Promise des params Next.js 15
session:end
```

Le système de gestion de session aide à maintenir la continuité entre les sessions de développement et sert de documentation précieuse pour les futurs développeurs.