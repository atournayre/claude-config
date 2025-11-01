# Configuration Claude Code

Configuration personnelle minimale pour Claude Code. Ce projet s'appuie sur le marketplace [claude-plugin](https://github.com/atournayre/claude-plugin) pour toutes les fonctionnalités avancées.

## Table des matières

- [Philosophie](#philosophie)
- [Structure du projet](#structure-du-projet)
- [Installation](#installation)
- [Marketplace claude-plugin](#marketplace-claude-plugin)
- [Configuration des permissions](#configuration-des-permissions)
- [Utilisation](#utilisation)

## Philosophie

Ce projet adopte une approche **minimaliste** :
- Configuration uniquement (permissions, préférences)
- Documentation locale pour un accès hors-ligne
- Configurations MCP pour les intégrations externes
- **Zéro duplication** : toutes les fonctionnalités sont dans le marketplace

## Structure du projet

```
claude-config/
├── docs/                   # Documentation locale (API Platform, Symfony, etc.)
├── mcp/                    # Configurations MCP (Chrome DevTools, Sentry)
├── settings.json           # Permissions Bash et WebFetch
├── CLAUDE.md               # Préférences utilisateur et conventions de code
├── install.sh              # Script d'installation automatique
└── README.md               # Ce fichier
```

**Ce qui n'est PAS ici (disponible dans le marketplace) :**
- Commandes (43 slash commands)
- Agents (8 agents spécialisés)
- Hooks système (8 hooks)
- Status lines (5 versions)
- Output styles (7 styles)
- Scripts utilitaires (assign_github_project.sh, sync-timing.sh)
- Templates (prompt template, timing-section)

## Installation

### Prérequis

1. **Claude Code** installé
2. **Marketplace claude-plugin** cloné :
   ```bash
   git clone https://github.com/atournayre/claude-plugin ~/PhpstormProjects/claude-plugin
   ```

### Installation automatique

```bash
# Clone ce dépôt
git clone <votre-repo> ~/PhpstormProjects/claude-config
cd ~/PhpstormProjects/claude-config

# Installation (copie vers ~/.claude + installe les alias)
./install.sh

# Activer les alias
source ~/.bashrc  # ou source ~/.zshrc
```

Le script d'installation :
- Copie `docs/` et `mcp/` vers `~/.claude/`
- Copie `settings.json` vers `~/.claude/`
- Installe automatiquement les alias shell

### Commandes du script

```bash
./install.sh install   # Installation complète (défaut)
./install.sh sync      # Synchroniser après modifications
./install.sh backup    # Sauvegarder ~/.claude
./install.sh restore   # Restaurer depuis backup
./install.sh aliases   # Réinstaller uniquement les alias
./install.sh help      # Aide
```

### Alias installés

```bash
# Normal
cc='claude'
cld='claude'

# Yolo (skip permissions)
ccy='claude --dangerously-skip-permissions'
cldy='claude --dangerously-skip-permissions'

# Avec MCP Chrome DevTools
cld-chrome='claude --mcp-config ~/.claude/mcp/chrome-dev-tools.json --strict-mcp-config'
cldy-chrome='...(avec --dangerously-skip-permissions)'

# Avec MCP Sentry
cld-sentry='claude --mcp-config ~/.claude/mcp/sentry.json --strict-mcp-config'
cldy-sentry='...(avec --dangerously-skip-permissions)'
```

## Marketplace claude-plugin

Toutes les fonctionnalités avancées proviennent du [marketplace](https://github.com/atournayre/claude-plugin) composé de **5 plugins modulaires**.

### Plugins disponibles

#### 1. **claude** - Outils de base Claude Code
- `/claude:challenge` - Auto-évaluation des réponses
- `/claude:alias:add` - Créer des alias de commandes
- `/claude:doc:load` - Charger la documentation Claude Code
- `/claude:doc:question` - Interroger la doc locale
- `/claude:make:command` - Générateur de slash commands

#### 2. **customize** - Personnalisation avancée
- **8 hooks système** :
  - `session_start`, `user_prompt_submit`, `pre_tool_use`, `post_tool_use`
  - `pre_compact`, `notification`, `stop`, `subagent_stop`
- **5 status lines** : v1 à v5 (v5 recommandée : historique 3 prompts, coût, Git info)
- **Utilitaires** : LLM helpers, Text-to-Speech

#### 3. **dev** - Développement PHP/Symfony (36+ commandes)
- **Git** : `/git:branch`, `/git:commit`, `/git:pr`, `/git:conflit`, `/git:status`
- **GitHub** : `/github:fix` (correction automatique d'issues)
- **Doc** : `/doc:adr`, `/doc:rtfm`, `/doc:update`
- **Debug** : `/debug:error-fix`, `/debug:stack-trace`
- **QA** : `/qa:phpstan` (résolution automatique niveau 9)
- **Analyse** : `/analyse:impact` (rapports métier/technique)
- **Context** : `/context:default`, `/context:elegant_object`
- **Sessions** : 6 commandes de gestion
- **Frameworks** : Symfony, API Platform, Meilisearch, atournayre-framework
- **Think** : `/think:harder`, `/think:ultra` (analyse approfondie)
- **Workflow** : docker, analytics, question, code, prepare
- **8 agents** : scrapers docs, elegant-objects-reviewer, phpstan-error-resolver, meta-agent
- **2 scripts** : assign_github_project.sh, sync-timing.sh
- **2 templates** : prompt/README.md, timing-section.md

#### 4. **symfony** - Symfony 6.4 complet
- `/symfony:make` - Utilise les makers Symfony
- `/symfony:doc:load` - Doc Symfony locale
- `/symfony:doc:question` - Questions sur la doc
- **Skill complet** : workflows, best practices, références (API Platform, Doctrine, Performance, Security, Testing)

#### 5. **output-styles** - 7 styles de sortie
- **GenUI** : Pages HTML auto-contenues (rapports visuels)
- **Markdown Focused** : Markdown enrichi
- **HTML Structured** : HTML sémantique
- **Table Based** : Format tabulaire
- **Bullet Points** : Listes hiérarchiques
- **Ultra Concise** : Réponses minimales
- **YAML Structured** : Format YAML valide

### Installation des plugins

Les plugins sont automatiquement détectés par Claude Code si placés dans `~/PhpstormProjects/claude-plugin`.

Voir la [documentation complète du marketplace](https://github.com/atournayre/claude-plugin).

## Configuration des permissions

### Permissions Bash

Commandes autorisées dans `settings.json` :

```json
{
  "permissions": {
    "allow": [
      "Bash(./vendor/bin/phpstan:*)",
      "Bash(bin/console:*)",
      "Bash(chmod:*)",
      "Bash(composer:*)",
      "Bash(docker:*)",
      "Bash(git:*)",
      "Bash(gh:*)",
      "Bash(make:*)",
      "Bash(npm:*)",
      "Bash(php:*)",
      "Bash(vendor/bin/*:*)"
    ],
    "deny": [
      "Bash(cd :*data:*)",
      "Bash(cp :*data:*)",
      "Bash(mv :*data:*)",
      "Bash(rm :*data:*)"
    ],
    "defaultMode": "bypassPermissions"
  }
}
```

### Permissions WebFetch

Domaines autorisés :

```json
{
  "permissions": {
    "allow": [
      "WebFetch(domain:docs.anthropic.com)",
      "WebFetch(domain:github.com)",
      "WebFetch(domain:localhost)",
      "WebFetch(domain:meilisearch.com)"
    ]
  }
}
```

## Utilisation

### Workflow recommandé

1. **Démarrer Claude Code** avec un alias :
   ```bash
   cc  # ou cld, ccy, cld-chrome, etc.
   ```

2. **Utiliser les commandes du marketplace** :
   ```bash
   /git:commit                    # Commit conventionnel
   /git:pr                        # Pull Request
   /symfony:make Controller       # Maker Symfony
   /qa:phpstan                    # Fix PHPStan
   /doc:update                    # Doc auto
   ```

3. **Personnaliser avec les hooks** (plugin customize) :
   - Status line v5 pour l'historique et les coûts
   - Notifications système sur événements
   - Hooks pre/post pour validation

### Documentation locale

La documentation est stockée localement dans `docs/` pour un accès hors-ligne :
- API Platform
- atournayre-framework
- Claude Code
- Meilisearch
- Symfony

Charger avec `/[framework]:doc:load`, interroger avec `/[framework]:doc:question`.

### Configurations MCP

Deux configurations disponibles dans `mcp/` :
- **Chrome DevTools** : Debugging navigateur
- **Sentry** : Monitoring erreurs

Utiliser avec `cld-chrome` ou `cld-sentry`.

## Avantages de cette architecture

✅ **Maintenabilité** : Une seule source de vérité (marketplace)
✅ **Réutilisabilité** : Plugins partagés entre projets
✅ **Modularité** : Activer uniquement ce dont on a besoin
✅ **Collaboration** : Améliorer les plugins profite à tous
✅ **Légèreté** : claude-config reste ultra-minimal

## Contribution

### claude-config (ce projet)
Uniquement pour :
- Permissions (settings.json)
- Préférences personnelles (CLAUDE.md)
- Documentation locale (docs/)
- Configurations MCP (mcp/)

### claude-plugin (marketplace)
Pour toutes les fonctionnalités :
- Nouvelles commandes
- Nouveaux agents
- Hooks et status lines
- Output styles
- Scripts et templates

1. Fork [claude-plugin](https://github.com/atournayre/claude-plugin)
2. Créez une branche (`git checkout -b feature/AmazingFeature`)
3. Committez (`git commit -m 'Add AmazingFeature'`)
4. Push (`git push origin feature/AmazingFeature`)
5. Ouvrez une Pull Request

## Support

- Issues : [claude-config](https://github.com/atournayre/claude-config/issues) ou [claude-plugin](https://github.com/atournayre/claude-plugin/issues)
- Documentation marketplace : [claude-plugin](https://github.com/atournayre/claude-plugin)

## Statistiques

**claude-config (minimal)** :
- 2 répertoires copiés (docs, mcp)
- 1 fichier de config (settings.json)
- 1 fichier de préférences (CLAUDE.md)

**claude-plugin (complet)** :
- 5 plugins modulaires
- 43+ slash commands
- 8 agents spécialisés
- 8 hooks système
- 5 status lines
- 7 output styles
- 2 scripts utilitaires
- 2 templates

**Total migré** : 78 fichiers, 11269 lignes (90% de réduction)

## Licence

MIT License

## Remerciements

- [Anthropic](https://www.anthropic.com) pour Claude Code
- La communauté Claude Code pour les contributions
