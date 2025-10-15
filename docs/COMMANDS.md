# Documentation Complète des Commandes

Cette documentation détaille toutes les commandes personnalisées (slash commands) disponibles dans la configuration Claude Code.

[← Retour au README](../README.md)

## Table des matières

- [Commandes Git](#commandes-git)
- [Commandes GitHub](#commandes-github)
- [Commandes Analytics](#commandes-analytics)
- [Commandes Build](#commandes-build)
- [Commandes Sessions](#commandes-sessions)
- [Commandes CC (Claude Code)](#commandes-cc-claude-code)
- [Commandes de documentation](#commandes-de-documentation)
- [Commandes de diagnostic](#commandes-de-diagnostic)
- [Commandes de qualité de code](#commandes-de-qualité-de-code)
- [Commandes d'analyse](#commandes-danalyse)
- [Commandes de contexte](#commandes-de-contexte)
- [Commandes de chargement de documentation](#commandes-de-chargement-de-documentation)
- [Commandes Symfony](#commandes-symfony)
- [Commandes générales](#commandes-générales)

---

## Commandes Git

### `/git:branch`
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

---

### `/git:commit`
**Description** : Création de commit avec workflow structuré

**Format** : Workflow de commit avec conventions et validation
**Usage** : `/git:commit [message] | --no-verify`

**Particularités** :
- Format conventional commits avec emojis
- Analyse automatique des changements
- Suggestion de division en plusieurs commits si nécessaire
- Validation pre-commit (sauf --no-verify)

---

### `/git:conflit`
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

---

### `/git:pr`
**Description** : Crée une Pull Request optimisée avec workflow complet

**Format** : Workflow structuré incluant QA, commits, milestone et assignation projet
**Usage** : `/git:pr [branch-base] [milestone] [project] [--delete]`

**Particularités** :
- QA automatique pour fichiers PHP
- Demande confirmation pour branche et milestone
- Utilise le script `scripts/assign_github_project.sh` pour l'assignation

---

### `/git:status`
**Description** : Affiche le statut Git détaillé du projet

**Format** : Informations structurées sur la branche, modifications et historique
**Usage** : `/git:status`

**Particularités** :
- Branche courante et statut
- Fichiers modifiés/ajoutés/supprimés
- Commits récents
- État du tracking remote

---

## Commandes GitHub

### `/github:fix`
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

---

## Commandes Analytics

### `/analytics`
**Description** : Lance le tableau de bord d'analytics pour visualiser les statistiques d'utilisation de Claude Code

**Format** : Serveur local sur port 3333 avec ouverture automatique du navigateur
**Usage** : `/analytics`

**Particularités** :
- Analyse l'utilisation de Claude Code (prompts, coûts, sessions)
- Vérifie la disponibilité du port 3333
- Ouverture automatique du navigateur
- Serveur reste actif jusqu'à interruption manuelle
- Utilise `claude-code-templates --analytics`

---

### `/analytics-stop`
**Description** : Arrête proprement le serveur analytics dashboard de Claude Code

**Format** : Commande de nettoyage pour libérer le port 3333
**Usage** : `/analytics-stop`

**Particularités** :
- Détection automatique du processus sur port 3333
- Arrêt propre avec confirmation
- Messages informatifs si aucun serveur actif

---

## Commandes Build

### `/code`
**Description** : Workflow de code complet avec étapes structurées

**Format** : Processus de code avec validation et tests
**Usage** : `/code`

---

### `/build:quick-plan`
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

---

## Commandes Sessions

### `/sessions:start`
**Description** : Démarre une nouvelle session de travail

**Usage** : `/sessions:start [nom-session]`

---

### `/sessions:current`
**Description** : Affiche la session courante avec détails

**Usage** : `/sessions:current`

---

### `/sessions:list`
**Description** : Liste toutes les sessions disponibles

**Usage** : `/sessions:list`

---

### `/sessions:end`
**Description** : Termine la session courante

**Usage** : `/sessions:end`

---

### `/sessions:update`
**Description** : Met à jour les informations de session

**Usage** : `/sessions:update`

---

### `/sessions:help`
**Description** : Aide détaillée sur la gestion des sessions

**Usage** : `/sessions:help`

---

## Commandes CC (Claude Code)

### `/cc:make:command`
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

---

### `/cc:challenge`
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

---

## Commandes de documentation

### `/doc:adr`
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

---

### `/doc:rtfm`
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

---

### `/doc:update`
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

---

## Commandes de diagnostic

### `/debug:error-fix`
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

---

### `/debug:stack-trace`
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

---

## Commandes de qualité de code

### `/qa:phpstan`
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

---

## Commandes d'analyse

### `/analyse:impact`
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

---

### `/think:harder`
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

---

### `/think:ultra`
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

---

## Commandes de contexte

### `/context:default`
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

---

### `/context:elegant_object`
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

---

## Commandes de chargement de documentation

### `/load:doc:api-platform`
**Description** : Charge la documentation API Platform depuis leur site web

**Format** : Workflow automatisé de scraping et sauvegarde locale
**Usage** : `/load:doc:api-platform`

**Particularités** :
- Vérifie l'âge des fichiers existants (24h par défaut)
- Ignore les fichiers récents pour économiser les ressources
- Utilise l'agent @api-platform-docs-scraper
- Sauvegarde dans `docs/api-platform/`
- Liste des URLs dans `docs/api-platform/README.md`

---

### `/load:doc:atournayre-framework`
**Description** : Charge la documentation atournayre-framework depuis ReadTheDocs

**Format** : Workflow automatisé de scraping et sauvegarde locale
**Usage** : `/load:doc:atournayre-framework`

**Particularités** :
- Vérifie l'âge des fichiers existants (24h par défaut)
- Ignore les fichiers récents pour économiser les ressources
- Utilise l'agent @atournayre-framework-docs-scraper
- Sauvegarde dans `docs/atournayre-framework/`
- Liste des URLs dans `docs/atournayre-framework/README.md`

---

### `/load:doc:claude`
**Description** : Charge la documentation Claude Code depuis docs.claude.com

**Format** : Workflow automatisé de scraping et sauvegarde locale
**Usage** : `/load:doc:claude`

**Particularités** :
- Vérifie l'âge des fichiers existants (24h par défaut)
- Ignore les fichiers récents pour économiser les ressources
- Utilise l'agent @claude-docs-scraper
- Sauvegarde dans `docs/claude/`
- Liste des URLs dans `docs/claude/README.md`

---

### `/load:doc:meilisearch`
**Description** : Charge la documentation Meilisearch depuis leur site web dans des fichiers markdown locaux

**Format** : Workflow automatisé de scraping et sauvegarde locale
**Usage** : `/load:doc:meilisearch`

**Particularités** :
- Vérifie l'âge des fichiers existants (24h par défaut)
- Ignore les fichiers récents pour économiser les ressources
- Utilise l'agent @meilisearch-docs-scraper
- Sauvegarde dans `docs/meilisearch/`
- Liste des URLs dans `docs/meilisearch/README.md`

---

### `/load:doc:symfony`
**Description** : Charge la documentation Symfony depuis leur site web

**Format** : Workflow automatisé de scraping et sauvegarde locale
**Usage** : `/load:doc:symfony`

**Particularités** :
- Vérifie l'âge des fichiers existants (24h par défaut)
- Ignore les fichiers récents pour économiser les ressources
- Utilise l'agent @symfony-docs-scraper
- Sauvegarde dans `docs/symfony/`
- Liste des URLs dans `docs/symfony/README.md`

---

## Commandes Symfony

### `/symfony:doc:question`
**Description** : Interroge la documentation Symfony locale pour répondre à une question

**Format** : Recherche intelligente dans la documentation Symfony stockée dans `docs/symfony/`
**Usage** : `/symfony:doc:question <question>`

**Particularités** :
- Recherche dans la documentation Symfony locale (pas d'accès web requis)
- Extraction de mots-clés et recherche contextuelle
- Analyse intelligente des fichiers markdown pertinents
- Réponses formatées avec exemples de code
- Références aux fichiers sources consultés
- Suggestions de documentation connexe
- Si la documentation n'est pas disponible : suggère `/load:doc:symfony`

**Exemples** :
- `/symfony:doc:question "Comment créer une route ?"` - Routing et controllers
- `/symfony:doc:question "Comment utiliser les formulaires avec validation ?"` - Forms et validation
- `/symfony:doc:question "Quelle est la différence entre les voters et les guards ?"` - Security

---

## Commandes générales

### `/all_tools`
**Description** : Liste tous les outils disponibles dans votre système Claude Code

**Format** : Affiche chaque outil avec sa signature TypeScript et sa description

**Usage** : Tapez `/all_tools` dans Claude Code pour obtenir la liste complète

---

### `/docker`
**Description** : Active le mode Docker pour toutes les opérations techniques

**Format** : Configuration contextuelle pour l'exécution via Docker/Docker Compose
**Usage** : `/docker`

**Particularités** :
- Détecte automatiquement la configuration Docker (docker-compose.yml, Dockerfile)
- Transforme toutes les commandes système pour utiliser Docker
- Exemples de transformation :
  - `composer install` → `docker compose exec php composer install`
  - `npm run build` → `docker compose exec node npm run build`
  - `php bin/console` → `docker compose exec php php bin/console`
- Affiche les services disponibles avec leur état (running/stopped)
- Persiste le contexte Docker pour toute la session
- Gère les erreurs si Docker n'est pas accessible ou conteneurs arrêtés

**Exemples** :
- `/docker` - Active le mode Docker pour la session actuelle

---

### `/git_status`
**Description** : Affiche un statut Git détaillé du projet actuel

**Format** : Informations structurées sur la branche, les modifications et l'historique

**Usage** : `/git_status` pour une vue d'ensemble rapide de votre dépôt

---

### `/question`
**Description** : Pose une question structurée avec contexte

**Format** : Question formatée avec sections et métadonnées

**Usage** : `/question "Votre question ici"`

---

[← Retour au README](../README.md)
