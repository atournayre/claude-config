---
allowed-tools: Bash
argument-hint: <source-branch> [issue-number-or-text]
description: Création de branche Git avec workflow structuré
---

# Création de branche Git

## Purpose
Créer une nouvelle branche Git de manière structurée avec support des issues GitHub.

## Variables
SOURCE_BRANCH: $1
ISSUE_OR_TEXT: $2

## Instructions
- Utilise les outils Bash pour les opérations Git
- Valide que la branche source existe
- Génère un nom de branche basé sur l'issue si fournie
- Applique les conventions de nommage du projet

## Relevant Files
- @.git/config
- @.gitignore
- @docs/README.md

## Workflow
- Vérifie que `SOURCE_BRANCH` est fourni (obligatoire), si il n'est pas fourni, ARRETER immédiatement et demander à l'utilisateur de le fournir.
- Valide que `SOURCE_BRANCH` existe localement
- Si `ISSUE_OR_TEXT` est fourni :
  - Détecte si c'est un numéro (entier) ou du texte
  - Si c'est un numéro :
    - Récupère les informations de l'issue via GitHub CLI (`gh issue view ${ISSUE_OR_TEXT}`)
    - Génère un nom de branche : `issue/${ISSUE_OR_TEXT}-{titre-simplifie}`
    - Le titre est nettoyé (espaces -> tirets, caractères spéciaux supprimés, minuscules)
  - Si c'est du texte :
    - Génère un nom de branche : `feature/${ISSUE_OR_TEXT-simplifie}`
    - Le texte est nettoyé (espaces -> tirets, caractères spéciaux supprimés, minuscules)
- Si pas de `ISSUE_OR_TEXT`, demande le nom de branche à l'utilisateur
- Vérifie que la branche n'existe pas déjà
- Créé et checkout la nouvelle branche
- Configure le tracking vers remote si nécessaire

## Expertise
Conventions de nommage des branches :
- `feature/nom-descriptif` : Nouvelles fonctionnalités
- `fix/nom-bug` : Corrections de bugs
- `issue/123-nom-descriptif` : Basé sur une issue GitHub
- Utilise des tirets, pas d'espaces ni caractères spéciaux

## Template
```bash
# Exemple d'usage avec numéro d'issue :
/git:branch main 42

# Résultat attendu :
# - Récupère l'issue #42
# - Titre: "Add user authentication system"
# - Crée la branche: issue/42-add-user-authentication-system
# - Checkout vers cette branche

# Exemple d'usage avec texte :
/git:branch main "Add login form"

# Résultat attendu :
# - Crée la branche: feature/add-login-form
# - Checkout vers cette branche
```

## Examples
```bash
# Créer une branche depuis main avec issue GitHub
/git:branch main 123

# Créer une branche depuis main avec texte descriptif
/git:branch main "user authentication"

# Créer une branche depuis develop sans argument supplémentaire
/git:branch develop

# Créer une branche depuis une branche existante avec issue
/git:branch feature/api-base 456

# Créer une branche fix depuis main avec texte
/git:branch main "fix login bug"
```

## Report
- Nom de la branche créée
- Branche source utilisée
- Issue associée (si applicable)
- Statut du checkout
- Configuration du tracking remote

## Validation
- ✅ `SOURCE_BRANCH` doit exister localement
- ✅ `SOURCE_BRANCH` est obligatoire
- ✅ La nouvelle branche ne doit pas déjà exister
- ✅ Si `ISSUE_OR_TEXT` est un numéro, l'issue doit exister sur GitHub
- ✅ Le nom généré respecte les conventions de nommage
- ✅ Détection automatique entre numéro d'issue et texte descriptif
