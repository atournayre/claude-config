# Configuration Claude Code

Configuration personnelle minimale pour Claude Code. Ce projet s'appuie sur le marketplace [claude-plugin](https://github.com/atournayre/claude-plugin) pour toutes les fonctionnalités avancées.

## Table des matières

- [Structure du projet](#structure-du-projet)
- [Installation](#installation)
- [Marketplace claude-plugin](#marketplace-claude-plugin)
- [Configuration des permissions](#configuration-des-permissions)

## Structure du projet

```
claude-config/
├── docs/                   # Documentation locale
│   ├── api-platform/       # Docs API Platform
│   ├── atournayre-framework/ # Docs atournayre-framework
│   ├── claude/             # Docs Claude Code
│   ├── meilisearch/        # Docs Meilisearch
│   └── symfony/            # Docs Symfony
├── mcp/                    # Configurations MCP
│   ├── chrome-dev-tools.json # Chrome DevTools MCP
│   └── sentry.json         # Sentry MCP
├── _templates/             # Templates pour génération
│   └── prompt/README.md    # Template de slash command
├── settings.json           # Configuration principale
├── CLAUDE.md               # Préférences utilisateur
└── README.md               # Ce fichier
```

## Installation

### Installation initiale

```bash
# Clone du dépôt
git clone <votre-repo> claude-config
cd claude-config

# Installation automatique
./install.sh

# Activer les alias
source ~/.bashrc  # ou source ~/.zshrc
```

Le script copie automatiquement la configuration vers `~/.claude/`.

### Commandes du script d'installation

```bash
# Installation complète
./install.sh
# ou
./install.sh install

# Synchroniser après modifications
./install.sh sync

# Sauvegarder la configuration actuelle
./install.sh backup

# Restaurer depuis la dernière sauvegarde
./install.sh restore

# Aide
./install.sh help
```

### Alias Claude Code disponibles

```bash
# Alias Claude Code
alias cc='claude'
alias ccy='claude --dangerously-skip-permissions'

alias cld='claude'
alias cldy='claude --dangerously-skip-permissions'

alias cld-chrome='claude --mcp-config ~/.claude/mcp/chrome-dev-tools.json --strict-mcp-config'
alias cldy-chrome='claude --mcp-config ~/.claude/mcp/chrome-dev-tools.json --strict-mcp-config --dangerously-skip-permissions'

alias cld-sentry='claude --mcp-config ~/.claude/mcp/sentry.json --strict-mcp-config'
alias cldy-sentry='claude --mcp-config ~/.claude/mcp/sentry.json --strict-mcp-config --dangerously-skip-permissions'
```

## Marketplace claude-plugin

Ce projet utilise le [marketplace claude-plugin](https://github.com/atournayre/claude-plugin) qui fournit :

### Plugins disponibles

1. **claude** - Fonctionnalités de base
   - `/claude:challenge` - Évaluation de réponses
   - `/claude:alias:add` - Créer des alias
   - `/claude:doc:load` - Charger doc Claude Code
   - `/claude:doc:question` - Interroger doc Claude Code
   - `/claude:make:command` - Générateur de commandes

2. **customize** - Personnalisation
   - 8 hooks système (session, tools, notifications)
   - 5 status lines (v1 à v5)
   - Utilitaires (LLM, TTS)

3. **dev** - Développement PHP/Symfony
   - **Git** : branch, commit, pr, conflit, status
   - **GitHub** : fix
   - **Doc** : adr, rtfm, update
   - **Debug** : error-fix, stack-trace
   - **QA** : phpstan
   - **Analyse** : impact
   - **Context** : default, elegant_object
   - **Sessions** : start, current, list, end, update, help
   - **Frameworks** : symfony, api-platform, meilisearch, atournayre-framework
   - **Think** : harder, ultra
   - **Workflow** : docker, analytics, question, code, prepare
   - **8 agents spécialisés** : scrapers docs, reviewers, error resolvers
   - **1 script** : assign_github_project.sh

4. **symfony** - Symfony 6.4
   - `/symfony:make` - Makers Symfony
   - `/symfony:doc:load` - Doc Symfony
   - `/symfony:doc:question` - Questions doc
   - **Skill complet** : workflows, best practices, références

5. **output-styles** - Styles de sortie
   - GenUI, Markdown, HTML, Table, Bullet points, Ultra concise, YAML

### Installation du marketplace

```bash
# Clone le marketplace
git clone https://github.com/atournayre/claude-plugin ~/PhpstormProjects/claude-plugin

# Installe les plugins via Claude Code
# Les plugins seront disponibles automatiquement
```

Voir la [documentation complète du marketplace](https://github.com/atournayre/claude-plugin).

## Configuration des permissions

Le fichier `settings.json` contient uniquement les permissions pour les outils Bash et WebFetch.

### Permissions Bash autorisées

```json
{
  "permissions": {
    "allow": [
      "Bash(git:*)",
      "Bash(docker:*)",
      "Bash(composer:*)",
      "Bash(npm:*)",
      "Bash(make:*)",
      "Bash(gh:*)",
      "Bash(ls:*)",
      "Bash(mkdir:*)",
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

## Contribution

Pour contribuer :

1. Fork le repository
2. Créez une branche feature (`git checkout -b feature/AmazingFeature`)
3. Committez (`git commit -m 'Add AmazingFeature'`)
4. Push (`git push origin feature/AmazingFeature`)
5. Ouvrez une Pull Request

## Support

- Ouvrez une issue sur GitHub
- Consultez la [documentation du marketplace](https://github.com/atournayre/claude-plugin)

## Licence

MIT License

## Remerciements

- Anthropic pour Claude Code
- La communauté Claude Code
