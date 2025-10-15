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
│   │   ├── make/             # Générateurs de commandes
│   │   │   └── command.md    # Générateur de slash commands
│   │   └── challenge.md      # Auto-évaluation des réponses
│   ├── debug/                # Commandes de diagnostic
│   │   ├── error-fix.md      # Analyse et résolution d'erreurs
│   │   └── stack-trace.md    # Analyse de stack trace avec rapport détaillé
│   ├── doc/                  # Commandes de documentation
│   │   ├── adr.md            # Architecture Decision Record (ADR)
│   │   ├── rtfm.md           # Lecture de documentation technique
│   │   └── update.md         # Documentation de fonctionnalité
│   ├── git/                  # Commandes Git
│   │   ├── commit.md         # Création de commit avec workflow
│   │   ├── conflit.md        # Résolution interactive de conflits git
│   │   ├── pr.md             # Création de Pull Request optimisée
│   │   └── status.md         # Affiche le statut Git
│   ├── load/                 # Commandes de chargement de documentation
│   │   └── doc/              # Documentation externe
│   │       ├── api-platform.md      # Charge doc API Platform
│   │       ├── atournayre-framework.md  # Charge doc atournayre-framework
│   │       ├── claude.md     # Charge doc Claude Code
│   │       ├── meilisearch.md # Charge doc Meilisearch
│   │       └── symfony.md    # Charge doc Symfony
│   ├── qa/                   # Commandes de qualité de code
│   │   └── phpstan.md        # Résolution automatique erreurs PHPStan
│   ├── sessions/             # Gestion des sessions
│   │   ├── current.md        # Affiche la session courante
│   │   ├── end.md            # Termine une session
│   │   ├── help.md           # Aide sur les sessions
│   │   ├── list.md           # Liste toutes les sessions
│   │   ├── start.md          # Démarre une nouvelle session
│   │   └── update.md         # Met à jour une session
│   ├── think/                # Commandes d'analyse
│   │   ├── harder.md         # Analyse intensive de problèmes complexes
│   │   └── ultra.md          # Analyse ultra-comprehensive pour problèmes très complexes
│   ├── all_tools.md          # Liste tous les outils disponibles
│   ├── analytics.md          # Lance l'analyse d'utilisation Claude Code
│   ├── analytics-stop.md     # Arrête l'analyse en cours
│   ├── build.md              # Workflow de build complet
│   ├── quick-plan.md         # Génère un plan d'implémentation technique
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

### Organisation des namespaces

Les commandes sont organisées par namespaces (espaces de noms) pour regrouper les fonctionnalités similaires :

- **git:** - Opérations Git (commit, pr, branch, conflit, status)
- **github:** - Intégration GitHub (fix)
- **sessions:** - Gestion des sessions (start, current, list, end, update, help)
- **cc:** - Méta-commandes Claude Code (make:command, challenge)
- **doc:** - Documentation (adr, rtfm, update)
- **debug:** - Diagnostic et débogage (error-fix, stack-trace)
- **qa:** - Qualité de code (phpstan)
- **think:** - Analyse approfondie (harder, ultra)
- **load:doc:** - Chargement de documentation externe (meilisearch, symfony, api-platform, claude, atournayre-framework)
- **context:** - Chargement de contexte (default, elegant_object)
- **analyse:** - Analyse de code (impact)
- **build:** - Construction et planification (build, quick-plan)

Les commandes sans namespace (analytics, question, all_tools) sont des commandes générales.

### Commandes Git

#### `/git:branch`
**Description** : Création de branche Git avec workflow structuré

**Format** : Workflow de création de branche avec support des issues GitHub
**Usage** : `/git:branch <source-branch> [issue-number-or-text]`

**Particularités** :
- Validation de l'existence de la branche source
- Checkout automatique vers la branche source avant création
- Pull automatique pour partir du dernier commit
- Génération automatique du nom de branche depuis issue GitHub ou texte
- Détection automatique entre numéro d'issue et texte descriptif
- Conventions de nommage : `issue/123-description` ou `feature/description`
- Le tracking remote sera configuré lors du premier push avec `-u`

