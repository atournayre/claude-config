---
model: claude-sonnet-4-5-20250929
allowed-tools: Bash(git add:*), Bash(git status:*), Bash(git commit:*), Bash(git diff:*), Bash(git log:*), Bash(git checkout:*), Bash(git branch:*), Bash(git push:*), Bash(gh pr:*), Bash(gh api:*), Bash(make qa:*), Write, Read, TodoWrite
argument-hint: [branch-base, milestone, project, --delete]
description: Crée une Pull Request optimisée avec workflow structuré
---

# Git Pull Request Optimisée

## Purpose
Automatiser la création d'une Pull Request avec un workflow intelligent incluant QA, commits structurés, milestone et assignation projet GitHub.

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

## Variables
- `PR_TEMPLATE_PATH`: `.github/pull_request_template.md`
- `BRANCH_BASE`: Branche de destination (develop, main, release/*)
- `BRANCH_NAME`: Nom de la branche de travail en cours
- `PR_NUMBER`: Numéro de la PR créée
- `MILESTONE`: Milestone à assigner
- `PROJECT_NAME`: Nom du projet GitHub fourni en argument ou sélectionné par l'utilisateur
- `DELETE_FLAG`: Flag `--delete` pour supprimer automatiquement la branche locale

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
- ❌ Ne JAMAIS pusher sans vérifier `git log origin/$BRANCH_BASE..$BRANCH_NAME` avant
- ❌ Ne JAMAIS créer une PR si aucun commit entre origin/base et branche courante
- ❌ Ne JAMAIS comparer avec la branche locale, TOUJOURS avec origin/BRANCH_BASE

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

### Étape 0: Initialisation du Timing (OBLIGATOIRE - PREMIÈRE ACTION)
```
🕐 Démarrage: [timestamp ISO 8601]
```
- Cette étape DOIT être la toute première action
- Enregistrer le timestamp pour calcul ultérieur

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

**🚨 VÉRIFICATION CRITIQUE AVANT PUSH 🚨**

```bash
# OBLIGATOIRE : Vérifier que la branche courante est bien la branche de travail
CURRENT_BRANCH=$(git branch --show-current)
if [ "$CURRENT_BRANCH" != "$BRANCH_NAME" ]; then
    echo "❌ ERREUR CRITIQUE: Vous êtes sur $CURRENT_BRANCH au lieu de $BRANCH_NAME"
    echo "Checkout vers $BRANCH_NAME avant de continuer"
    git checkout $BRANCH_NAME
fi

# OBLIGATOIRE : Vérifier que origin/BRANCH_BASE n'a PAS le commit qu'on veut pousser
COMMITS_TO_PUSH=$(git log --oneline origin/$BRANCH_BASE..$BRANCH_NAME | wc -l)
if [ $COMMITS_TO_PUSH -eq 0 ]; then
    echo "❌ ERREUR CRITIQUE: Aucun commit à pousser entre origin/$BRANCH_BASE et $BRANCH_NAME"
    echo "La branche origin/$BRANCH_BASE contient déjà tous les commits de $BRANCH_NAME"
    echo "ARRÊT - Impossible de créer une PR vide"
    exit 1
fi

echo "✅ $COMMITS_TO_PUSH commit(s) à pousser"
echo "✅ Vous êtes bien sur la branche $BRANCH_NAME"

# OBLIGATOIRE : Afficher ce qui sera pushé
echo "Commits qui seront pushés :"
git log --oneline origin/$BRANCH_BASE..$BRANCH_NAME

# Push de la branche
git push -u origin $BRANCH_NAME

# Créer fichier temporaire pour éviter problèmes formatage
Write /tmp/pr_body.md [contenu avec template]

# Créer la PR avec le fichier
gh pr create --base $BRANCH_BASE --title "[TITRE]" --body-file /tmp/pr_body.md

# Nettoyer
rm /tmp/pr_body.md
```

**⚠️ RÈGLES DE SÉCURITÉ PUSH** :
1. TOUJOURS vérifier qu'on est sur la bonne branche avant de push
2. TOUJOURS vérifier qu'il y a des commits à pousser (comparer avec origin/BRANCH_BASE)
3. TOUJOURS afficher les commits avant de pousser
4. JAMAIS pousser si `git log origin/$BRANCH_BASE..$BRANCH_NAME` est vide
5. TOUJOURS comparer avec origin/BRANCH_BASE, JAMAIS avec la branche locale

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
# Si PROJECT_NAME fourni en argument
if [PROJECT_NAME fourni]; then
    # Vérifier que le projet existe
    gh api graphql -f query='query { ... }' | grep -i "$PROJECT_NAME"

    # Si trouvé : assigner directement
    # Récupérer PROJECT_ID depuis le nom
    # Assigner la PR au projet
    echo "✅ PR assignée au projet: $PROJECT_NAME"

    # Si non trouvé : erreur et demander à l'utilisateur
    echo "❌ ERREUR: Projet '$PROJECT_NAME' introuvable"
    # Afficher liste et demander confirmation
fi

# Sinon : workflow manuel existant
if [PROJECT_NAME non fourni]; then
    # Utiliser le script réutilisable pour l'assignation
    ./scripts/assign_github_project.sh [PR_NUMBER]

    # Le script va automatiquement :
    # - Récupérer la liste des projets disponibles
    # - Présenter les options à l'utilisateur
    # - ATTENDRE la sélection (OBLIGATOIRE)
    # - Assigner la PR au projet sélectionné
    # - Afficher la confirmation ou ignorer si demandé
fi
```

### Étape 9: Nettoyage Branche Locale
```bash
✅ Pull Request créée avec succès !

# Si --delete fourni en argument
if [DELETE_FLAG présent]; then
    # Supprimer automatiquement sans confirmation
    git checkout [BRANCH_BASE]
    git branch -D [BRANCH_NAME]
    echo "✅ Branche locale supprimée automatiquement"
fi

# Sinon : demander confirmation
if [DELETE_FLAG absent]; then
    echo "Souhaitez-vous supprimer la branche locale ?"
    echo "[y/N] :"

    # Si oui:
    git checkout [BRANCH_BASE]
    git branch -D [BRANCH_NAME]
    echo "✅ Branche locale supprimée"

    # Si non ou pas de réponse:
    echo "ℹ️ Branche locale conservée"
fi
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
- **Sélection automatique** : Si `project` fourni en argument, rechercher et assigner directement
- **Sélection manuelle** : Si `project` non fourni, demander à l'utilisateur
- **Projets fermés** : Ne pas afficher dans la liste
- **Assignation** : Automatique si projet fourni, sinon après confirmation explicite

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

---
✅ Terminé : [timestamp ISO 8601]
⏱️ Durée : [durée formatée]
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
