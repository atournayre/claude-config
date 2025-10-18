# Guide de Migration vers Plugin Claude Code

Ce guide explique comment migrer depuis l'ancienne installation manuelle vers le nouveau système de plugins.

## Table des Matières

- [Contexte](#contexte)
- [Migration Rapide](#migration-rapide)
- [Migration Détaillée](#migration-détaillée)
- [Changements Importants](#changements-importants)
- [Vérification Post-Migration](#vérification-post-migration)
- [Dépannage](#dépannage)

## Contexte

### Avant (Installation Manuelle)

```
~/.claude/
├── commands/          # Copié manuellement via install.sh
├── agents/            # Copié manuellement via install.sh
├── hooks/             # Copié manuellement via install.sh
├── output-styles/     # Copié manuellement via install.sh
├── status_lines/      # Copié manuellement via install.sh
└── logs/              # Logs dans .claude/logs
```

### Après (Plugin)

```
~/.claude/
├── plugins/
│   └── claude-config/           # Plugin installé automatiquement
│       ├── .claude-plugin/
│       ├── commands/            # Slash commands du plugin
│       ├── agents/              # Agents du plugin
│       ├── hooks/               # Hooks du plugin
│       └── scripts/
├── output-styles/               # À installer via install-extras.sh
├── status_lines/                # À installer via install-extras.sh
└── data/
    └── plugins/
        └── claude-config/
            ├── logs/            # Nouveaux logs du plugin
            └── sessions/        # Nouvelles sessions du plugin
```

## Migration Rapide

### Étape 1 : Sauvegarde (IMPORTANT)

```bash
# Sauvegarder votre configuration actuelle
cd ~/.claude
tar -czf ~/claude-backup-$(date +%Y%m%d).tar.gz commands/ agents/ hooks/ output-styles/ status_lines/ settings.json

# Vérifier la sauvegarde
ls -lh ~/claude-backup-*.tar.gz
```

### Étape 2 : Désinstallation Ancienne Config

```bash
# Supprimer les fichiers de l'ancienne installation
rm -rf ~/.claude/commands/
rm -rf ~/.claude/agents/
rm -rf ~/.claude/hooks/

# NE PAS supprimer output-styles et status_lines (on les réutilisera)
# NE PAS supprimer settings.json (on le gardera pour les permissions)
```

### Étape 3 : Installation du Plugin

```bash
# Installer le plugin depuis le marketplace
/plugin install claude-config@marketplace

# Vérifier l'installation
ls ~/.claude/plugins/claude-config/
```

### Étape 4 : Installation des Extras

```bash
# Installer output-styles et status-lines
cd ~/.claude/plugins/claude-config
bash scripts/install-extras.sh
```

### Étape 5 : Configuration des Permissions

Consultez [docs/PERMISSIONS.md](docs/PERMISSIONS.md) et ajoutez les permissions recommandées dans `~/.claude/settings.json`.

### Étape 6 : Vérification

```bash
# Tester une commande
/git:status

# Vérifier les logs du plugin
ls -la ~/.claude/data/plugins/claude-config/logs/
```

## Migration Détaillée

### Sauvegarde Complète

#### 1. Sauvegarder la Configuration

```bash
# Créer répertoire de backup
mkdir -p ~/claude-migration-backup

# Copier toute la configuration
cp -r ~/.claude ~/claude-migration-backup/claude-$(date +%Y%m%d-%H%M%S)

# Lister les sauvegardes
ls -l ~/claude-migration-backup/
```

#### 2. Documenter votre Configuration Actuelle

```bash
# Sauvegarder settings.json (important pour permissions)
cp ~/.claude/settings.json ~/claude-migration-backup/settings.json.bak

# Sauvegarder settings.local.json si existant
if [ -f ~/.claude/settings.local.json ]; then
    cp ~/.claude/settings.local.json ~/claude-migration-backup/settings.local.json.bak
fi

# Noter votre status line actuelle
grep "status_line_hook" ~/.claude/settings.json > ~/claude-migration-backup/status_line.txt
```

### Désinstallation Propre

#### 1. Vérifier ce qui sera supprimé

```bash
# Lister les commandes actuelles
ls ~/.claude/commands/

# Lister les agents actuels
ls ~/.claude/agents/

# Lister les hooks actuels
ls ~/.claude/hooks/
```

#### 2. Désinstaller l'ancienne structure

```bash
# Supprimer commands (seront réinstallés par le plugin)
rm -rf ~/.claude/commands/

# Supprimer agents (seront réinstallés par le plugin)
rm -rf ~/.claude/agents/

# Supprimer hooks (seront réinstallés par le plugin)
rm -rf ~/.claude/hooks/

# Conserver output-styles et status_lines (on les garde pour install-extras.sh)
# Conserver settings.json (contient les permissions)
# Conserver logs (historique)
```

### Installation du Plugin

#### 1. Installer depuis le Marketplace

```bash
# Installation via Claude Code
/plugin install claude-config@marketplace

# OU installation locale pour test (si vous avez le code source)
# mkdir -p ~/.claude/test-marketplace/claude-config
# cp -r /path/to/claude-config/* ~/.claude/test-marketplace/claude-config/
# Puis ajouter dans settings.json :
# "plugin_marketplaces": [{"type": "local", "path": "~/.claude/test-marketplace"}]
# /plugin install claude-config@test-marketplace
```

#### 2. Vérifier l'Installation

```bash
# Vérifier la structure du plugin
ls -la ~/.claude/plugins/claude-config/

# Vérifier plugin.json
cat ~/.claude/plugins/claude-config/.claude-plugin/plugin.json

# Vérifier que les commandes sont disponibles
# Dans Claude Code : taper "/" et vérifier que les commandes apparaissent
```

### Installation des Extras

#### 1. Output Styles et Status Lines

```bash
# Aller dans le répertoire du plugin
cd ~/.claude/plugins/claude-config

# Exécuter le script d'installation
bash scripts/install-extras.sh
```

#### 2. Vérifier l'Installation des Extras

```bash
# Vérifier output-styles
ls ~/.claude/output-styles/

# Vérifier status-lines
ls ~/.claude/status_lines/

# Si la status line v5 est configurée, vérifier qu'elle fonctionne
echo '{"session_id": "test", "model": {"display_name": "Claude"}}' | python3 ~/.claude/status_lines/status_line_v5.py
```

### Configuration Post-Migration

#### 1. Permissions

Ouvrez `~/.claude/settings.json` et ajoutez les permissions recommandées (voir [docs/PERMISSIONS.md](docs/PERMISSIONS.md)) :

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

#### 2. Status Line

Si vous utilisiez une status line personnalisée, mettez à jour le chemin dans `settings.json` :

```json
{
  "status_line_hook": "python3 ~/.claude/status_lines/status_line_v5.py"
}
```

**Note** : Le chemin reste `~/.claude/status_lines/` car les status lines sont installées via `install-extras.sh`.

#### 3. Hooks

Les hooks sont maintenant gérés automatiquement par le plugin via `hooks/hooks.json`.
Vous n'avez rien à configurer manuellement dans `settings.json`.

## Changements Importants

### Paths des Logs

**Avant** :
```
~/.claude/logs/session_start.json
~/.claude/logs/user_prompt_submit.json
~/.claude/logs/stop.json
```

**Après** :
```
~/.claude/data/plugins/claude-config/logs/session_start.json
~/.claude/data/plugins/claude-config/logs/user_prompt_submit.json
~/.claude/data/plugins/claude-config/logs/stop.json
```

### Paths des Sessions

**Avant** :
```
~/.claude/data/sessions/{session_id}.json
```

**Après** :
```
~/.claude/data/plugins/claude-config/sessions/{session_id}.json
```

### Script install.sh

**Avant** : Script `install.sh` pour installation et synchronisation complète

**Après** :
- Installation principale via `/plugin install claude-config@marketplace`
- Script `install-extras.sh` uniquement pour output-styles et status-lines

### Configuration des Hooks

**Avant** : Configuration manuelle dans `settings.json`
```json
{
  "hooks": {
    "session_start": "python3 ~/.claude/hooks/session_start.py"
  }
}
```

**Après** : Configuration automatique via `hooks/hooks.json` du plugin
```json
{
  "session_start": "python3 hooks/session_start.py"
}
```

## Vérification Post-Migration

### Checklist Complète

- [ ] Plugin installé : `ls ~/.claude/plugins/claude-config/`
- [ ] Extras installés : `ls ~/.claude/output-styles/` et `ls ~/.claude/status_lines/`
- [ ] Permissions configurées dans `settings.json`
- [ ] Commandes disponibles : tester `/git:status`
- [ ] Hooks fonctionnels : démarrer une nouvelle session et vérifier les logs
- [ ] Status line fonctionnelle : vérifier l'affichage dans Claude Code
- [ ] Logs créés dans le bon répertoire : `ls ~/.claude/data/plugins/claude-config/logs/`

### Tests Fonctionnels

#### Test 1 : Commandes Git

```bash
/git:status
# Doit afficher le statut Git du projet
```

#### Test 2 : Documentation

```bash
/doc:rtfm https://docs.claude.com/en/docs/claude-code/plugins.md
# Doit charger et analyser la documentation
```

#### Test 3 : Agents

```bash
# Si vous avez un projet PHP avec erreurs PHPStan
/qa:phpstan
# Doit lancer l'agent phpstan-error-resolver
```

#### Test 4 : Hooks

```bash
# Démarrer une nouvelle session Claude Code
# Vérifier que le hook session_start a créé un log :
ls ~/.claude/data/plugins/claude-config/logs/session_start.json

# Soumettre un prompt
# Vérifier que le hook user_prompt_submit a logé :
ls ~/.claude/data/plugins/claude-config/logs/user_prompt_submit.json
```

## Dépannage

### Problème : Commandes non disponibles

**Symptôme** : Les slash commands ne s'affichent pas quand je tape "/"

**Solutions** :
```bash
# 1. Vérifier que le plugin est installé
ls ~/.claude/plugins/claude-config/commands/

# 2. Redémarrer Claude Code
# /clear puis relancer

# 3. Vérifier plugin.json
cat ~/.claude/plugins/claude-config/.claude-plugin/plugin.json
```

### Problème : Hooks ne s'exécutent pas

**Symptôme** : Pas de logs créés dans `~/.claude/data/plugins/claude-config/logs/`

**Solutions** :
```bash
# 1. Vérifier hooks.json
cat ~/.claude/plugins/claude-config/hooks/hooks.json

# 2. Tester un hook manuellement
echo '{"session_id": "test"}' | python3 ~/.claude/plugins/claude-config/hooks/session_start.py

# 3. Vérifier les permissions d'exécution
ls -l ~/.claude/plugins/claude-config/hooks/*.py
```

### Problème : Status line ne s'affiche pas

**Symptôme** : Pas de status line dans l'interface Claude Code

**Solutions** :
```bash
# 1. Vérifier que la status line est installée
ls ~/.claude/status_lines/status_line_v5.py

# 2. Tester la status line manuellement
echo '{"session_id": "test", "model": {"display_name": "Claude"}}' | python3 ~/.claude/status_lines/status_line_v5.py

# 3. Vérifier la configuration dans settings.json
grep "status_line_hook" ~/.claude/settings.json

# 4. Vérifier les dépendances Python
python3 -c "import json, sys, os; from pathlib import Path"
```

### Problème : Permissions refusées

**Symptôme** : Claude demande la permission pour chaque commande Bash

**Solutions** :
```bash
# 1. Vérifier settings.json
cat ~/.claude/settings.json | grep -A 20 "permissions"

# 2. Ajouter les permissions recommandées (voir docs/PERMISSIONS.md)
# Éditer ~/.claude/settings.json

# 3. Redémarrer Claude Code pour appliquer les changements
```

### Problème : Logs dans l'ancien emplacement

**Symptôme** : Les logs sont toujours créés dans `~/.claude/logs/`

**Solutions** :
```bash
# Cela signifie que vous utilisez encore l'ancienne installation
# 1. Vérifier qu'il ne reste pas d'anciens hooks
ls ~/.claude/hooks/

# 2. Supprimer les anciens hooks si présents
rm -rf ~/.claude/hooks/

# 3. Redémarrer Claude Code
```

### Problème : Dépendances Python manquantes

**Symptôme** : Erreurs Python lors de l'exécution des hooks

**Solutions** :
```bash
# Installer les dépendances optionnelles
pip install pyttsx3 python-dotenv

# Ou utiliser un environnement virtuel
python3 -m venv ~/.claude/venv
source ~/.claude/venv/bin/activate
pip install pyttsx3 python-dotenv
```

## Rollback (Retour en Arrière)

Si la migration ne se passe pas bien, vous pouvez revenir à l'ancienne configuration :

```bash
# 1. Désinstaller le plugin
/plugin uninstall claude-config

# 2. Restaurer depuis la sauvegarde
cd ~
tar -xzf claude-backup-YYYYMMDD.tar.gz -C ~/.claude/

# 3. Restaurer settings.json
cp ~/claude-migration-backup/settings.json.bak ~/.claude/settings.json

# 4. Redémarrer Claude Code
```

## Support

Si vous rencontrez des problèmes non couverts par ce guide :

1. Consultez les logs détaillés :
   - `~/.claude/data/plugins/claude-config/logs/`
   - `~/.claude/logs/` (logs système Claude Code)

2. Ouvrez une issue sur GitHub :
   - Repository : https://github.com/atournayre/claude-config
   - Incluez les logs pertinents
   - Décrivez les étapes de migration effectuées

3. Vérifiez la documentation officielle Claude Code :
   - https://docs.claude.com/en/docs/claude-code/plugins.md

## Ressources

- [README.md](README.md) - Documentation complète
- [docs/COMMANDS.md](docs/COMMANDS.md) - Référence des commandes
- [docs/PERMISSIONS.md](docs/PERMISSIONS.md) - Guide des permissions
- [CHANGELOG.md](CHANGELOG.md) - Historique des versions