**Exemples** :
- `/git:branch main 42` - Crée depuis main avec issue #42
- `/git:branch main "Add login form"` - Crée feature/add-login-form
- `/git:branch develop` - Crée depuis develop (nom demandé)

#### `/git:commit`
**Description** : Création de commit avec workflow structuré

**Format** : Workflow de commit avec conventions et validation
**Usage** : `/git:commit [message] | --no-verify`

#### `/git:conflit`
**Description** : Résolution interactive de conflits git avec validation pas à pas

**Format** : Analyse et guide la résolution des conflits git de manière interactive
**Usage** : `/git:conflit <branche-destination>`

**Particularités** :
- Détection automatique de merge/rebase en cours
- Analyse contextuelle de chaque fichier en conflit
- 3 stratégies de résolution proposées :
  - Garder la version actuelle (ours)
  - Garder la version entrante (theirs)
  - Résolution manuelle intelligente
- Validation utilisateur avant chaque application
- Rapport détaillé de résolution
- Support annulation à tout moment (merge/rebase --abort)

**Exemples** :
- `/git:conflit main` - Merge main dans branche actuelle avec résolution de conflits
- `/git:conflit develop` - Rebase sur develop avec résolution interactive

#### `/git:pr`
**Description** : Crée une Pull Request optimisée avec workflow complet

**Format** : Workflow structuré incluant QA, commits, milestone et assignation projet
**Usage** : `/git:pr [branch-base] [milestone] [project] [--delete]`

**Particularités** :
- QA automatique pour fichiers PHP
- Demande confirmation pour branche et milestone
- Utilise le script `scripts/assign_github_project.sh` pour l'assignation

#### `/git:status`
**Description** : Affiche le statut Git détaillé du projet

**Format** : Informations structurées sur la branche, modifications et historique
**Usage** : `/git:status`

**Particularités** :
- Branche courante et statut
- Fichiers modifiés/ajoutés/supprimés
- Commits récents
- État du tracking remote

### Commandes GitHub

#### `/github:fix`
**Description** : Corriger une issue GitHub avec workflow simplifié et efficace

**Format** : Workflow automatisé de correction d'issue depuis GitHub
**Usage** : `/github:fix [issue-number]`

**Particularités** :
- Récupération automatique des détails de l'issue via GitHub CLI
- Analyse du problème avec contexte Sentry si disponible
- Création automatique de branche : `issue/N-description`
- Investigation du code concerné
- Implémentation avec respect des standards du projet
- Validation PHPStan (niveau 9, zéro erreur)
- Tests automatiques avant finalisation
- Support des standards PHP 8.2+ avec typage strict

**Exemples** :
- `/github:fix 966` - Corrige l'issue #966 avec workflow complet

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

#### `/build:quick-plan`
**Description** : Génère un plan d'implémentation d'ingénierie concis et le sauvegarde dans le répertoire specs

**Format** : Plan structuré avec spécifications techniques, architecture et étapes d'implémentation
**Usage** : `/build:quick-plan [requirement-description]`

**Particularités** :
- Analyse automatique des requirements
- Génération de spécifications techniques complètes
- Sauvegarde versionnée dans `docs/specs/[timestamp]_[project-name]_plan.md`
- Intégration avec TodoWrite pour le suivi des tâches
- Évaluation des risques et estimation de temps
- Format markdown structuré et réutilisable

**Exemples** :
- `/build:quick-plan "Add user authentication with JWT tokens"`
- `/build:quick-plan "Implement WebSocket notification system"`

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

#### `/cc:challenge`
**Description** : Auto-évaluation de ma dernière réponse avec notation et propositions d'amélioration

**Format** : Rapport structuré avec scores détaillés par critère et version améliorée si pertinent
**Usage** : `/cc:challenge`

