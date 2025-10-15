---
model: claude-haiku-4-5-20251001
description: Stop the running analytics dashboard server
---

# Stop Analytics Dashboard

Arrête proprement le serveur analytics dashboard s'il est en cours d'exécution.

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

## Commandes

- Arrêter le serveur : !`(lsof -t -i:3333 > /dev/null 2>&1 && kill $(lsof -t -i:3333) && echo "✅ Serveur analytics arrêté sur le port 3333") || echo "ℹ️ Aucun serveur analytics en cours d'exécution"`

## Description

Cette commande :
1. Vérifie si un processus écoute sur le port 3333
2. Si oui, termine le processus proprement
3. Affiche un message de confirmation
4. Si non, informe qu'aucun serveur n'est actif

## Utilisation

Utilisez `/analytics-stop` pour arrêter le dashboard analytics lancé avec `/analytics`.

## Notes

- Fonctionne même si le serveur a été lancé en arrière-plan
- Libère immédiatement le port 3333
- Aucun effet si aucun serveur n'est actif

---
✅ Terminé : [timestamp Europe/Paris avec CEST/CET]

⏱️ Durée : [durée formatée]