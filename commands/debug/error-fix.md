---
allowed-tools: Bash,Read,Write,Edit,Grep,Glob,TodoWrite,Task
description: Analyser un message d'erreur, proposer un plan de résolution et l'exécuter
argument-hint: [message-erreur-ou-fichier-log]
---

# /error-fix - Analyse et résolution d'erreurs

Analyser un message d'erreur fourni, identifier les causes probables, proposer un plan de résolution structuré et l'exécuter de manière systématique.

## Purpose
Diagnostiquer rapidement les erreurs en analysant les messages, logs et contexte du code pour proposer et appliquer des solutions efficaces.

## Variables
- CURRENT_DATETIME: Date et heure courantes (date via <env>Today's date</env>, heure via commande système) pour comparaisons temporelles
- ERROR_MESSAGE: Message d'erreur à analyser (chaîne ou chemin vers fichier log)
- CONTEXT_FILES: Fichiers pertinents identifiés lors de l'analyse
- RESOLUTION_PLAN: Plan de résolution structuré en étapes
- EXECUTION_RESULTS: Résultats de l'exécution des corrections

## Instructions
Vous êtes un expert en diagnostic et résolution d'erreurs. Adoptez une approche méthodique :

1. **Analyse approfondie** : Examinez le message d'erreur, identifiez le type, la source et le contexte
2. **Recherche contextuelle** : Localisez les fichiers et code concernés
3. **Diagnostic** : Identifiez les causes probables et impact
4. **Plan de résolution** : Proposez des étapes concrètes et priorisées
5. **Exécution guidée** : Appliquez les corrections avec validation

## Relevant Files
- Logs d'application dans `/var/log/`, `logs/`, `storage/logs/`
- Fichiers de configuration (`.env`, config files)
- Code source identifié dans l'erreur
- Tests unitaires associés
- Documentation technique du projet

## Workflow

### 1. Analyse du message d'erreur
- Parse et categorise l'erreur (syntaxe, runtime, logique, configuration)
- Identifie la stack trace et fichiers impliqués
- Extrait les informations contextuelles (ligne, fonction, paramètres)
- Recherche les patterns d'erreur connus

### 2. Collecte du contexte
- Examine les fichiers mentionnés dans l'erreur
- Analyse les logs récents pour des erreurs corrélées (utiliser CURRENT_DATETIME pour filtrer par timestamp)
- Vérifie l'état de l'environnement (dépendances, configuration)
- Identifie les changements récents (git log, diff)

### 3. Diagnostic approfondi
- Détermine la cause racine vs symptômes
- Évalue l'impact et la criticité
- Identifie les solutions possibles et leurs trade-offs
- Priorise les actions selon l'urgence et complexité

### 4. Plan de résolution
- Définit les étapes de correction en séquence logique
- Spécifie les tests de validation pour chaque étape
- Prévoit les rollbacks en cas de problème
- Estime les risques et impacts

### 5. Exécution et validation
- Applique les corrections étape par étape
- Valide chaque modification (tests, compilation)
- Vérifie la résolution complète de l'erreur
- Documente les changements effectués

## Examples

### Erreur PHP
```bash
/error-fix "Fatal error: Uncaught Error: Call to undefined method User::getName()"
```

### Log file
```bash
/error-fix /var/log/app.log
```

### Erreur de build
```bash
/error-fix "npm ERR! missing script: build"
```

## Report

### Analyse
- **Type d'erreur** : Classification et sévérité
- **Localisation** : Fichiers et lignes concernés
- **Contexte** : Environnement et conditions de reproduction

### Diagnostic
- **Cause racine** : Origine identifiée du problème
- **Impact** : Portée et conséquences de l'erreur
- **Recommandations** : Solutions proposées avec priorités

### Résolution
- **Actions effectuées** : Liste détaillée des corrections appliquées
- **Validations** : Tests et vérifications réalisés
- **Suivi** : Points d'attention et prévention future

## Best Practices
- Analyser avant d'agir : comprendre complètement le problème
- Corrections incrémentales : une modification à la fois
- Validation systématique : tester après chaque changement
- Documentation : tracer les modifications pour le futur
- Prévention : identifier les améliorations pour éviter la récurrence