**Particularités** :
- Évaluation sur 5 critères : pertinence, clarté, complétude, précision, format/style
- Note globale sur 10
- Identification des points forts et axes d'amélioration
- Proposition d'une version améliorée si note < 8/10
- Auto-critique honnête et constructive
- Rapport concis en format liste à puces

**Exemples** :
- `/cc:challenge` - Après avoir fourni une réponse technique complexe
- `/cc:challenge` - Pour vérifier si la réponse respecte les préférences utilisateur

### Commandes de documentation

#### `/doc:adr`
**Description** : Génère un Architecture Decision Record (ADR) formaté et structuré

**Format** : Création d'un document ADR suivant les standards
**Usage** : `/doc:adr [titre]`

**Particularités** :
- Format standardisé ADR avec contexte, décision, conséquences
- Numérotation automatique dans le répertoire docs/adr
- Template structuré pour la cohérence
- Lien automatique avec les ADRs connexes

**Exemples** :
- `/doc:adr "Utilisation de PostgreSQL pour la base de données"`
- `/doc:adr "Migration vers architecture microservices"`

#### `/doc:rtfm`
**Description** : Lit la documentation technique - RTFM (Read The Fucking Manual)

**Format** : Extraction et lecture de documentation en ligne ou locale
**Usage** : `/doc:rtfm [url|doc-name]`

**Particularités** :
- Support URLs web et chemins locaux
- Extraction intelligente du contenu pertinent
- Sauvegarde locale optionnelle pour consultation offline
- Format markdown pour lisibilité

**Exemples** :
- `/doc:rtfm https://symfony.com/doc/current/setup.html`
- `/doc:rtfm "API Platform documentation"`

#### `/doc:update`
**Description** : Crée la documentation pour la fonctionnalité en cours et met à jour le README global du projet si nécessaire

**Format** : Génération automatique de documentation complète et interconnectée
**Usage** : `/doc:update`

**Particularités** :
- Analyse automatique de la branche Git en cours :
  - Nom de la branche (ex: feature/user-auth → User Authentication)
  - Fichiers modifiés (git status)
  - Diff par rapport à main/master
  - Commits de la branche
- Génération de documentation structurée :
  - Titre et description claire
  - Utilisation et exemples concrets
  - Architecture et composants
  - Configuration nécessaire
  - Tests et validation
- Mise à jour automatique du README principal
- Liaison bidirectionnelle avec documents connexes
- Validation des liens pour éviter les orphelins
- Format Markdown optimisé pour scanabilité

**Exemples** :
- `/doc:update` - Analyse la branche en cours et génère la documentation complète

### Commandes de diagnostic

#### `/debug:error-fix`
**Description** : Analyse et résolution d'erreurs avec workflow structuré

**Format** : Diagnostic méthodique avec plan de résolution et exécution guidée
**Usage** : `/debug:error-fix [message-erreur-ou-fichier-log]`

**Particularités** :
- Analyse approfondie des messages d'erreur et stack traces
- Recherche contextuelle dans les fichiers et logs du projet
- Diagnostic des causes racines vs symptômes
- Plan de résolution structuré en étapes priorisées
- Exécution guidée avec validation à chaque étape
- Support des erreurs PHP, JavaScript, build, configuration
- Analyse des changements récents (git) pour identifier les causes
- Documentation complète des corrections appliquées

**Exemples** :
- `/debug:error-fix "Fatal error: Uncaught Error: Call to undefined method User::getName()"`
- `/debug:error-fix /var/log/app.log`
- `/debug:error-fix "npm ERR! missing script: build"`

#### `/debug:stack-trace`
**Description** : Analyse une stack trace et génère un rapport formaté avec diagnostic et solutions

**Format** : Parsing intelligent de trace d'erreur avec analyse contextuelle
**Usage** : `/debug:stack-trace <stack-trace-text-or-file-path>`

