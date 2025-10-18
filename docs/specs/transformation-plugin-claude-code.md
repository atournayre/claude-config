# Plan d'Implémentation : Transformation du Projet en Plugin Claude Code

## Problématique

Le projet `claude-config` est actuellement une configuration personnalisée pour Claude Code qui nécessite un script d'installation manuel (`install.sh`) pour copier les fichiers dans `~/.claude/`. Cette approche présente plusieurs limitations :

- Installation manuelle et répétitive
- Synchronisation manuelle nécessaire après chaque modification
- Difficulté de partage entre projets et équipes
- Pas de gestion de version intégrée
- Configuration non distribuable via marketplace

## Objectif

Transformer le projet en un plugin Claude Code officiel distributable via marketplace, permettant :

- Installation via `/plugin install claude-config@marketplace`
- Mise à jour automatique via système de plugins
- Partage facilité entre équipes
- Gestion de versions avec semantic versioning
- Configuration réutilisable cross-projet

## Architecture Technique

### Structure Cible du Plugin

```
claude-config/
├── .claude-plugin/
│   └── plugin.json              # Métadonnées du plugin
├── commands/                    # Slash commands (inchangé)
│   ├── git/
│   ├── doc/
│   ├── debug/
│   └── ...
├── agents/                      # Agents personnalisés (inchangé)
│   ├── phpstan-error-resolver.md
│   ├── elegant-objects-reviewer.md
│   └── ...
├── hooks/                       # Hooks système (inchangé)
│   ├── hooks.json               # Configuration des hooks
│   ├── session_start.py
│   ├── user_prompt_submit.py
│   └── ...
├── output-styles/               # Styles de sortie (à déplacer dans .claude)
│   └── ...
├── status_lines/                # Status lines (à déplacer dans .claude)
│   └── ...
├── scripts/                     # Scripts bash réutilisables
│   └── assign_github_project.sh
├── .mcp.json                    # Configuration MCP si nécessaire
├── README.md                    # Documentation du plugin
└── CHANGELOG.md                 # Historique des versions
```

### Fichier `plugin.json`

```json
{
  "name": "claude-config",
  "version": "1.0.0",
  "description": "Configuration avancée pour Claude Code avec commandes Git, documentation, analyse, et workflows Symfony/PHP",
  "author": "Aurélien Tournayre <aurelien.tournayre@gmail.com>",
  "homepage": "https://github.com/atournayre/claude-config",
  "keywords": ["git", "symfony", "php", "documentation", "workflow", "elegant-objects"],
  "license": "MIT",
  "dependencies": {}
}
```

## Plan d'Implémentation Détaillé

### Phase 1 : Restructuration

#### Étape 1.1 : Créer la structure plugin

- Créer le répertoire `.claude-plugin/`
- Créer `plugin.json` avec métadonnées initiales
- Versionner à `1.0.0`

#### Étape 1.2 : Adapter la configuration des hooks

Créer `hooks/hooks.json` :

```json
{
  "session_start": "python3 hooks/session_start.py",
  "user_prompt_submit": "python3 hooks/user_prompt_submit.py",
  "pre_tool_use": "python3 hooks/pre_tool_use.py",
  "post_tool_use": "python3 hooks/post_tool_use.py",
  "pre_compact": "python3 hooks/pre_compact.py",
  "stop": "python3 hooks/stop.py",
  "subagent_stop": "python3 hooks/subagent_stop.py"
}
```

#### Étape 1.3 : Gérer les output-styles et status_lines

**Problématique** : Ces éléments doivent être dans `~/.claude/` et ne peuvent pas être distribués via plugin

**Solution** :
- Créer un script d'installation complémentaire `scripts/install-extras.sh`
- Documenter dans README.md la nécessité d'exécuter ce script post-installation
- Conserver `install.sh` comme option alternative pour installation complète

#### Étape 1.4 : Nettoyer les fichiers inutiles

