---
model: claude-3-5-haiku-20241022
allowed-tools: Read, Bash(ls:*), Bash(find:*)
description: Lister toutes les sessions de développement
---

# Lister les Sessions de Développement

Afficher tous les fichiers de session avec les informations clés, triés par ordre chronologique inverse (plus récent en premier).

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

- **IMPORTANT : Vérifier si le répertoire `.claude/sessions/` existe**
- **IMPORTANT : Afficher les sessions par ordre chronologique inverse**
- **IMPORTANT : Mettre en évidence la session actuellement active**

## Processus

1. Vérifier si le répertoire `.claude/sessions/` existe
2. Si le répertoire n'existe pas :
   - Informer l'utilisateur qu'aucune session n'a encore été créée
   - Suggérer de démarrer la première session avec `session:start [nom]`
3. Si le répertoire existe :
   - Lister tous les fichiers `.md` de session (exclure les fichiers cachés et `.current-session`)
   - Pour chaque fichier de session, extraire et afficher :
     - Nom du fichier avec date/heure
     - Titre de la session depuis le contenu du fichier
     - Premières lignes de l'aperçu (si disponible)
     - Durée ou informations de statut
   - Mettre en évidence la session actuellement active (depuis le fichier `.current-session`)
   - Trier les sessions par ordre chronologique inverse (plus récent en premier)

## Format d'Affichage

```
Sessions trouvées dans .claude/sessions/ :

● [ACTIVE] 2024-01-15-1430-refactorisation-auth.md
  Titre : Refactorisation du Système d'Authentification
  Démarré : 15 jan 2024 à 14h30
  Aperçu : Modernisation du système d'auth avec OAuth2...

  2024-01-14-0900-corrections-bugs.md
  Titre : Corrections de Bugs Critiques
  Démarré : 14 jan 2024 à 9h00
  Statut : Terminé
  Aperçu : Correction des problèmes de traitement des paiements...
```

## Message Aucune Session

Si aucune session n'existe, fournir des conseils utiles :
- Aucune session trouvée
- Créer la première session avec `session:start [nom]`
- Utiliser `session:help` pour plus d'informations

Présenter les informations dans un format propre et lisible qui aide les utilisateurs à identifier rapidement les sessions pertinentes.

---
✅ Terminé : [timestamp Europe/Paris avec CEST/CET]

⏱️ Durée : [durée formatée]