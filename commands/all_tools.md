# Lister tous les outils

Lister tous les outils disponibles détaillés dans votre prompt système. Les afficher sous forme de puces. Les afficher au format de signature de fonction TypeScript et ajouter le but de l'outil en suffixe. Double saut de ligne entre chaque outil pour la lisibilité.

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

---
✅ Terminé : [timestamp ISO 8601]
⏱️ Durée : [durée formatée]
