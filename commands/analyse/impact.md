---
allowed-tools: Bash(git diff:*), Bash(git log:*), Bash(git status:*), Bash(git show:*), Bash(gh pr view:*), Bash(gh pr diff:*), Read, Write, Grep, Glob, TodoWrite
argument-hint: <pr-number>
description: Analyses le détail des modifications git. Fournis 2 rapports d'impact - un rapport métier et un rapport technique. Ajoutes ce rapport à la description de la PR.
---

# Analyse d'Impact des Modifications Git

## Purpose
Analyser en profondeur les modifications d'une Pull Request spécifique pour générer deux rapports d'impact complémentaires (métier et technique) et les intégrer automatiquement à sa description.

## Variables
- `PR_NUMBER`: Numéro de la PR à analyser (passé en paramètre)
- `CURRENT_BRANCH`: Branche de la PR
- `BASE_BRANCH`: Branche de base de la PR
- `MODIFIED_FILES`: Liste des fichiers modifiés dans la PR
- `COMMIT_COUNT`: Nombre de commits dans la PR

## Instructions
Tu dois analyser les modifications d'une Pull Request spécifique (dont le numéro est passé en paramètre) pour comprendre l'impact complet des changements. Génère deux rapports distincts : un pour les parties prenantes métier (clair, sans jargon) et un pour l'équipe technique (détaillé, avec métriques). Ajoute automatiquement ces rapports à la description de la PR.

### Points d'Attention
- ✅ Analyse complète de tous les fichiers modifiés
- ✅ Identification des dépendances impactées
- ✅ Évaluation des risques potentiels
- ✅ Détection des breaking changes
- ✅ Vérification de la couverture de tests

## Relevant Files
- `.git/`: Historique et état du repository
- `composer.json`: Dépendances PHP (si applicable)
- `package.json`: Dépendances JavaScript (si applicable)
- `tests/`: Tests associés aux modifications
- `config/`: Fichiers de configuration potentiellement impactés

## Workflow

### Étape 1: Initialisation TodoWrite
```
Créer une todo list avec toutes les étapes:
1. Récupérer les informations de la PR spécifiée
2. Analyser l'état de la PR (branches, statut)
3. Identifier tous les fichiers modifiés dans la PR
4. Examiner le détail des modifications
5. Analyser les dépendances et impacts
6. Générer le rapport métier
7. Générer le rapport technique
8. Ajouter les rapports à la description de la PR
9. Sauvegarder les rapports localement
```

### Étape 2: Récupération des Informations de la PR
```bash
# Récupérer le numéro de PR depuis les arguments
PR_NUMBER="$ARGUMENTS"

# Vérifier que le numéro de PR est fourni
if [ -z "$PR_NUMBER" ]; then
    echo "❌ ERREUR: Numéro de PR requis"
    echo "Usage: /impact <pr-number>"
    exit 1
fi

# Récupérer les informations de la PR
gh pr view $PR_NUMBER --json number,headRefName,baseRefName,state,title

# Extraire les branches
CURRENT_BRANCH=$(gh pr view $PR_NUMBER --json headRefName -q .headRefName)
BASE_BRANCH=$(gh pr view $PR_NUMBER --json baseRefName -q .baseRefName)

# Vérifier que la PR existe
if [ -z "$CURRENT_BRANCH" ]; then
    echo "❌ ERREUR: PR #$PR_NUMBER introuvable"
    exit 1
fi

echo "✅ Analyse de la PR #$PR_NUMBER"
echo "   Branche: $CURRENT_BRANCH → $BASE_BRANCH"
```

### Étape 3: Identification des Modifications dans la PR
```bash
# Récupérer le diff de la PR via gh
gh pr diff $PR_NUMBER --name-status

# Statistiques globales de la PR
gh pr diff $PR_NUMBER --stat

# Liste des fichiers modifiés
MODIFIED_FILES=$(gh pr diff $PR_NUMBER --name-only)

# Compter les commits dans la PR
COMMIT_COUNT=$(gh pr view $PR_NUMBER --json commits -q '.commits | length')

echo "📊 Statistiques de la PR #$PR_NUMBER:"
echo "   - Fichiers modifiés: $(echo "$MODIFIED_FILES" | wc -l)"
echo "   - Commits: $COMMIT_COUNT"
```