**Particularités** :
- Détection automatique du type d'erreur (PHP, JavaScript, Python, etc.)
- Formatage hiérarchique et lisible de la trace
- Identification du point d'origine exact (fichier:ligne)
- Analyse du code source au point d'erreur
- Diagnostic de la cause racine vs symptôme
- 3 solutions proposées : Quick Fix, Recommandée, Long-terme
- Génération de rapport complet dans `/tmp/stack-trace-analysis-[timestamp].md`
- Support texte brut ou chemin de fichier log

**Exemples** :
- `/debug:stack-trace "Fatal error: Uncaught Error: Call to undefined method User::getName() in /app/src/Service.php:42"`
- `/debug:stack-trace /var/log/app-error.log`
- `/debug:stack-trace "TypeError: Cannot read property 'id' of undefined at Object.process (main.js:156:23)"`

### Commandes de qualité de code

#### `/qa:phpstan`
**Description** : Résout automatiquement les erreurs PHPStan détectées dans le projet

**Format** : Workflow itératif de détection et correction avec agent spécialisé
**Usage** : `/qa:phpstan`

**Particularités** :
- Exécution automatique de PHPStan pour détecter les erreurs
- Traitement par lots (5 erreurs max par fichier)
- Utilisation de l'agent @phpstan-error-resolver pour chaque groupe d'erreurs
- Vérification après chaque correction
- Boucle itérative jusqu'à résolution complète ou stagnation
- Rapport détaillé avec statistiques de résolution
- Support du fichier de configuration phpstan.neon

**Exemples** :
- `/qa:phpstan`

### Commandes d'analyse

#### `/analyse:impact`
**Description** : Analyse le détail des modifications d'une Pull Request et génère deux rapports d'impact (métier et technique)

**Format** : Analyse automatisée avec génération de rapports intégrés à la PR
**Usage** : `/analyse:impact <pr-number>`

**Particularités** :
- Analyse complète de tous les fichiers modifiés dans la PR
- Génération de deux rapports complémentaires :
  - **Rapport métier** : Impact fonctionnel, risques, recommandations (sans jargon)
  - **Rapport technique** : Métriques, dépendances, sécurité, tests
- Ajout automatique des rapports à la description de la PR
- Sauvegarde locale dans `.analysis-reports/`
- Analyse détaillée par type de fichier (PHP, JS, templates, styles, config)
- Évaluation de la couverture de tests
- Identification des breaking changes
- Détection des fichiers de configuration modifiés

**Exemples** :
- `/analyse:impact 42` - Analyse complète de la PR #42 avec rapports

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

#### `/think:ultra`
**Description** : Ultra-comprehensive analytical thinking for the most complex problems

**Format** : Applique un framework d'analyse ultra-exhaustif en 7 phases pour résoudre les problèmes les plus complexes
**Usage** : `/think:ultra "complex problem or question"`

**Particularités** :
- Framework d'analyse ultra-complet en 7 phases : Architecture du Problème, Analyse Multi-Paradigme, Intégration Cross-Disciplinaire, Scaling Temporel/Spatial, Modélisation d'Incertitude et Risques, Théorie de Décision et des Jeux, Réflexion Meta-Cognitive
- Sortie ultra-structurée en 7 sections : Reconceptualisation, Cartographie Multi-Dimensionnelle, Intégration de Preuves, Analyse d'Options, Évaluation des Risques, Recommandations Stratégiques, Meta-Analyse
- Analyse exhaustive avec perspectives multiples et évaluation d'incertitudes
- Recommandations stratégiques actionables avec feuille de route d'implémentation
- Évaluation critique des limitations analytiques et biais cognitifs
- Idéal pour les problèmes complexes à enjeux élevés nécessitant une analyse exhaustive

**Exemples** :
- `/think:ultra "Should we migrate our entire legacy system to microservices architecture?"`
- `/think:ultra "How should we approach the AI transformation of our organization?"`
- `/think:ultra "What's the optimal strategy for entering the European market?"`

