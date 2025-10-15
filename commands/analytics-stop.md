---
model: claude-3-5-haiku-20241022
description: Stop the running analytics dashboard server
---

# Stop Analytics Dashboard

Arrête proprement le serveur analytics dashboard s'il est en cours d'exécution.

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