Fichiers à supprimer ou déplacer :
- `.git/` : conserver (versioning nécessaire)
- `.gitignore` : conserver
- `settings.json` : **À ANALYSER** - peut-être à transformer en template
- `settings.local.json` : ignorer du plugin
- `logs/` : ignorer du plugin
- `.idea/` : ignorer du plugin

### Phase 2 : Configuration des Permissions

#### Étape 2.1 : Permissions Bash

Les permissions actuelles doivent être documentées dans README.md mais ne peuvent pas être forcées par le plugin. L'utilisateur doit les configurer manuellement.

Créer `docs/PERMISSIONS.md` avec les permissions recommandées :

```markdown
# Permissions Recommandées

Ajoutez ces permissions à votre `~/.claude/settings.json` :

```json
{
  "permissions": {
    "allow": [
      "Bash(git:*)",
      "Bash(gh:*)",
      "Bash(docker:*)",
      "Bash(composer:*)",
      "Bash(npm:*)",
      "Bash(make:*)",
      "Bash(php:*)",
      "Bash(vendor/bin/*:*)",
      "WebFetch(domain:docs.anthropic.com)",
      "WebFetch(domain:github.com)",
      "WebFetch(domain:localhost)"
    ]
  }
}
```
```

#### Étape 2.2 : Configuration MCP

Si des serveurs MCP sont nécessaires, créer `.mcp.json` :

```json
{
  "servers": {}
}
```

### Phase 3 : Documentation

#### Étape 3.1 : Mettre à jour README.md

Restructurer pour audience marketplace :

1. **Section Installation** - mettre en avant l'installation via plugin
2. **Section Configuration** - permissions et extras
3. **Section Utilisation** - guide rapide des commandes principales
4. **Section Référence** - lien vers COMMANDS.md

#### Étape 3.2 : Créer CHANGELOG.md

```markdown
# Changelog

## [1.0.0] - 2025-10-16

### Added
- Transformation initiale en plugin Claude Code
- 42 commandes personnalisées organisées par namespace
- 8 agents spécialisés
- 7 hooks système
- Scripts bash réutilisables

### Changed
- Migration depuis installation manuelle vers système de plugins
- Documentation réorganisée pour marketplace

### Migration Notes
- Les utilisateurs existants doivent désinstaller l'ancienne configuration manuelle
- Exécuter `scripts/install-extras.sh` après installation du plugin pour status lines et output styles
```

#### Étape 3.3 : Créer MIGRATION.md

Guide pour utilisateurs existants :

```markdown
# Guide de Migration

## Depuis configuration manuelle

1. Désinstaller l'ancienne configuration :
   ```bash
   rm -rf ~/.claude/commands/
   rm -rf ~/.claude/agents/
   rm -rf ~/.claude/hooks/
   ```

2. Installer le plugin :
   ```
   /plugin install claude-config@marketplace
   ```

3. Installer les extras (status lines, output styles) :
   ```bash
   cd ~/.claude/plugins/claude-config/
   bash scripts/install-extras.sh
   ```

4. Configurer les permissions (voir PERMISSIONS.md)
```

### Phase 4 : Tests et Validation

#### Étape 4.1 : Créer une marketplace de test

Selon la documentation Claude Code :

```bash
mkdir -p ~/.claude/test-marketplace/claude-config
cp -r . ~/.claude/test-marketplace/claude-config/
```

Configurer `~/.claude/settings.json` :

```json
{
  "plugin_marketplaces": [
    {
      "type": "local",
      "path": "~/.claude/test-marketplace"
    }
  ]
}
```

#### Étape 4.2 : Tests d'installation

1. Installer via `/plugin install claude-config@test-marketplace`
2. Vérifier que toutes les commandes sont disponibles
3. Tester les agents
4. Vérifier les hooks
5. Valider les scripts

#### Étape 4.3 : Tests fonctionnels

Tester chaque namespace de commandes :

- `/git:status` - vérification Git
- `/doc:rtfm` - lecture documentation
- `/debug:error-fix` - analyse d'erreurs
- `/qa:phpstan` - agent PHPStan
- `/symfony:make` - makers Symfony
- `/think:harder` - analyse complexe

