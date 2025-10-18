# Changelog

Toutes les modifications notables de ce projet seront documentées dans ce fichier.

Le format est basé sur [Keep a Changelog](https://keepachangelog.com/fr/1.0.0/),
et ce projet adhère au [Semantic Versioning](https://semver.org/lang/fr/).

## [1.0.0] - 2025-10-16

### Added

#### Structure Plugin
- Transformation du projet en plugin Claude Code officiel
- Fichier `plugin.json` avec métadonnées complètes
- Configuration `hooks/hooks.json` pour gestion automatique des hooks
- Script `scripts/install-extras.sh` pour installation post-plugin des output-styles et status-lines

#### Commandes (42 au total)
- **Git (5)** : branch, commit, conflit, pr, status
- **GitHub (1)** : fix
- **Documentation (3)** : adr, rtfm, update
- **Debug (2)** : error-fix, stack-trace
- **QA (1)** : phpstan
- **Analyse (3)** : impact, think:harder, think:ultra
- **Context (2)** : default, elegant_object
- **Build (2)** : prepare, code
- **CC (2)** : make:command, challenge
- **Analytics (2)** : analytics, analytics-stop
- **Sessions (6)** : start, current, list, end, update, help
- **Symfony (3)** : make, doc:load, doc:question
- **API Platform (2)** : doc:load, doc:question
- **Meilisearch (2)** : doc:load, doc:question
- **Claude (2)** : doc:load, doc:question
- **atournayre-framework (2)** : doc:load, doc:question
- **Générales (4)** : all_tools, docker, question, git_status

#### Agents (8)
- `phpstan-error-resolver` - Résolution automatique erreurs PHPStan niveau 9
- `elegant-objects-reviewer` - Vérification conformité Elegant Objects
- `symfony-docs-scraper` - Extraction documentation Symfony
- `api-platform-docs-scraper` - Extraction documentation API Platform
- `meilisearch-docs-scraper` - Extraction documentation Meilisearch
- `claude-docs-scraper` - Extraction documentation Claude Code
- `atournayre-framework-docs-scraper` - Extraction documentation atournayre-framework
- `meta-agent` - Génération de nouveaux agents

#### Hooks (7)
- `session_start` - Chargement contexte au démarrage
- `user_prompt_submit` - Validation et enrichissement des prompts
- `pre_tool_use` - Protections (rm -rf, .env)
- `post_tool_use` - Ajustement automatique des permissions
- `pre_compact` - Sauvegarde avant compactage
- `stop` - Nettoyage à l'arrêt
- `subagent_stop` - Gestion des sous-agents

#### Scripts
- `assign_github_project.sh` - Assignation interactive de PR à un projet GitHub
- `install-extras.sh` - Installation des output-styles et status-lines

#### Output Styles (7)
- GenUI - Interface HTML générée
- Markdown Focused - Markdown enrichi
- HTML Structured - HTML sémantique
- Table Based - Format tabulaire
- Bullet Points - Listes hiérarchiques
- Ultra Concise - Réponses minimales
- YAML Structured - Format YAML parsable

#### Status Lines (5)
- v1 - Affichage minimal
- v2 - Agent + prompt
- v3 - Historique 3 prompts
- v4 - Prompt avec icône, Git basique
- v5 - Historique 3 prompts, icônes intelligentes, coût journalier (ccusage), Git enrichi

#### Documentation
- `docs/COMMANDS.md` - Référence complète des 42 commandes
- `docs/PERMISSIONS.md` - Guide des permissions recommandées
- `MIGRATION.md` - Guide de migration depuis installation manuelle
- `CHANGELOG.md` - Ce fichier
- `README.md` - Documentation complète restructurée pour marketplace

### Changed

#### Architecture
- Migration depuis installation manuelle vers système de plugins
- Paths des logs adaptés : `~/.claude/data/plugins/claude-config/logs/`
- Paths des sessions adaptés : `~/.claude/data/plugins/claude-config/sessions/`
- Tous les hooks utilisent des paths dynamiques relatifs au plugin
- Output-styles et status-lines nécessitent installation complémentaire via `install-extras.sh`

#### Hooks
- `notification.py` - Logs dans plugin data dir
- `session_start.py` - Logs dans plugin data dir
- `user_prompt_submit.py` - Logs et sessions dans plugin data dir
- `pre_tool_use.py` - Logs dans plugin data dir
- `post_tool_use.py` - Logs dans plugin data dir, debug logs adaptés
- `pre_compact.py` - Logs et backups dans plugin data dir
- `stop.py` - Logs dans plugin data dir
- `subagent_stop.py` - Logs dans plugin data dir

#### Documentation
- README restructuré pour audience marketplace
- Mise en avant de l'installation via plugin
- Section "Installation manuelle" supprimée au profit de MIGRATION.md
- Documentation des 42 commandes dans COMMANDS.md
- Permissions documentées dans PERMISSIONS.md

### Security

#### Hooks de Sécurité
- Protection automatique contre commandes `rm -rf` dangereuses (pre_tool_use)
- Blocage accès aux fichiers `.env` sensibles (pre_tool_use)
- Gestion gracieuse des dépendances manquantes

### Notes de Migration

#### Pour Utilisateurs Existants
- Désinstaller l'ancienne configuration manuelle avant installation du plugin
- Exécuter `scripts/install-extras.sh` après installation pour output-styles et status-lines
- Configurer les permissions selon `docs/PERMISSIONS.md`
- Les logs sont maintenant dans `~/.claude/data/plugins/claude-config/logs/`

#### Changements Incompatibles
- L'ancien script `install.sh` n'est plus utilisé pour l'installation principale
- Les chemins de logs ont changé (anciennement `.claude/logs`, maintenant dans plugin data dir)
- Output-styles et status-lines nécessitent installation séparée via `install-extras.sh`

### Dépendances Optionnelles

#### Recommandées
- `ccusage` (npm) - Suivi des coûts journaliers (status line v5)
- `pyttsx3` (pip) - Text-to-speech pour hooks
- `python-dotenv` (pip) - Variables d'environnement pour hooks

Le plugin fonctionne en mode dégradé sans ces dépendances.

## [Unreleased]

### À venir
- Tests automatisés de non-régression
- Configuration marketplace de test locale
- Documentation vidéo des fonctionnalités principales
- Templates de slash commands supplémentaires

---

## Guide de Versioning

- **MAJOR** (X.0.0) - Changements incompatibles avec versions précédentes
- **MINOR** (0.X.0) - Nouvelles fonctionnalités rétrocompatibles
- **PATCH** (0.0.X) - Corrections de bugs rétrocompatibles

## Liens

- [Repository GitHub](https://github.com/atournayre/claude-config)
- [Documentation Complète](README.md)
- [Guide des Commandes](docs/COMMANDS.md)
- [Guide des Permissions](docs/PERMISSIONS.md)
- [Guide de Migration](MIGRATION.md)
