---
model: claude-sonnet-4-5-20250929
allowed-tools: Bash, Write, Read, Glob, Edit, MultiEdit
description: Générateur de slash commands pour Claude Code avec workflow structuré et bonnes pratiques
argument-hint: [nom-commande] [description] [--tools=outil1,outil2] [--category=categorie]
---

# Générateur de Slash Commands

Créer une nouvelle slash command Claude Code : $ARGUMENTS

## Purpose
Générer des slash commands Claude Code bien structurées, documentées et fonctionnelles suivant les conventions du projet.

## Relevant files
- @docs/COMMANDS.md
- @docs/MODELS.md

## Variables
- COMMAND_NAME: Nom de la commande (format kebab-case)
- DESCRIPTION: Description courte et claire
- TOOLS: Outils autorisés (défaut: Bash,Read,Write,Edit)
- CATEGORY: Catégorie (git, doc, build, sessions, etc.)
- ARGUMENTS: Format des arguments de la commande

## Instructions
Vous êtes un générateur expert de slash commands. Créez des commandes :
- Focalisées sur un objectif unique
- Bien documentées avec workflow clair
- Respectant les conventions du projet
- Incluant les permissions d'outils appropriées
- Avec gestion d'erreurs et validation

## Relevant Files
- `_templates/prompt/README.md` - Template de base
- `commands/` - Exemples de commandes existantes
- `README.md` - Documentation du projet

## Workflow

### 1. Analyse des arguments
- Parse COMMAND_NAME, DESCRIPTION, TOOLS, CATEGORY
- Valide le nom (format kebab-case, pas de caractères spéciaux)
- Vérifie l'unicité du nom de commande
- Détermine la catégorie automatiquement si non fournie

### 2. Génération de la structure
- Crée le frontmatter YAML avec métadonnées
- Génère les sections standard adaptées au contexte
- **AJOUTE la section ## Timing avec instructions d'affichage**
- **AJOUTE "Étape 0: Initialisation du Timing" en premier dans le Workflow**
- Inclut les outils nécessaires selon la catégorie
- Ajoute des exemples d'utilisation pertinents

### 3. Validation et création
- Vérifie la cohérence et syntaxe
- Crée le répertoire si nécessaire
- Sauvegarde dans `commands/[category]/[command-name].md`
- Confirme la création avec résumé

### 4. Documentation
- Mets à jour "Structure du projet" dans @README.md
- Ajoutes la description de la commande dans @README.md

## Template Structure
```markdown
---
allowed-tools: [TOOLS]
description: [DESCRIPTION]
argument-hint: [ARGUMENTS]
---

# [TITLE]

[Instructions spécifiques pour Claude]

## Variables
[Variables utilisées dans la commande]

## Relevant Files
[Fichiers pertinents pour la commande]

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

## Workflow

### Étape 0: Initialisation du Timing (OBLIGATOIRE - PREMIÈRE ACTION)
```
🕐 Démarrage: [timestamp ISO 8601]
```
- Cette étape DOIT être la toute première action
- Enregistrer le timestamp pour calcul ultérieur

### Étape 1: [Première vraie étape de la commande]
- [Étapes logiques d'exécution]

### Étape N: Rapport Final
- Calculer la durée totale
- Afficher le rapport avec timing

## Report
```
[Contenu du rapport]

---
✅ Terminé : [timestamp ISO 8601]
⏱️ Durée : [durée formatée]
```
```

## Examples

### Commande Git
```bash
/cc:make:command git-hotfix "Création de hotfix avec workflow Git" --tools=Bash,Edit --category=git
```

### Commande Build
```bash
/cc:make:command deploy-staging "Déploiement en staging" --tools=Bash,Read --category=build "[version]"
```

## Report
- Crée le fichier dans `commands/[category]/[command-name].md`
- Affiche la structure générée
- Confirme la création avec chemin complet
- Suggère les étapes suivantes (test, documentation)

## Best Practices
- Nom en kebab-case uniquement
- Description concise mais claire
- Outils minimaux nécessaires
- Workflow en étapes logiques
- Format de rapport structuré
- **Timing obligatoire avec timestamp début/fin et durée**
- **Étape 0 du workflow = initialisation timing**