#### Étape 4.4 : Tests d'upgrade

1. Modifier `plugin.json` version → `1.0.1`
2. Modifier un fichier de commande
3. Synchroniser marketplace test
4. Tester `/plugin update claude-config`
5. Vérifier que les modifications sont appliquées

### Phase 5 : Publication

#### Étape 5.1 : Préparer le repository GitHub

- Tag version `v1.0.0`
- Release GitHub avec notes du CHANGELOG
- Assets : aucun (plugin distribué via git)

#### Étape 5.2 : Soumettre au marketplace Claude Code

**Note** : Processus exact à déterminer selon documentation officielle Anthropic

#### Étape 5.3 : Communication

- Annoncer la disponibilité du plugin
- Publier guide de migration pour utilisateurs existants
- Mettre à jour documentation personnelle

## Défis Techniques et Solutions

### Défi 1 : Output Styles et Status Lines

**Problème** : Ces fichiers doivent être dans `~/.claude/` et ne peuvent pas être dans le plugin

**Solution** :
- Conserver `scripts/install-extras.sh` pour installation post-plugin
- Documenter clairement cette étape supplémentaire
- Alternative : instruction manuelle de copie dans README

### Défi 2 : Settings.json

**Problème** : `settings.json` contient des permissions spécifiques qui ne peuvent pas être forcées

**Solution** :
- Créer `settings.template.json` comme référence
- Documenter dans `PERMISSIONS.md`
- Fournir snippet copy-paste pour faciliter configuration

### Défi 3 : Dépendances système

**Problème** : Certains hooks nécessitent `pyttsx3`, `python-dotenv`, `ccusage`

**Solution** :
- Documenter dans README section "Dépendances optionnelles"
- Hooks doivent gérer gracefully l'absence de dépendances
- Ajouter vérifications dans hooks :

```python
try:
    import pyttsx3
    TTS_AVAILABLE = True
except ImportError:
    TTS_AVAILABLE = False
```

### Défi 4 : Paths absolus dans hooks

**Problème** : Certains hooks utilisent des paths absolus

**Solution** :
- Utiliser `__file__` pour détecter path du plugin
- Construire paths relatifs dynamiquement :

```python
import os
PLUGIN_DIR = os.path.dirname(os.path.dirname(__file__))
LOGS_DIR = os.path.join(PLUGIN_DIR, "logs")
```

### Défi 5 : Logs et données temporaires

**Problème** : `logs/` ne peut pas être dans le plugin (read-only après installation)

**Solution** :
- Créer logs dans `~/.claude/data/plugins/claude-config/logs/`
- Modifier tous les hooks pour utiliser ce path

## Tests de Non-Régression

### Checklist Complète

- [ ] Installation propre du plugin
- [ ] 42 commandes fonctionnelles
- [ ] 8 agents disponibles et fonctionnels
- [ ] 7 hooks s'exécutent correctement
- [ ] Scripts bash exécutables
- [ ] Permissions documentées et testées
- [ ] Output styles installés (via script extra)
- [ ] Status lines fonctionnelles (via script extra)
- [ ] Logs créés dans bon répertoire
- [ ] Upgrade de version fonctionnel
- [ ] Désinstallation propre

### Scénarios de Test

#### Test 1 : Installation Fresh
```bash
/plugin install claude-config@marketplace
cd ~/.claude/plugins/claude-config
bash scripts/install-extras.sh
# Vérifier /git:status fonctionne
```

#### Test 2 : Commandes Git
```bash
/git:status
/git:branch main test-feature
/git:commit "test: validation plugin"
```

#### Test 3 : Documentation
```bash
/doc:rtfm https://docs.claude.com/en/docs/claude-code/plugins.md
/symfony:doc:question "Comment créer un service?"
```

#### Test 4 : Agents
```bash
/qa:phpstan
# Vérifier que l'agent phpstan-error-resolver est lancé
```

