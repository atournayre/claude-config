# Permissions Recommandées

Ce document liste les permissions recommandées pour utiliser pleinement le plugin `claude-config`.

## Configuration

Ajoutez ces permissions à votre `~/.claude/settings.json` :

```json
{
  "permissions": {
    "allow": [
      "Bash(./vendor/bin/phpstan:*)",
      "Bash(bin/console:*)",
      "Bash(chmod:*)",
      "Bash(composer --version)",
      "Bash(composer:*)",
      "Bash(cp:*)",
      "Bash(curl:*)",
      "Bash(docker compose exec:*)",
      "Bash(docker compose:*)",
      "Bash(docker exec:*)",
      "Bash(echo:*)",
      "Bash(find:*)",
      "Bash(gh api:*)",
      "Bash(gh issue:*)",
      "Bash(gh pr close:*)",
      "Bash(gh pr comment:*)",
      "Bash(gh pr create:*)",
      "Bash(gh pr diff:*)",
      "Bash(gh pr edit:*)",
      "Bash(gh pr view:*)",
      "Bash(git add:*)",
      "Bash(git branch:*)",
      "Bash(git checkout:*)",
      "Bash(git cherry-pick:*)",
      "Bash(git log:*)",
      "Bash(git pull:*)",
      "Bash(git push:*)",
      "Bash(git rev-list:*)",
      "Bash(git shortlog:*)",
      "Bash(git status:*)",
      "Bash(git diff:*)",
      "Bash(git commit:*)",
      "Bash(grep:*)",
      "Bash(ls:*)",
      "Bash(make grunt:*)",
      "Bash(make:*)",
      "Bash(mkdir:*)",
      "Bash(php -l:*)",
      "Bash(php:*)",
      "Bash(rm /tmp/pr_body*.md)",
      "Bash(sentry-cli projects:*)",
      "Bash(tree:*)",
      "Bash(vendor/bin/phpstan:*)",
      "Bash(vendor/bin/phpunit:*)",
      "Bash(npx claude-code-templates:*)",
      "Bash(xdg-open:*)",
      "Bash(open:*)",
      "Bash(sleep:*)",
      "Bash(date:*)",
      "WebFetch(domain:docs.anthropic.com)",
      "WebFetch(domain:github.com)",
      "WebFetch(domain:localhost)",
      "WebFetch(domain:meilisearch.com)",
      "WebFetch(domain:symfony.com)",
      "WebFetch(domain:api-platform.com)",
      "WebFetch(domain:readthedocs.io)"
    ]
  }
}
```

## Explication des Permissions

### Permissions Git
- `git:*` - Commandes Git essentielles pour les workflows de développement
- `gh:*` - GitHub CLI pour gestion des issues et pull requests

### Permissions PHP/Symfony
- `composer:*` - Gestion des dépendances PHP
- `bin/console:*` - Console Symfony
- `vendor/bin/phpstan:*` - Analyse statique PHPStan
- `vendor/bin/phpunit:*` - Tests unitaires

### Permissions Docker
- `docker compose:*` - Gestion des environnements Docker
- `docker exec:*` - Exécution de commandes dans les conteneurs

### Permissions Web
- `WebFetch(domain:*)` - Accès aux documentations officielles :
  - docs.anthropic.com - Documentation Claude Code
  - github.com - Accès aux repositories GitHub
  - meilisearch.com - Documentation Meilisearch
  - symfony.com - Documentation Symfony
  - api-platform.com - Documentation API Platform
  - localhost - Accès aux serveurs de développement locaux

### Permissions Système
- `chmod:*`, `mkdir:*`, `cp:*` - Opérations fichiers de base
- `ls:*`, `tree:*`, `find:*` - Navigation et exploration
- `make:*` - Exécution de Makefiles
- `date:*` - Timestamps pour les rapports

## Sécurité

Les hooks du plugin incluent des protections automatiques :

### Protection rm -rf
Le hook `pre_tool_use` bloque automatiquement les commandes `rm -rf` dangereuses visant :
- Le répertoire racine (`/`)
- Le répertoire home (`~`)
- Les répertoires parent (`..`)
- Les wildcards dangereux

### Protection .env
L'accès aux fichiers `.env` contenant des données sensibles est bloqué automatiquement.
Les fichiers `.env.sample` (templates) restent accessibles.

## Personnalisation

Adaptez ces permissions selon vos besoins :
- Ajoutez d'autres commandes Bash selon votre stack technique
- Ajoutez d'autres domaines WebFetch pour vos documentations
- Retirez les permissions non nécessaires (ex: Docker si non utilisé)

## Notes

- Ces permissions sont **recommandées** mais pas obligatoires
- Le plugin fonctionnera en mode dégradé sans certaines permissions
- Les hooks de sécurité fonctionnent indépendamment des permissions
