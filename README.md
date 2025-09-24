# Configuration Claude Code

Configuration personnelle versionnée pour Claude Code avec des fonctionnalités avancées pour optimiser votre workflow de développement.

## Table des matières

- [Structure du projet](#structure-du-projet)
- [Installation](#installation)
- [Commandes personnalisées](#commandes-personnalisées)
- [Hooks système](#hooks-système)
- [Styles de sortie](#styles-de-sortie)
- [Status Lines](#status-lines)
- [Configuration des permissions](#configuration-des-permissions)
- [Utilisation avancée](#utilisation-avancée)

## Structure du projet

```
claude-config/
├── commands/                 # Commandes personnalisées (slash commands)
│   ├── cc/                   # Méta-commandes Claude Code
│   │   └── make/             # Générateurs de commandes
│   │       └── command.md    # Générateur de slash commands
│   ├── git/                  # Commandes Git
│   │   ├── commit.md         # Création de commit avec workflow
│   │   ├── pr.md             # Création de Pull Request optimisée
│   │   └── status.md         # Affiche le statut Git
│   ├── sessions/             # Gestion des sessions
│   │   ├── current.md        # Affiche la session courante
│   │   ├── end.md            # Termine une session
│   │   ├── help.md           # Aide sur les sessions
│   │   ├── list.md           # Liste toutes les sessions
│   │   ├── start.md          # Démarre une nouvelle session
│   │   └── update.md         # Met à jour une session
│   ├── think/                # Commandes d'analyse
│   │   └── harder.md         # Analyse intensive de problèmes complexes
│   ├── all_tools.md          # Liste tous les outils disponibles
│   ├── analytics.md          # Lance l'analyse d'utilisation Claude Code
│   ├── analytics-stop.md     # Arrête l'analyse en cours
│   ├── build.md              # Workflow de build complet
│   └── question.md           # Pose une question structurée
├── hooks/                    # Scripts de hooks pour automatiser les actions
│   ├── utils/                # Utilitaires partagés
│   │   ├── llm/              # Intégration LLM
│   │   └── tts/              # Text-to-speech
│   ├── notification.py       # Notifications système
│   ├── post_tool_use.py      # Exécuté après l'utilisation d'un outil
│   ├── pre_compact.py        # Avant compactage de session
│   ├── pre_tool_use.py       # Avant l'utilisation d'un outil
│   ├── session_start.py      # Au démarrage de session
│   ├── stop.py               # À l'arrêt
│   ├── subagent_stop.py      # Arrêt de sous-agent
│   └── user_prompt_submit.py # Soumission de prompt
├── scripts/                  # Scripts bash réutilisables
│   └── assign_github_project.sh # Assigne une PR à un projet GitHub
├── output-styles/            # Styles de sortie personnalisés
│   ├── bullet-points.md      # Format liste à puces
│   ├── genui.md              # Interface HTML générée
│   ├── html-structured.md    # HTML structuré
│   ├── markdown-focused.md   # Markdown enrichi
│   ├── table-based.md        # Format tableau
│   ├── ultra-concise.md      # Ultra concis
│   └── yaml-structured.md    # Format YAML
├── status_lines/             # Lignes de statut personnalisées
│   ├── status_line.py        # Version basique
│   ├── status_line_v2.py     # Version 2
│   ├── status_line_v3.py     # Version 3 avec historique
│   ├── status_line_v4.py     # Version 4 améliorée
│   └── status_line_v5.py     # Version 5 complète
├── _templates/               # Templates pour génération
│   └── prompt/README.md      # Template de slash command
├── settings.json             # Configuration principale
├── install.sh                # Script d'installation
└── README.md                 # Ce fichier
```

## Installation

### Installation initiale

```bash
# Clone du dépôt
git clone <votre-repo> claude-config
cd claude-config

# Installation automatique
./install.sh install

# Création de votre configuration locale
cp settings.json settings.local.json
# Éditez settings.local.json selon vos besoins
```

### Commandes du script d'installation

```bash
# Installation complète
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

Le script copie automatiquement vos fichiers vers `~/.claude/` et configure les permissions nécessaires.

### Dépendances optionnelles

#### ccusage (recommandé pour status line v5)

La status line v5 utilise ccusage pour afficher le coût journalier d'utilisation de Claude Code.

```bash
# Installation via npm (recommandé)
npm install -g ccusage

# Vérification de l'installation
ccusage --version

# Test du suivi des coûts
ccusage daily --json
```

**Configuration :**
- ccusage lit automatiquement vos clés API depuis les variables d'environnement
- Configurez `ANTHROPIC_API_KEY` si nécessaire
- Le coût s'affiche avec l'icône 💰 dans la status line

**Sans ccusage :**
- La status line v5 fonctionne normalement
- Le coût journalier n'est simplement pas affiché
- Aucune erreur n'est générée

#### Autres dépendances

```bash
# Pour les hooks TTS (text-to-speech)
pip install pyttsx3

# Pour les hooks avec dotenv
pip install python-dotenv
```

## Commandes personnalisées

Les commandes personnalisées (slash commands) permettent d'étendre les capacités de Claude Code.

### Commandes Git

#### `/git:commit`
**Description** : Création de commit avec workflow structuré

**Format** : Workflow de commit avec conventions et validation
**Usage** : `/git:commit`

#### `/git:pr`
**Description** : Crée une Pull Request optimisée avec workflow complet

**Format** : Workflow structuré incluant QA, commits, milestone et assignation projet
**Usage** : `/git:pr [branch-base] [milestone]`

**Particularités** :
- QA automatique pour fichiers PHP
- Demande confirmation pour branche et milestone
- Utilise le script `scripts/assign_github_project.sh` pour l'assignation

### Commandes Analytics

#### `/analytics`
**Description** : Lance le tableau de bord d'analytics pour visualiser les statistiques d'utilisation de Claude Code

**Format** : Serveur local sur port 3333 avec ouverture automatique du navigateur
**Usage** : `/analytics`

**Particularités** :
- Analyse l'utilisation de Claude Code (prompts, coûts, sessions)
- Vérifie la disponibilité du port 3333
- Ouverture automatique du navigateur
- Serveur reste actif jusqu'à interruption manuelle
- Utilise `claude-code-templates --analytics`

#### `/analytics-stop`
**Description** : Arrête proprement le serveur analytics dashboard de Claude Code

**Format** : Commande de nettoyage pour libérer le port 3333
**Usage** : `/analytics-stop`

**Particularités** :
- Détection automatique du processus sur port 3333
- Arrêt propre avec confirmation
- Messages informatifs si aucun serveur actif

### Commandes Build

#### `/build`
**Description** : Workflow de build complet avec étapes structurées

**Format** : Processus de build avec validation et tests
**Usage** : `/build`

### Commandes Sessions

#### `/sessions:start`
**Description** : Démarre une nouvelle session de travail

**Usage** : `/sessions:start [nom-session]`

#### `/sessions:current`
**Description** : Affiche la session courante avec détails

**Usage** : `/sessions:current`

#### `/sessions:list`
**Description** : Liste toutes les sessions disponibles

**Usage** : `/sessions:list`

#### `/sessions:end`
**Description** : Termine la session courante

**Usage** : `/sessions:end`

#### `/sessions:update`
**Description** : Met à jour les informations de session

**Usage** : `/sessions:update`

#### `/sessions:help`
**Description** : Aide détaillée sur la gestion des sessions

**Usage** : `/sessions:help`

### Commandes CC (Claude Code)

#### `/cc:make:command`
**Description** : Générateur de slash commands pour Claude Code avec workflow structuré

**Format** : Création automatique de commandes bien documentées suivant les conventions
**Usage** : `/cc:make:command [nom-commande] [description] [--tools=outil1,outil2] [--category=categorie]`

**Particularités** :
- Génération automatique de la structure YAML frontmatter
- Respect des conventions de nommage kebab-case
- Détection automatique de catégorie si non fournie
- Inclusion des permissions d'outils appropriées
- Templates adaptés selon le type de commande
- Validation de l'unicité du nom

**Exemples** :
- `/cc:make:command git-hotfix "Création de hotfix avec workflow Git" --tools=Bash,Edit --category=git`
- `/cc:make:command deploy-prod "Déploiement en production" --tools=Bash,Read --category=build`

### Commandes d'analyse

#### `/think:harder`
**Description** : Engage une analyse intensive et systématique pour la résolution de problèmes complexes

**Format** : Applique une méthodologie de raisonnement structurée avec décomposition multi-dimensionnelle
**Usage** : `/think:harder "Votre problème ou question complexe"`

**Particularités** :
- Protocole d'analyse en 4 étapes : clarification, analyse multi-dimensionnelle, évaluation critique, synthèse
- Structure de sortie standardisée avec reformulation, insights, chaîne de raisonnement
- Considération des perspectives multiples et analyse des incertitudes
- Recommandations actionables et implémentables
- Idéal pour les décisions techniques et stratégiques complexes

**Exemples** :
- `/think:harder "Devons-nous refactoriser ce code legacy ou le réécrire ?"`
- `/think:harder "Comment optimiser l'architecture de cette API ?"`
- `/think:harder "Quelle approche adopter pour la migration de données ?"`

### Commandes générales

#### `/all_tools`
**Description** : Liste tous les outils disponibles dans votre système Claude Code

**Format** : Affiche chaque outil avec sa signature TypeScript et sa description

**Usage** : Tapez `/all_tools` dans Claude Code pour obtenir la liste complète

#### `/git_status`
**Description** : Affiche un statut Git détaillé du projet actuel

**Format** : Informations structurées sur la branche, les modifications et l'historique

**Usage** : `/git_status` pour une vue d'ensemble rapide de votre dépôt

#### `/question`
**Description** : Pose une question structurée avec contexte

**Format** : Question formatée avec sections et métadonnées

**Usage** : `/question "Votre question ici"`

## Scripts réutilisables

Le dossier `scripts/` contient des scripts bash modulaires utilisables par les commandes ou indépendamment.

### `assign_github_project.sh`
**Description** : Assigne une Pull Request à un projet GitHub de manière interactive

**Usage** : `./scripts/assign_github_project.sh <PR_NUMBER> [OWNER] [REPO]`

**Fonctionnalités** :
- Récupère automatiquement la liste des projets disponibles
- Filtre les projets fermés
- Interface interactive pour la sélection
- Validation des choix utilisateur
- Messages colorés pour une meilleure lisibilité
- Support des repositories locaux (détection automatique)

## Hooks système

Les hooks permettent d'automatiser des actions à différents moments du cycle de vie de Claude Code.

### Hooks disponibles

#### `session_start.py`
- **Déclencheur** : Au démarrage d'une nouvelle session Claude Code
- **Fonctionnalités** :
  - Enregistre les métadonnées de session dans `logs/session_start.json`
  - Capture l'ID de session, le modèle utilisé, et le timestamp
  - Peut être étendu pour des actions d'initialisation personnalisées

#### `user_prompt_submit.py`
- **Déclencheur** : À chaque soumission de prompt utilisateur
- **Fonctionnalités** :
  - Validation et traitement du prompt avant envoi
  - Peut modifier ou enrichir le prompt
  - Logging des prompts pour analyse

#### `pre_tool_use.py`
- **Déclencheur** : Avant l'exécution de tout outil
- **Fonctionnalités** :
  - Validation des paramètres d'outil
  - Peut bloquer l'exécution si nécessaire
  - Logging des intentions d'utilisation

#### `post_tool_use.py`
- **Déclencheur** : Après l'exécution d'un outil
- **Fonctionnalités** :
  - Traitement des résultats d'outil
  - Notifications en cas d'erreur
  - Statistiques d'utilisation

#### `pre_compact.py`
- **Déclencheur** : Avant le compactage d'une session
- **Fonctionnalités** :
  - Sauvegarde de l'état de session
  - Nettoyage des ressources temporaires

#### `notification.py`
- **Déclencheur** : Sur événements configurables
- **Fonctionnalités** :
  - Notifications système natives
  - Intégration avec services externes
  - Support multi-plateforme

#### `stop.py`
- **Déclencheur** : À l'arrêt de Claude Code
- **Fonctionnalités** :
  - Sauvegarde finale de l'état
  - Nettoyage des ressources
  - Statistiques de session

#### `subagent_stop.py`
- **Déclencheur** : À l'arrêt d'un sous-agent
- **Fonctionnalités** :
  - Gestion des sous-agents
  - Consolidation des résultats

### Utilitaires des hooks

#### `utils/llm/anth.py`
- Intégration avec l'API Anthropic
- Fonctions helper pour les appels LLM
- Gestion du contexte et des tokens

#### `utils/tts/pyttsx3_tts.py`
- Text-to-speech avec pyttsx3
- Lecture vocale des réponses
- Configuration multi-voix

## Styles de sortie

Les styles de sortie définissent comment Claude Code formate ses réponses.

### GenUI (`genui.md`)
**Caractéristiques** :
- Génère des pages HTML complètes auto-contenues
- CSS moderne intégré avec thème cohérent
- Ouvre automatiquement dans le navigateur
- Palette de couleurs professionnelle
- Support des sections info/warning/error
- Responsive design

**Usage idéal** : Rapports, dashboards, présentations visuelles

### Markdown Focused (`markdown-focused.md`)
**Caractéristiques** :
- Markdown enrichi avec formatage avancé
- Tables, listes, et blocs de code
- Emojis et icônes contextuelles
- Sections bien structurées

**Usage idéal** : Documentation, README, notes techniques

### HTML Structured (`html-structured.md`)
**Caractéristiques** :
- HTML sémantique structuré
- Styles inline pour portabilité
- Compatible email
- Sections organisées

**Usage idéal** : Rapports formels, exports

### Table Based (`table-based.md`)
**Caractéristiques** :
- Données en format tabulaire
- Colonnes alignées
- Headers descriptifs
- Support des données complexes

**Usage idéal** : Comparaisons, données structurées

### Bullet Points (`bullet-points.md`)
**Caractéristiques** :
- Listes hiérarchiques
- Points concis
- Sous-niveaux organisés
- Facile à scanner

**Usage idéal** : Résumés, todo lists, outlines

### Ultra Concise (`ultra-concise.md`)
**Caractéristiques** :
- Réponses minimales
- Pas de formatage superflu
- Direct au but
- Maximum d'efficacité

**Usage idéal** : Réponses rapides, confirmations

### YAML Structured (`yaml-structured.md`)
**Caractéristiques** :
- Format YAML valide
- Hiérarchie claire
- Parsable programmatiquement
- Métadonnées incluses

**Usage idéal** : Configuration, API responses, données structurées

## Status Lines

Les status lines affichent des informations contextuelles dans l'interface Claude Code.

### Version 5 (`status_line_v5.py`) - RECOMMANDÉE
**Fonctionnalités complètes** :
- **Historique des prompts** : Affiche les 3 derniers prompts avec hiérarchie visuelle
  - Prompt actuel : Blanc brillant, 70 caractères max
  - Prompt précédent : Gris clair, 50 caractères max
  - Prompt ancien : Gris sombre, 35 caractères max
- **Icônes intelligentes** : Détection automatique du type de prompt
  - 💡 Création/implémentation
  - 🐛 Correction de bugs
  - ♻️ Refactoring
  - 🧪 Tests
  - 🔍 Analyse
  - ⚡ Commandes slash
  - ❓ Questions
- **Informations Git** : Branche, modifications, ahead/behind
- **Coût journalier** : Intégration ccusage pour le suivi des coûts (nécessite `npm install -g ccusage`)
- **Style de sortie actuel** : Affiche le style Claude Code en cours (📝)
- **Agent et modèle** : Affichage conditionnel de l'agent
- **Extras personnalisables** : Clés-valeurs configurables
- **Logging complet** : Enregistrement dans `logs/status_line.json`

**Format** : `[Agent | ]Model | vX.X.X | 🔍 Prompt actuel | 🐛 Prompt précédent | 💡 Prompt ancien… | 💰$X.XX | 📝Style | 🌿branch ~X | key value`

### Version 4 (`status_line_v4.py`)
**Fonctionnalités** :
- Agent, modèle et version
- Prompt unique avec icône
- Informations Git basiques
- Extras simples

### Version 3 (`status_line_v3.py`)
**Fonctionnalités** :
- Historique de 3 prompts
- Couleurs différenciées
- Format plus compact

### Version 2 (`status_line_v2.py`)
**Fonctionnalités** :
- Agent et modèle
- Prompt actuel uniquement
- Format basique

### Version 1 (`status_line.py`)
**Fonctionnalités** :
- Affichage minimal
- Modèle et prompt
- Pas d'extras

### Configuration d'une status line

Dans `settings.json` ou `settings.local.json` :

```json
{
  "status_line_hook": "python3 /chemin/vers/status_lines/status_line_v5.py"
}
```

## Configuration des permissions

Le fichier `settings.json` contient les permissions pour les outils Bash et WebFetch.

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
    ]
  }
}
```

**Explications des permissions** :
- `Bash(git:*)` : Toutes les commandes git
- `Bash(docker:*)` : Docker et docker-compose
- `Bash(composer:*)` : Composer PHP
- `Bash(npm:*)` : NPM
- `Bash(make:*)` : Make
- `Bash(gh:*)` : GitHub CLI
- `Bash(ls:*)` : Navigation
- `Bash(mkdir:*)` : Création de dossiers
- `Bash(php:*)` : PHP et outils associés
- `Bash(vendor/bin/*:*)` : Binaires vendor PHP

### Permissions WebFetch

```json
{
  "permissions": {
    "allow": [
      "WebFetch(domain:docs.anthropic.com)",
      "WebFetch(domain:github.com)",
      "WebFetch(domain:localhost)"
    ]
  }
}
```

### Permissions refusées

Configurez les outils à bloquer dans la section `deny`.

## Utilisation avancée

### Workflow recommandé

1. **Démarrage de session** :
   - Le hook `session_start.py` s'exécute
   - La status line v5 affiche les informations de contexte
   - Les logs commencent l'enregistrement

2. **Pendant le développement** :
   - Utilisez `/git_status` pour des mises à jour rapides
   - La status line affiche l'historique des 3 derniers prompts
   - Les hooks pre/post surveillent l'utilisation des outils

3. **Génération de rapports** :
   - Activez le style GenUI pour des rapports visuels
   - Les pages HTML s'ouvrent automatiquement
   - Format auto-contenu pour le partage

### Personnalisation

#### Créer un nouveau hook

1. Créez un fichier Python dans `hooks/`
2. Implémentez la logique du hook
3. Ajoutez la configuration dans `settings.json`

```python
#!/usr/bin/env python3
import json
import sys

def main():
    # Lire l'input JSON
    input_data = json.loads(sys.stdin.read())
    
    # Votre logique ici
    
    # Retourner le résultat
    print(json.dumps({"status": "ok"}))
    sys.exit(0)

if __name__ == "__main__":
    main()
```

#### Créer un nouveau style

1. Créez un fichier `.md` dans `output-styles/`
2. Ajoutez les métadonnées YAML en header
3. Définissez les instructions de formatage

```markdown
---
name: MonStyle
description: Description de mon style
---

Instructions de formatage ici...
```

#### Créer une nouvelle status line

1. Copiez `status_line_v5.py` comme base
2. Modifiez la fonction `generate_status_line()`
3. Testez avec : `echo '{"session_id": "test", "model": {"display_name": "Claude"}}' | python3 votre_status_line.py`

### Debugging

#### Logs disponibles

- `logs/status_line.json` : Historique des status lines
- `logs/session_start.json` : Démarrages de session
- `.claude/logs/` : Logs système Claude Code

#### Test des hooks

```bash
# Tester un hook manuellement
echo '{"test": "data"}' | python3 hooks/votre_hook.py
```

#### Test des status lines

```bash
# Créer un fichier de session test
mkdir -p .claude/data/sessions
echo '{"agent_name": "Test", "prompts": ["Test prompt"], "extras": {"key": "value"}}' > .claude/data/sessions/test.json

# Tester la status line
echo '{"session_id": "test", "model": {"display_name": "Claude"}}' | python3 status_lines/status_line_v5.py
```

### Bonnes pratiques

1. **Versionnement** : Committez régulièrement vos changements
2. **Settings local** : Utilisez `settings.local.json` pour vos paramètres personnels
3. **Logs** : Consultez régulièrement les logs pour le debugging
4. **Backup** : Utilisez `./install.sh backup` avant les changements majeurs
5. **Documentation** : Documentez vos hooks et styles personnalisés

## Contribution

Pour contribuer à cette configuration :

1. Fork le repository
2. Créez une branche feature (`git checkout -b feature/AmazingFeature`)
3. Committez vos changements (`git commit -m 'Add AmazingFeature'`)
4. Push vers la branche (`git push origin feature/AmazingFeature`)
5. Ouvrez une Pull Request

## Support

Pour toute question ou problème :
- Ouvrez une issue sur GitHub
- Consultez les logs dans `logs/` et `.claude/logs/`
- Vérifiez la configuration dans `settings.json`

## Licence

Ce projet est sous licence MIT - voir le fichier LICENSE pour plus de détails.

## Remerciements

- Anthropic pour Claude Code
- La communauté Claude Code pour les idées et contributions
