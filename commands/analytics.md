---
model: claude-sonnet-4-5-20250929
description: Execute claude-code-templates analytics and open in browser
---

# Analytics Dashboard

Lancer le tableau de bord d'analytics pour visualiser les statistiques d'utilisation de Claude Code.

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

---
✅ Terminé : [timestamp Europe/Paris avec CEST/CET]

⏱️ Durée : [durée formatée]