#### Test 5 : Hooks
```bash
# Démarrer nouvelle session → vérifier session_start hook
# Soumettre prompt → vérifier user_prompt_submit hook
# Utiliser outil → vérifier pre/post_tool_use hooks
```

## Critères de Succès

### Critères Fonctionnels

1. **Installation simplifiée** : `/plugin install claude-config` suffit pour 95% des fonctionnalités
2. **Toutes les commandes disponibles** : 42 commandes accessibles immédiatement
3. **Agents fonctionnels** : 8 agents peuvent être lancés sans erreur
4. **Hooks actifs** : 7 hooks s'exécutent aux bons moments
5. **Documentation claire** : README explique installation et configuration en < 5 minutes

### Critères Techniques

1. **Compatibilité** : Fonctionne sur Linux, macOS, Windows (avec adaptations paths)
2. **Pas d'erreurs** : Aucune erreur Python dans les hooks
3. **Logs propres** : Logs créés dans `~/.claude/data/plugins/claude-config/`
4. **Permissions documentées** : Liste complète dans PERMISSIONS.md
5. **Versioning** : Semantic versioning respecté

### Critères d'Adoption

1. **Migration facilitée** : Guide de migration clair pour utilisateurs existants
2. **Dépendances optionnelles** : Plugin fonctionne sans dépendances (mode dégradé acceptable)
3. **Feedback utilisateur** : Collecte feedback sur installation et usage
4. **Maintenance** : Plan de release pour corrections et nouvelles fonctionnalités

## Timeline Estimé

| Phase | Durée Estimée | Tâches Principales |
|-------|---------------|-------------------|
| Phase 1 : Restructuration | 2-3 heures | Structure plugin, hooks.json, nettoyage |
| Phase 2 : Permissions | 1 heure | Documentation permissions, .mcp.json |
| Phase 3 : Documentation | 2-3 heures | README, CHANGELOG, MIGRATION, PERMISSIONS |
| Phase 4 : Tests | 3-4 heures | Marketplace test, tests fonctionnels, validation |
| Phase 5 : Publication | 1-2 heures | GitHub release, soumission marketplace |
| **Total** | **9-13 heures** | |

## Risques et Mitigation

### Risque 1 : Incompatibilité marketplace

**Impact** : Élevé
**Probabilité** : Moyenne
**Mitigation** : Tester avec marketplace locale avant soumission officielle

### Risque 2 : Paths absolus cassés

**Impact** : Élevé
**Probabilité** : Moyenne
**Mitigation** : Utiliser paths relatifs dynamiques dans tous les hooks/scripts

### Risque 3 : Dépendances manquantes

**Impact** : Moyen
**Probabilité** : Élevée
**Mitigation** : Documenter clairement, gérer gracefully les imports manquants

### Risque 4 : Migration utilisateurs existants

**Impact** : Moyen
**Probabilité** : Moyenne
**Mitigation** : Guide de migration détaillé, support direct si nécessaire

### Risque 5 : Logs en conflit

**Impact** : Faible
**Probabilité** : Faible
**Mitigation** : Utiliser répertoire dédié dans `~/.claude/data/plugins/`

## Prochaines Étapes Immédiates

1. Créer `.claude-plugin/plugin.json` avec métadonnées
2. Créer `hooks/hooks.json` avec configuration hooks
3. Adapter tous les paths dans hooks pour être relatifs
4. Créer `scripts/install-extras.sh` pour output-styles et status-lines
5. Créer `docs/PERMISSIONS.md` avec permissions recommandées
6. Mettre à jour README.md pour audience marketplace
7. Créer CHANGELOG.md avec version 1.0.0
8. Créer MIGRATION.md pour utilisateurs existants
9. Configurer marketplace de test locale
10. Tester installation complète

## Références

- [Documentation Plugins Claude Code](https://docs.claude.com/en/docs/claude-code/plugins.md)
- [Structure actuelle du projet](../README.md)
- [Documentation des commandes](../docs/COMMANDS.md)