### Étape 4: Analyse des Dépendances
```bash
# Récupérer les fichiers modifiés de la PR
FILES=$(gh pr diff $PR_NUMBER --name-only)

# Pour PHP
echo "$FILES" | grep "\.php$" | while read file; do
    grep "use.*;" "$file" 2>/dev/null || true
done

# Pour JavaScript
echo "$FILES" | grep -E "\.(js|ts)$" | while read file; do
    grep -E "import|require" "$file" 2>/dev/null || true
done

# Fichiers de configuration modifiés dans la PR
echo "$FILES" | grep -E "\.(json|yaml|yml|env|ini|conf)$"
```

### Étape 5: Analyse des Tests
```bash
# Vérifier si des tests ont été ajoutés/modifiés dans la PR
gh pr diff $PR_NUMBER --name-only | grep -E "(test|spec)\.(php|js|ts)$"

# Vérifier la couverture des nouveaux fichiers de la PR
for file in $(gh pr diff $PR_NUMBER --name-only | grep -E "\.(php|js|ts)$"); do
    # Chercher les tests correspondants
    basename=$(basename "$file" | sed 's/\.[^.]*$//')
    find tests/ -name "*${basename}*Test*" 2>/dev/null || echo "⚠️ Pas de test trouvé pour $file"
done
```

### Étape 6: Génération du Rapport Métier
```markdown
## 📊 Rapport d'Impact Métier

### Vue d'Ensemble
- **Portée des modifications** : [Nombre] fichiers modifiés sur [Nombre] commits
- **Domaines fonctionnels impactés** : [Liste des modules/fonctionnalités]
- **Niveau de risque estimé** : 🟢 Faible / 🟡 Modéré / 🔴 Élevé

### Changements Fonctionnels
#### Nouvelles Fonctionnalités
- [Description claire sans jargon technique]

#### Améliorations
- [Liste des améliorations visibles pour l'utilisateur]

#### Corrections
- [Bugs corrigés et leur impact utilisateur]

### Impact Utilisateur
- **Expérience utilisateur** : [Changements visibles]
- **Performance** : [Améliorations/dégradations attendues]
- **Compatibilité** : [Breaking changes éventuels]

### Risques Identifiés
1. [Risque métier 1 et mitigation]
2. [Risque métier 2 et mitigation]

### Recommandations
- **Tests recommandés** : [Scénarios de test métier]
- **Communication** : [Points à communiquer aux utilisateurs]
- **Déploiement** : [Stratégie suggérée]
```

### Étape 7: Génération du Rapport Technique
```markdown
## 🔧 Rapport d'Impact Technique

### Métriques de Changement
```
Fichiers modifiés : [Nombre]
Lignes ajoutées   : +[Nombre]
Lignes supprimées : -[Nombre]
Commits           : [Nombre]
```

### Analyse par Type de Fichier
| Type | Fichiers | Ajouts | Suppressions | Complexité |
|------|----------|--------|--------------|------------|
| PHP  | [N]      | +[N]   | -[N]         | [Score]    |
| JS   | [N]      | +[N]   | -[N]         | [Score]    |
| CSS  | [N]      | +[N]   | -[N]         | [Score]    |
| Config | [N]    | +[N]   | -[N]         | N/A        |

### Changements Architecturaux
#### Classes/Modules Modifiés
- `[Namespace\Class]`: [Description technique du changement]

#### Dépendances
##### Ajoutées
- [Package]: [Version] - [Raison]

##### Modifiées
- [Package]: [Ancienne version] → [Nouvelle version]

##### Supprimées
- [Package]: [Raison de la suppression]

### Analyse de Sécurité
- **Vulnérabilités corrigées** : [Liste]
- **Nouveaux vecteurs d'attaque** : [Analyse]
- **Validations ajoutées** : [Liste]

### Couverture de Tests
```
Tests ajoutés     : [Nombre]
Tests modifiés    : [Nombre]
Couverture estimée: [Pourcentage]%
Fichiers non testés: [Liste]
```

### Points d'Attention Technique
1. **Performance** :
   - [Impact sur les requêtes DB]
   - [Impact sur la mémoire]
   - [Impact sur le temps de réponse]

2. **Compatibilité** :
   - [Breaking changes dans les APIs]
   - [Changements de schéma DB]
   - [Modifications de configuration]

3. **Dette Technique** :
   - [Dette ajoutée]
   - [Dette remboursée]
   - [Refactoring nécessaire]

### Checklist de Revue
- [ ] Tous les nouveaux fichiers ont des tests
- [ ] Les modifications suivent les standards de code
- [ ] La documentation est à jour
- [ ] Les migrations DB sont réversibles
- [ ] Les variables d'environnement sont documentées
- [ ] Les logs sont appropriés
- [ ] La gestion d'erreur est complète
```