### Commandes de contexte

#### `/context:default`
**Description** : Charger le contexte pour une nouvelle session d'agent

**Format** : Analyse automatique de la structure du projet
**Usage** : `/context:default`

**Particularités** :
- Liste tous les fichiers du projet via `git ls-files`
- Lit automatiquement la documentation principale
- Fournit un résumé de compréhension du projet
- Idéal pour démarrer une nouvelle session de travail

**Exemples** :
- `/context:default` - Charge le contexte complet du projet

#### `/context:elegant_object`
**Description** : Charge les règles de conception Elegant Objects

**Format** : Chargement des principes Elegant Objects de Yegor Bugayenko
**Usage** : `/context:elegant_object`

**Particularités** :
- Charge tous les principes de conception Elegant Objects
- Règles sur les classes, constructeurs, méthodes
- Principes de tests et mocking
- Standards de code et documentation
- Applique les règles à tout le code écrit ou modifié
- Support des règles personnalisées (constructeurs privés pour VO/DTO)

**Exemples** :
- `/context:elegant_object` - Active les règles Elegant Objects pour la session

### Commandes de chargement de documentation

#### `/load:doc:api-platform`
**Description** : Charge la documentation API Platform depuis leur site web

**Format** : Workflow automatisé de scraping et sauvegarde locale
**Usage** : `/load:doc:api-platform`

**Particularités** :
- Vérifie l'âge des fichiers existants (24h par défaut)
- Ignore les fichiers récents pour économiser les ressources
- Utilise l'agent @api-platform-docs-scraper
- Sauvegarde dans `docs/api-platform/`
- Liste des URLs dans `docs/api-platform/README.md`

#### `/load:doc:atournayre-framework`
**Description** : Charge la documentation atournayre-framework depuis ReadTheDocs

**Format** : Workflow automatisé de scraping et sauvegarde locale
**Usage** : `/load:doc:atournayre-framework`

**Particularités** :
- Vérifie l'âge des fichiers existants (24h par défaut)
- Ignore les fichiers récents pour économiser les ressources
- Utilise l'agent @atournayre-framework-docs-scraper
- Sauvegarde dans `docs/atournayre-framework/`
- Liste des URLs dans `docs/atournayre-framework/README.md`

#### `/load:doc:claude`
**Description** : Charge la documentation Claude Code depuis docs.claude.com

**Format** : Workflow automatisé de scraping et sauvegarde locale
**Usage** : `/load:doc:claude`

**Particularités** :
- Vérifie l'âge des fichiers existants (24h par défaut)
- Ignore les fichiers récents pour économiser les ressources
- Utilise l'agent @claude-docs-scraper
- Sauvegarde dans `docs/claude/`
- Liste des URLs dans `docs/claude/README.md`

#### `/load:doc:meilisearch`
**Description** : Charge la documentation Meilisearch depuis leur site web dans des fichiers markdown locaux

**Format** : Workflow automatisé de scraping et sauvegarde locale
**Usage** : `/load:doc:meilisearch`

**Particularités** :
- Vérifie l'âge des fichiers existants (24h par défaut)
- Ignore les fichiers récents pour économiser les ressources
- Utilise l'agent @meilisearch-docs-scraper
- Sauvegarde dans `docs/meilisearch/`
- Liste des URLs dans `docs/meilisearch/README.md`

#### `/load:doc:symfony`
**Description** : Charge la documentation Symfony depuis leur site web

**Format** : Workflow automatisé de scraping et sauvegarde locale
**Usage** : `/load:doc:symfony`

**Particularités** :
- Vérifie l'âge des fichiers existants (24h par défaut)
- Ignore les fichiers récents pour économiser les ressources
- Utilise l'agent @symfony-docs-scraper
- Sauvegarde dans `docs/symfony/`
- Liste des URLs dans `docs/symfony/README.md`

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
