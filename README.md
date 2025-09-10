# Configuration Claude Code

Configuration personnelle versionnée pour Claude Code.

## Structure

```
claude-config/
├── output-styles/         # Styles de sortie personnalisés
├── hooks/                 # Scripts de hooks
├── settings.local.json    # Vos paramètres personnels (ignoré par Git)
├── install.sh             # Script d'installation
└── README.md              # Ce fichier
```

## Installation

```bash
# Installation initiale
./install.sh

# Ou explicitement
./install.sh install
```

## Utilisation

```bash
# Synchroniser après modifications
./install.sh sync

# Sauvegarder la config actuelle
./install.sh backup

# Restaurer depuis la dernière sauvegarde
./install.sh restore

# Aide
./install.sh help
```

Le script copie vos fichiers de configuration vers `~/.claude/`. 

**Configuration personnelle :**
1. Modifiez `settings.local.json` selon vos besoins
2. Utilisez `./install.sh sync` pour appliquer les changements