### Étape 8: Ajout des Rapports à la PR
```bash
# La PR existe forcément (vérifiée à l'étape 2)
echo "Mise à jour de la PR #$PR_NUMBER..."

# Récupérer la description actuelle
gh pr view $PR_NUMBER --json body -q .body > /tmp/pr_current_body.md

# Vérifier si les rapports d'impact existent déjà
if grep -q "📊 Rapport d'Impact Métier" /tmp/pr_current_body.md; then
    echo "⚠️ Les rapports d'impact existent déjà, mise à jour..."
    # Supprimer les anciens rapports (entre les marqueurs)
    sed -i '/<!-- IMPACT-REPORTS-START -->/,/<!-- IMPACT-REPORTS-END -->/d' /tmp/pr_current_body.md
fi

# Créer le nouveau contenu avec les rapports
cat /tmp/pr_current_body.md > /tmp/pr_new_body.md
echo "" >> /tmp/pr_new_body.md
echo "<!-- IMPACT-REPORTS-START -->" >> /tmp/pr_new_body.md
echo "---" >> /tmp/pr_new_body.md
echo "" >> /tmp/pr_new_body.md
cat /tmp/impact_report.md >> /tmp/pr_new_body.md
echo "" >> /tmp/pr_new_body.md
echo "<!-- IMPACT-REPORTS-END -->" >> /tmp/pr_new_body.md

# Mettre à jour la PR
gh pr edit $PR_NUMBER --body-file /tmp/pr_new_body.md

echo "✅ Rapports d'impact ajoutés à la PR #$PR_NUMBER"
```

### Étape 9: Sauvegarde Locale
```bash
# Créer un répertoire pour les rapports
mkdir -p .analysis-reports

# Sauvegarder avec horodatage
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
cp /tmp/impact_report.md ".analysis-reports/impact_${TIMESTAMP}.md"

echo "📁 Rapport sauvegardé : .analysis-reports/impact_${TIMESTAMP}.md"
```

## Report

### Format de Sortie
```yaml
analysis_completed: true
reports_generated:
  - type: "business"
    risk_level: "[low|medium|high]"
    functional_impacts: [count]
  - type: "technical"
    files_modified: [count]
    lines_changed: [total]
    test_coverage: "[percentage]%"

pr_update:
  status: "[success|not_found|error]"
  pr_number: [number]

local_save:
  path: ".analysis-reports/impact_[timestamp].md"

recommendations:
  - category: "testing"
    priority: "[high|medium|low]"
    actions: [list]
  - category: "deployment"
    priority: "[high|medium|low]"
    strategy: "[description]"
```

### Exemple de Résumé Final
```
✅ ANALYSE D'IMPACT COMPLÈTE

📊 Résumé:
- Fichiers analysés: 24
- Risque métier: 🟡 Modéré
- Risque technique: 🟢 Faible
- Couverture de tests: 87%

📝 Rapports générés:
- Rapport métier: Focus sur l'impact utilisateur
- Rapport technique: Analyse détaillée du code

🔄 Intégration PR:
- PR #42 mise à jour avec les rapports
- URL: https://github.com/[repo]/pull/42

💾 Sauvegarde locale:
- .analysis-reports/impact_20241215_143022.md

⚠️ Actions recommandées:
1. Tests de régression sur le module authentification
2. Revue de sécurité pour les nouvelles validations
3. Communication aux utilisateurs sur les breaking changes
```

## Expertise

### Bonnes Pratiques d'Analyse
- **Exhaustivité** : Ne jamais ignorer de fichiers, même mineurs
- **Contextualisation** : Toujours relier les changements techniques aux impacts métier
- **Priorisation** : Mettre en avant les risques et breaking changes
- **Clarté** : Adapter le niveau de détail selon l'audience (métier vs technique)

### Métriques Clés
- **Complexité cyclomatique** : Identifier les fonctions devenues trop complexes
- **Couplage** : Détecter les dépendances nouvelles ou renforcées
- **Duplication** : Signaler le code dupliqué introduit
- **Coverage Delta** : Évolution de la couverture de tests

### Points de Vigilance
- Les modifications de configuration peuvent avoir des impacts majeurs
- Les changements dans les tests peuvent indiquer des modifications de comportement
- Les suppressions de code peuvent casser des dépendances non évidentes
- Les ajouts de dépendances augmentent la surface d'attaque