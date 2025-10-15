---
model: claude-sonnet-4-5-20250929
allowed-tools: [Bash, Read, Write, Edit, Glob, Grep]
description: Crées la documentation pour la fonctionnalité en cours. Mets à jour le readme global du projet si nécessaire. Lie les documents entre eux pour ne pas avoir de documentation orpheline. La documentation est générée dans les répertoire de documentation du projet.
---

# Documentation de fonctionnalité

Génère ou met à jour la documentation pour la fonctionnalité en cours de développement, en s'assurant que tous les documents sont liés et que le README principal est à jour.

## Purpose
Maintenir une documentation cohérente, à jour et bien interconnectée pour le projet.

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
- CURRENT_BRANCH: Branche Git en cours
- DOC_DIR: Répertoire de documentation du projet (détection automatique)
- README_PATH: Chemin vers le README principal du projet
- FEATURE_NAME: Nom de la fonctionnalité extraite de la branche et des modifications

## Relevant Files
- `README.md` - Documentation principale du projet
- `docs/` - Répertoire de documentation standard
- Fichiers source de la fonctionnalité
- Fichiers de tests associés

## Workflow

### Étape 0: Initialisation du Timing (OBLIGATOIRE - PREMIÈRE ACTION)
```
🕐 Démarrage: [timestamp Europe/Paris avec CEST/CET]
```
- Cette étape DOIT être la toute première action
- Enregistrer le timestamp pour calcul ultérieur

### 1. Analyse du contexte
- Identifie la branche Git en cours (git branch --show-current)
- Analyse les modifications de la branche :
  - Fichiers modifiés (git status)
  - Diff par rapport à main/master (git diff)
  - Commits de la branche (git log)
- Extrait le nom de la fonctionnalité depuis :
  - Le nom de la branche (ex: feature/user-auth → User Authentication)
  - Les commits de la branche
  - Les prompts récents de la session
- Détermine le répertoire de documentation :
  - Cherche `docs/`, `documentation/`, ou équivalent
  - Crée le répertoire si nécessaire
- Identifie les informations clés :
  - Fichiers principaux modifiés
  - Tests associés
  - Dépendances ajoutées/modifiées

### 2. Génération de la documentation
- Crée ou met à jour le fichier de documentation :
  - Titre et description claire
  - Utilisation et exemples
  - Architecture et composants
  - Configuration nécessaire
  - Tests et validation
  - Limitations et notes
- Format Markdown structuré avec :
  - Table des matières si nécessaire
  - Blocs de code avec syntaxe
  - Liens vers fichiers sources
  - Exemples d'utilisation concrets

### 3. Mise à jour du README principal
- Vérifie si la fonctionnalité doit être mentionnée dans le README
- Ajoute ou met à jour la section appropriée :
  - Fonctionnalités principales
  - Structure du projet
  - Documentation disponible
- Maintient la cohérence du format existant
- Préserve l'ordre et la hiérarchie

### 4. Liaison des documents
- Identifie les documents connexes :
  - Documentation de fonctionnalités liées
  - Guides d'architecture
  - Tutoriels
  - ADRs (Architecture Decision Records)
- Ajoute des liens bidirectionnels :
  - Depuis le nouveau document vers les connexes
  - Depuis les connexes vers le nouveau document
- Vérifie l'absence de liens cassés
- Crée un index si nécessaire pour les projets volumineux

### 5. Validation et rapport
- Vérifie la qualité de la documentation :
  - Tous les exemples sont fonctionnels
  - Les liens sont valides
  - Le formatage Markdown est correct
  - Pas de typos évidentes
- Génère un rapport de ce qui a été créé/modifié

## Report
Affiche un résumé structuré :

```
Documentation générée :
- Fonctionnalité : [NOM]
- Fichier créé/modifié : [CHEMIN]
- Taille : [LIGNES] lignes

Modifications README :
- Section modifiée : [SECTION]
- Ajouts : [DESCRIPTION]

Liens créés :
- [DOC1] ↔ [DOC2]
- [DOC3] ↔ [DOC4]

Documents liés :
- [LISTE DES DOCS CONNEXES]

---
✅ Terminé : [timestamp Europe/Paris avec CEST/CET]
⏱️ Durée : [durée formatée]
```

## Best Practices
- Documentation focalisée sur l'utilisation, pas l'implémentation
- Exemples concrets et testés
- Langage clair et concis (style bullet points)
- Liens relatifs pour la portabilité
- Pas de duplication entre README et docs détaillées
- README = vue d'ensemble, docs/ = détails
- Maintenir la cohérence du ton et du format
