---
model: claude-3-5-haiku-20241022
description: Afficher l'aide pour les commandes de gestion de session
---

# Aide pour la Gestion de Session

Le système de session aide à documenter le travail de développement pour référence future.

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

---
✅ Terminé : [timestamp Europe/Paris avec CEST/CET]
⏱️ Durée : [durée formatée]