---
model: claude-sonnet-4-5-20250929
description: Execute claude-code-templates analytics and open in browser
---

# Analytics Dashboard

Lancer le tableau de bord d'analytics pour visualiser les statistiques d'utilisation de Claude Code.

## Instructions

- **IMPORTANT : Cette commande lance un serveur local sur le port 3333**
- **IMPORTANT : Le navigateur s'ouvre automatiquement après le démarrage du serveur**
- **IMPORTANT : Utiliser Ctrl+C pour arrêter le serveur quand terminé**

## Commandes

- Lancer le dashboard : !`(lsof -i :3333 > /dev/null 2>&1 && echo "⚠️ Port 3333 déjà utilisé. Arrêtez le processus existant avec la commande ci-dessous" || npx claude-code-templates@latest --analytics)`
- Lancer avec timeout (5min) : !`(lsof -i :3333 > /dev/null 2>&1 && echo "⚠️ Port 3333 déjà utilisé. Arrêtez le processus existant avec la commande ci-dessous" || timeout 300 npx claude-code-templates@latest --analytics)`
- Arrêter le serveur : !`(lsof -t -i:3333 > /dev/null 2>&1 && kill $(lsof -t -i:3333) && echo "✅ Serveur analytics arrêté") || echo "ℹ️ Aucun serveur analytics en cours"`

## Description

Cette commande :
1. Vérifie si le port 3333 est déjà utilisé
2. Si le port est occupé, affiche un message d'aide pour arrêter le processus
3. Sinon, lance l'outil d'analytics de claude-code-templates
4. Le navigateur s'ouvre automatiquement (géré par le serveur)

## Notes

- Le serveur reste actif jusqu'à interruption manuelle
- Les données d'analytics sont générées en temps réel
- Compatible avec les navigateurs modernes