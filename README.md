# Configuration Claude Code

Configuration personnelle minimale pour Claude Code.

## Table des matières

- [Structure](#structure)
- [Installation](#installation)
- [Configuration](#configuration)
- [Utilisation](#utilisation)

## Structure

```
claude-config/
├── docs/          # Documentation locale (API Platform, Symfony, Meilisearch, etc.)
├── mcp/           # Configurations MCP (Chrome DevTools, Sentry)
├── settings.json  # Permissions Bash et WebFetch
├── CLAUDE.md      # Préférences utilisateur et conventions de code
└── install.sh     # Script d'installation
```

## Installation

### Prérequis

Claude Code installé

### Installation automatique

```bash
# Clone et installation
git clone <votre-repo> claude-config
cd claude-config
./install.sh

# Activer les alias
source ~/.bashrc  # ou source ~/.zshrc
```

Le script :
- Copie `docs/` et `mcp/` vers `~/.claude/`
- Copie `settings.json` vers `~/.claude/`
- Installe les alias shell

### Commandes disponibles

```bash
./install.sh install   # Installation complète (défaut)
./install.sh sync      # Synchroniser
./install.sh backup    # Sauvegarder ~/.claude
./install.sh restore   # Restaurer
./install.sh aliases   # Réinstaller alias
./install.sh help      # Aide
```

### Alias installés

```bash
cc='claude'                          # Normal
ccy='claude --dangerously-skip-permissions'  # Yolo

cld-chrome='claude --mcp-config ~/.claude/mcp/chrome-dev-tools.json --strict-mcp-config'
cld-sentry='claude --mcp-config ~/.claude/mcp/sentry.json --strict-mcp-config'
```

## Configuration

### Permissions Bash

Configurées dans `settings.json` :

```json
{
  "permissions": {
    "allow": [
      "Bash(git:*)",
      "Bash(docker:*)",
      "Bash(composer:*)",
      "Bash(gh:*)",
      "Bash(php:*)",
      "Bash(vendor/bin/*:*)"
    ],
    "deny": [
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

### Préférences utilisateur

Configurées dans `CLAUDE.md` :
- Style de communication
- Conventions de code
- Principes Elegant Objects
- Règles de tests

## Utilisation

### Documentation locale

Documentation hors-ligne dans `docs/` :
- API Platform
- atournayre-framework
- Claude Code
- Meilisearch
- Symfony

### Configurations MCP

Deux configurations dans `mcp/` :
- **chrome-dev-tools.json** : Debugging navigateur
- **sentry.json** : Monitoring erreurs

Utiliser avec `cld-chrome` ou `cld-sentry`.

## Fonctionnalités avancées

Pour des fonctionnalités avancées (commandes, agents, hooks, etc.), consulter le [marketplace claude-marketplace](https://github.com/atournayre/claude-marketplace).

## Contribution

1. Fork le repository
2. Créez une branche (`git checkout -b feature/AmazingFeature`)
3. Committez (`git commit -m 'Add AmazingFeature'`)
4. Push (`git push origin feature/AmazingFeature`)
5. Ouvrez une Pull Request

## Licence

MIT License
