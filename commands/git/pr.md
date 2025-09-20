---
allowed-tools: Bash(git add:*), Bash(git status:*), Bash(git commit:*), Bash(git diff:*), Bash(git log:*), Bash(git checkout:*), Bash(git branch:*), Bash(git push:*), Bash(gh pr:*), Bash(gh api:*), Bash(make qa:*), Write, Read, TodoWrite
argument-hint: [branch-base, milestone]
description: Crée une Pull Request optimisée avec workflow structuré
---

# Git Pull Request Optimisée

## Purpose
Automatiser la création d'une Pull Request avec un workflow intelligent incluant QA, commits structurés, milestone et assignation projet GitHub.

## Variables
- `PR_TEMPLATE_PATH`: `.github/pull_request_template.md`
- `BRANCH_BASE`: Branche de destination (develop, main, release/*)
- `BRANCH_NAME`: Nom de la branche de travail en cours
- `PR_NUMBER`: Numéro de la PR créée
- `MILESTONE`: Milestone à assigner
- `PROJECT_ID`: ID du projet GitHub sélectionné par l'utilisateur

## Instructions

### RÈGLES CRITIQUES - AUCUNE EXCEPTION
1. ✅ **TodoWrite OBLIGATOIRE** en première action
2. ✅ **QA intelligente** pour fichiers PHP uniquement
3. ✅ **JAMAIS d'assumption** sur branche/milestone
4. ✅ **Assigner automatiquement** au projet
5. ✅ **Marquer chaque todo** completed au fur et à mesure

### INTERDICTIONS ABSOLUES
- ❌ Ne JAMAIS assumer la branche de base
- ❌ Ne JAMAIS choisir un milestone sans demander
- ❌ Ne JAMAIS ignorer l'assignation au projet GitHub
- ❌ Ne JAMAIS utiliser `git commit -m` directement

## Relevant Files
- `$PR_TEMPLATE_PATH`: Template PR obligatoire du projet
- `Makefile`: Pour la commande `make qa`
- `.claude/commands/git/commit.md`: Pour les commits structurés

## Codebase Structure
```
project/
├── .github/
│   └── pull_request_template.md  # Template PR obligatoire ($PR_TEMPLATE_PATH)
├── src/                          # Code PHP principal
├── templates/                    # Templates Twig
├── config/                       # Configuration
├── tests/                        # Tests unitaires
└── Makefile                      # Commandes make (qa, test, etc.)
```

## Workflow

### Étape 1: Vérification du Template PR (OBLIGATOIRE)
```bash
# Définir la variable du template PR
PR_TEMPLATE_PATH=".github/pull_request_template.md"

# Vérifier l'existence du template PR du projet
if [ ! -f "$PR_TEMPLATE_PATH" ]; then
    echo "❌ ERREUR: Template PR absent dans le projet"
    echo "Le fichier $PR_TEMPLATE_PATH est obligatoire"
    echo "Impossible de continuer sans template PR"
    exit 1
fi

echo "✅ Template PR trouvé: $PR_TEMPLATE_PATH"
```

### Étape 2: Initialisation TodoWrite
```
Créer immédiatement une todo list avec TOUTES les étapes:
1. Vérification du template PR (déjà fait)
2. Vérification QA intelligente si fichiers PHP modifiés
3. Analyse des changements (git status/diff)
4. Confirmation branche de base avec utilisateur
5. Création branche de travail
6. Création commits structurés avec /git:commit
7. Push de la branche
8. Création Pull Request avec template du projet
9. Assignation milestone (avec confirmation utilisateur)
10. Assignation au projet GitHub
11. Proposition nettoyage branche locale
```

### Étape 3: Vérification QA Intelligente
```bash
# Vérifier les fichiers modifiés
git diff --name-only
git status --porcelain

# Si fichiers PHP détectés (.php)
if [fichiers PHP]; then
    make qa  # Timeout 600s
    # Si échec: ARRÊTER avec message d'erreur
fi
# Sinon: "ℹ️ Aucun fichier PHP modifié - QA ignorée"
```

### Étape 4: Analyse des Changements
```bash
# Analyser l'état du repository
git status
git diff --stat
git diff  # Pour comprendre les modifications
```

### Étape 5: Confirmation Branche de Base
```
# OBLIGATOIRE - Demander à l'utilisateur
# Détecter les branches disponibles
git branch -r | grep -E "(develop|main|master|release)"

# Afficher les options
Quelle branche de base voulez-vous utiliser ?
Options détectées : develop, main, release/1.0.0
[Votre choix] :

# ATTENDRE LA RÉPONSE - NE JAMAIS ASSUMER
```

### Étape 6: Push et Création PR
```bash
# Push de la branche
git push -u origin [BRANCH_NAME]

# Créer fichier temporaire pour éviter problèmes formatage
Write /tmp/pr_body.md [contenu avec template]

# Créer la PR avec le fichier
gh pr create --base [BRANCH_BASE] --title "[TITRE]" --body-file /tmp/pr_body.md

# Nettoyer
rm /tmp/pr_body.md
```

### Étape 7: Assignation Milestone
```bash
# Récupérer les milestones
gh api repos/:owner/:repo/milestones --jq '.[] | select(.state == "open")'

# OBLIGATOIRE - Présenter et ATTENDRE réponse
Milestones disponibles :
[1] 1.0.0 [SUGGÉRÉ]
[2] 1.1.0
[3] Saisir manuellement
[4] Ignorer

⚠️ OBLIGATOIRE - Choisir [1-4]:
# ATTENDRE RÉPONSE - NE JAMAIS CHOISIR SEUL

# Assigner après confirmation
gh pr edit [PR_NUMBER] --milestone "[MILESTONE_TITLE]"
```

### Étape 8: Assignation Projet GitHub
```bash
# Utiliser le script réutilisable pour l'assignation
./scripts/assign_github_project.sh [PR_NUMBER]

# Le script va automatiquement :
# - Récupérer la liste des projets disponibles
# - Présenter les options à l'utilisateur
# - ATTENDRE la sélection (OBLIGATOIRE)
# - Assigner la PR au projet sélectionné
# - Afficher la confirmation ou ignorer si demandé
```

### Étape 9: Nettoyage Branche Locale
```
✅ Pull Request créée avec succès !

Souhaitez-vous supprimer la branche locale ?
[y/N] :

# Si oui:
git checkout [BRANCH_BASE]
git branch -D [BRANCH_NAME]
"✅ Branche locale supprimée"

# Si non ou pas de réponse:
"ℹ️ Branche locale conservée"
```

## Expertise

### Conventions de Nommage
- **Branches**: `feature/description`, `fix/issue-number`, `refactor/component`
- **Titres de PR**:
  - Si liée à une issue : `[Titre de l'issue] / Issue #[numéro]`
    - Exemple : `Correction du bug d'authentification / Issue #42`
  - Si pas d'issue : Titre métier décrivant les modifications
    - Exemple : `Ajout de la fonctionnalité d'export PDF`
    - Exemple : `Refactoring du service de notification`

### Configuration Projet GitHub
- **Sélection manuelle** : Toujours demander à l'utilisateur
- **Projets fermés** : Ne pas afficher dans la liste
- **Assignation** : Uniquement après confirmation explicite

## Template

### Utilisation du Template Projet

**⚠️ IMPORTANT**:
- **TOUJOURS** utiliser le template PR du projet (`$PR_TEMPLATE_PATH`)
- **JAMAIS** utiliser un template générique ou d'exemple
- **ARRÊT IMMÉDIAT** si le template n'existe pas dans le projet

Le template doit être lu depuis le fichier du projet et rempli avec les informations appropriées:
- Remplacer les placeholders par les valeurs réelles
- Adapter les sections selon les modifications effectuées
- Respecter le format exact du template du projet

## Report

### Résumé Final Obligatoire
```
✅ PULL REQUEST CRÉÉE AVEC SUCCÈS

📋 Détails:
- PR #[NUMBER]: [TITRE]
- Branche: [BRANCH_NAME] → [BRANCH_BASE]
- Commits: [NOMBRE] commits structurés
- Milestone: [MILESTONE]
- Projet: [NOM_PROJET]
- URL: [URL_PR]

📊 Statistiques:
- Fichiers modifiés: [COUNT]
- Lignes ajoutées: +[COUNT]
- Lignes supprimées: -[COUNT]

🔍 QA: [PASSÉE/IGNORÉE/ÉCHEC]
🗑️ Branche locale: [SUPPRIMÉE/CONSERVÉE]

✅ Tous les todos complétés
```

### Checklist de Validation
- [ ] Template PR du projet vérifié (présent et utilisé)
- [ ] TodoWrite utilisé et tous complétés
- [ ] Branche confirmée par utilisateur
- [ ] QA exécutée si PHP modifié
- [ ] Commits via /git:commit
- [ ] Template PR du projet respecté (pas de template générique)
- [ ] Milestone confirmé par utilisateur
- [ ] Projet GitHub assigné (après confirmation utilisateur)
- [ ] Nettoyage proposé

**SI UN ÉLÉMENT MANQUE**: La commande a échoué
