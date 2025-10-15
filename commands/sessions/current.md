---
model: claude-3-5-haiku-20241022
allowed-tools: Read, Bash(date:*)
description: Afficher le statut et les détails de la session actuelle
---

# Statut de la Session Actuelle

Afficher le statut de la session actuelle en vérifiant l'existence d'une session active et en affichant les informations pertinentes.

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

- **IMPORTANT : Vérifier d'abord si `.claude/sessions/.current-session` existe**
- **IMPORTANT : Garder une sortie concise et informative**
- **IMPORTANT : Calculer la durée de la session avec précision**

## Processus

1. Vérifier si `.claude/sessions/.current-session` existe
2. Si aucune session active :
   - Informer l'utilisateur qu'il n'y a pas de session active
   - Suggérer d'en démarrer une avec `session:start [nom]`
3. Si une session active existe :
   - Afficher le nom et le fichier de la session
   - Calculer et afficher la durée depuis le début
   - Afficher les dernières mises à jour du fichier de session
   - Afficher les objectifs/tâches actuels si disponibles
   - Rappeler les commandes de session disponibles

## Informations à Afficher

- Nom du fichier et titre de la session
- Heure de début et durée
- Entrées de progression récentes
- Objectifs ou buts actuels
- Prochaines actions disponibles

## Rappel des Commandes Disponibles

- Mettre à jour : `session:update [notes]`
- Terminer : `session:end`
- Lister toutes : `session:list`

Garder la sortie propre et concentrée sur les informations exploitables.

---
✅ Terminé : [timestamp Europe/Paris avec CEST/CET]
⏱️ Durée : [durée formatée]