# Claude Config - Plugin Claude Code

Plugin avancé pour Claude Code avec workflows Git, documentation automatique, analyse de code et support Symfony/PHP.

[![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)](https://github.com/atournayre/claude-config)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)

## Installation

### Via Plugin Marketplace (Recommandé)

```bash
/plugin install claude-config@marketplace
```

### Installation des Extras

Certains éléments (output-styles, status-lines) nécessitent une installation complémentaire :

```bash
cd ~/.claude/plugins/claude-config
bash scripts/install-extras.sh
```

### Configuration des Permissions

Consultez [docs/PERMISSIONS.md](docs/PERMISSIONS.md) pour configurer les permissions recommandées dans `~/.claude/settings.json`.

### Utilisateurs existants

Si vous utilisiez l'ancienne installation manuelle, voir [MIGRATION.md](MIGRATION.md).

## Fonctionnalités

### 🔧 Workflows Git Avancés (5 commandes)
- `/git:branch` - Création de branche depuis GitHub issues
- `/git:commit` - Commits structurés avec conventional commits
- `/git:conflit` - Résolution interactive de conflits
- `/git:pr` - Pull Request avec QA automatique
- `/git:status` - Statut Git enrichi

### 📝 Documentation Automatique (3 commandes)
- `/doc:adr` - Architecture Decision Records
- `/doc:rtfm` - Lecture de documentation technique
- `/doc:update` - Documentation automatique de fonctionnalités

### 🐛 Diagnostic et Debug (2 commandes)
- `/debug:error-fix` - Analyse et résolution d'erreurs
- `/debug:stack-trace` - Analyse détaillée de stack traces

### ✅ Qualité de Code (1 commande)
- `/qa:phpstan` - Résolution automatique d'erreurs PHPStan niveau 9

### 🎼 Support Symfony (3 commandes)
- `/symfony:make` - Utilise les makers Symfony ou génère un plan
- `/symfony:doc:load` - Charge documentation Symfony localement
- `/symfony:doc:question` - Interroge la doc Symfony

### 🔌 Support API Platform (2 commandes)
- `/api-platform:doc:load` - Charge documentation API Platform
- `/api-platform:doc:question` - Interroge la doc API Platform

### 🔎 Support Meilisearch (2 commandes)
- `/meilisearch:doc:load` - Charge documentation Meilisearch
- `/meilisearch:doc:question` - Interroge la doc Meilisearch

### 🔍 Analyse Avancée (3 commandes)
- `/analyse:impact` - Analyse d'impact de PR (métier + technique)
- `/think:harder` - Analyse intensive de problèmes complexes
- `/think:ultra` - Analyse ultra-exhaustive (7 phases)

### 🎯 Gestion de Sessions (6 commandes)
- `/sessions:start`, `/sessions:current`, `/sessions:list`
- `/sessions:end`, `/sessions:update`, `/sessions:help`

### 💻 Méta-Commandes (2 commandes)
- `/cc:make:command` - Générateur de slash commands
- `/cc:challenge` - Auto-évaluation des réponses

### 📊 Analytics (2 commandes)
- `/analytics` - Dashboard d'utilisation Claude Code
- `/analytics-stop` - Arrêt du serveur analytics

### 🏗️ Build et Planification (2 commandes)
- `/prepare` - Génère un plan d'implémentation technique
- `/code` - Workflow de code complet avec QA

**Total : 42 commandes personnalisées**

[📖 Documentation complète des commandes](docs/COMMANDS.md)

## Agents Spécialisés

Le plugin inclut 8 agents spécialisés :

- **phpstan-error-resolver** - Résolution automatique erreurs PHPStan niveau 9
- **elegant-objects-reviewer** - Vérification conformité Elegant Objects
- **symfony-docs-scraper** - Extraction documentation Symfony
- **api-platform-docs-scraper** - Extraction documentation API Platform
- **meilisearch-docs-scraper** - Extraction documentation Meilisearch
- **claude-docs-scraper** - Extraction documentation Claude Code
- **atournayre-framework-docs-scraper** - Extraction documentation atournayre-framework
- **meta-agent** - Génération de nouveaux agents

## Hooks Système

7 hooks pour automatiser votre workflow :

- **session_start** - Chargement contexte au démarrage
- **user_prompt_submit** - Validation et enrichissement des prompts
- **pre_tool_use** - Protections (rm -rf, .env)
- **post_tool_use** - Ajustement automatique des permissions
- **pre_compact** - Sauvegarde avant compactage
- **stop** - Nettoyage à l'arrêt
- **subagent_stop** - Gestion des sous-agents

### Sécurité des Hooks

- Blocage automatique des commandes `rm -rf` dangereuses
- Protection des fichiers `.env` sensibles
- Gestion gracieuse des dépendances manquantes

## Scripts Réutilisables

- `assign_github_project.sh` - Assignation interactive de PR à un projet GitHub
- `install-extras.sh` - Installation des output-styles et status-lines

## Output Styles Inclus

7 styles de sortie personnalisés :

- **GenUI** - Interface HTML générée avec CSS moderne
- **Markdown Focused** - Markdown enrichi avec emojis
- **HTML Structured** - HTML sémantique portable
- **Table Based** - Format tabulaire pour comparaisons
- **Bullet Points** - Listes hiérarchiques concises
- **Ultra Concise** - Réponses minimales directes
- **YAML Structured** - Format YAML parsable

## Status Lines

5 versions de status line avec fonctionnalités croissantes :

- **v5 (Recommandée)** - Historique 3 prompts, icônes intelligentes, coût journalier (ccusage), Git enrichi
- **v4** - Prompt unique avec icône, Git basique
- **v3** - Historique 3 prompts, couleurs différenciées
- **v2** - Agent + prompt actuel
- **v1** - Affichage minimal

## Dépendances Optionnelles

```bash
# Analyse de coûts (status line v5)
npm install -g ccusage

# Text-to-speech (hooks)
pip install pyttsx3

# Variables d'environnement (hooks)
pip install python-dotenv
```

Le plugin fonctionne en mode dégradé sans ces dépendances.

## Configuration Avancée

### Permissions Bash

Ajoutez dans `~/.claude/settings.json` :

```json
{
  "permissions": {
    "allow": [
      "Bash(git:*)",
      "Bash(gh:*)",
      "Bash(composer:*)",
      "Bash(docker:*)",
      "Bash(make:*)",
      "Bash(php:*)",
      "WebFetch(domain:docs.anthropic.com)",
      "WebFetch(domain:github.com)"
    ]
  }
}
```

Voir [docs/PERMISSIONS.md](docs/PERMISSIONS.md) pour la liste complète.

### Status Line

Dans `settings.json` :

```json
{
  "status_line_hook": "python3 ~/.claude/plugins/claude-config/status_lines/status_line_v5.py"
}
```

### Hooks

La configuration des hooks est automatique via `hooks/hooks.json`.

## Structure du Projet

```
claude-config/
├── .claude-plugin/
│   └── plugin.json              # Métadonnées du plugin
├── commands/                    # 42 slash commands
│   ├── git/                     # Workflows Git (5)
│   ├── doc/                     # Documentation (3)
│   ├── debug/                   # Diagnostic (2)
│   ├── qa/                      # Qualité (1)
│   ├── symfony/                 # Symfony (3)
│   ├── api-platform/            # API Platform (2)
│   ├── meilisearch/             # Meilisearch (2)
│   ├── sessions/                # Sessions (6)
│   ├── think/                   # Analyse (2)
│   ├── cc/                      # Méta (2)
│   └── ...
├── agents/                      # 8 agents spécialisés
├── hooks/                       # 7 hooks système
│   ├── hooks.json               # Configuration hooks
│   └── ...
├── scripts/                     # Scripts bash réutilisables
├── output-styles/               # 7 styles de sortie
├── status_lines/                # 5 versions status line
├── docs/                        # Documentation
│   ├── COMMANDS.md              # Référence complète commandes
│   ├── PERMISSIONS.md           # Guide des permissions
│   └── specs/                   # Spécifications techniques
├── README.md                    # Ce fichier
├── CHANGELOG.md                 # Historique des versions
└── MIGRATION.md                 # Guide de migration
```

## Exemples d'Utilisation

### Workflow Git Complet

```bash
# 1. Créer branche depuis issue GitHub #42
/git:branch main 42

# 2. Faire les modifications...

# 3. Commit structuré
/git:commit "feat: ajouter authentification OAuth"

# 4. Créer PR avec QA automatique
/git:pr main "v1.2.0" "Project Alpha"
```

### Documentation Automatique

```bash
# 1. Implémenter une fonctionnalité...

# 2. Générer la documentation automatiquement
/doc:update

# 3. Créer un ADR pour décision importante
/doc:adr "Choix de l'architecture microservices"
```

### Analyse d'Erreurs

```bash
# 1. Analyser erreur PHPStan
/qa:phpstan

# 2. Analyser stack trace
/debug:stack-trace "Error: Undefined variable..."

# 3. Résolution guidée
/debug:error-fix "TypeError in UserController"
```

### Documentation Externe

```bash
# 1. Charger doc Symfony localement
/symfony:doc:load

# 2. Interroger la documentation
/symfony:doc:question "Comment créer un service?"

# 3. Lire doc externe
/doc:rtfm https://symfony.com/doc/current/service_container.html
```

## Commandes les Plus Utilisées

| Commande | Usage | Description |
|----------|-------|-------------|
| `/git:commit` | `/git:commit [message]` | Commit structuré |
| `/git:pr` | `/git:pr [base] [milestone]` | Pull Request avec QA |
| `/doc:update` | `/doc:update` | Documentation auto |
| `/debug:error-fix` | `/debug:error-fix [error]` | Résolution d'erreurs |
| `/qa:phpstan` | `/qa:phpstan` | Correction PHPStan |

## Workflow Recommandé

1. **Démarrage** - Hook `session_start` charge le contexte
2. **Développement** - Status line v5 affiche historique et coût
3. **Documentation** - `/doc:update` génère la doc automatiquement
4. **Qualité** - `/qa:phpstan` corrige les erreurs d'analyse
5. **Git** - `/git:commit` et `/git:pr` gèrent le versioning
6. **Analyse** - `/analyse:impact` évalue l'impact des changements

## Support et Contribution

### Rapporter un Bug

Ouvrez une issue sur GitHub avec :
- Description du problème
- Logs pertinents (`.claude/data/plugins/claude-config/logs/`)
- Commande utilisée
- Version du plugin

### Contribuer

1. Fork le repository
2. Créez une branche feature
3. Committez vos changements
4. Ouvrez une Pull Request

### Documentation

- [Documentation complète des commandes](docs/COMMANDS.md)
- [Guide des permissions](docs/PERMISSIONS.md)
- [Guide de migration](MIGRATION.md)
- [Changelog](CHANGELOG.md)

## Auteur

**Aurélien Tournayre**
- GitHub: [@atournayre](https://github.com/atournayre)
- Email: aurelien.tournayre@gmail.com

## Licence

MIT License - Voir [LICENSE](LICENSE) pour plus de détails.

## Remerciements

- Anthropic pour Claude Code
- La communauté Claude Code pour les idées et contributions
- Yegor Bugayenko pour les principes Elegant Objects
