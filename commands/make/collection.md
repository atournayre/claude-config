---
allowed-tools: Bash, Read, Write, Edit, Grep
argument-hint: <ObjectClass>
description: Génère une Collection PHP typée pour un objet donné suivant les standards du projet
---

# Make Collection

## Purpose
Générer automatiquement une classe Collection typée pour un objet PHP (entité, value object, ou autre classe) en respectant les conventions du projet et les principes Elegant Objects.

## Variables
- `OBJECT_CLASS`: Le nom de la classe objet pour laquelle créer la collection (ex: `Money`, `Email`)
- `OBJECT_PATH`: Le chemin vers le fichier de l'objet
- `COLLECTION_NAME`: Le nom de la collection (automatiquement généré: `${OBJECT_CLASS}Collection`)
- `COLLECTION_NAMESPACE`: Le namespace de la collection (automatiquement généré)

## Instructions
1. Identifier l'objet pour lequel créer une collection
2. Analyser le namespace et la structure de l'objet
3. Générer la collection avec les interfaces et traits appropriés
4. Créer les tests unitaires associés
5. Vérifier la qualité du code généré

## Relevant Files
- Le fichier `OBJECT_CLASS` de l'objet cible
- Le fichier `composer.json` pour déterminer le namespace de base
- Les interfaces de collection du framework: `Atournayre\Contracts\Collection\*`
- Les traits de collection du framework: `Atournayre\Primitives\Traits\Collection`
- Les exemples de collections existantes dans le projet

## Codebase Structure
```
src/
├── Collection/
│   └── [Module]/
│       └── [Entity]/
│           └── [Entity]Collection.php
├── Model/
│   └── [Module]/
│       └── [Entity]/
│           └── [Entity].php
└── tests/
    └── Collection/
        └── [Module]/
            └── [Entity]/
                └── [Entity]CollectionTest.php
```

## Workflow
1. **Validation des paramètres**
   - Vérifier que `OBJECT_CLASS` est fourni

2. **Détection du namespace de base**
   - Lire le fichier `composer.json` à la racine du projet
   - Extraire le namespace principal depuis la section `autoload.psr-4`
   - Utiliser le premier namespace trouvé comme défaut
   - Exemple: `"App\\": "src/"` → namespace de base = `App`

3. **Localisation de l'objet**
   - Rechercher le fichier de la classe objet avec `grep` ou `find`
   - Extraire le namespace complet de l'objet
   - Vérifier que la classe existe et est valide

4. **Analyse de l'objet**
   - Lire le fichier de l'objet pour comprendre sa structure
   - Identifier les propriétés importantes pour les méthodes de collection
   - Déterminer si l'objet implémente `LoggableInterface`

5. **Génération du namespace de la collection**
   - Déterminer le type d'objet (ValueObject, Entity, etc.)
   - Transformer le namespace approprié vers `Collection`
   - Exemples:
     - `App\ValueObject\Money` → `App\Collection\ValueObject\Money`
     - `App\Entity\User` → `App\Collection\Entity\User`

6. **Création de la structure de répertoires**
   ```bash
   mkdir -p src/Collection/[Module]/[Object]
   ```

7. **Génération de la classe Collection**
   - Créer le fichier avec le bon namespace
   - Implémenter les interfaces requises:
     - `AsListInterface`: Pour créer une collection depuis un array
     - `ToArrayInterface`: Pour convertir en array
     - `LoggableInterface`: Si l'entité est loggable
   - Utiliser les traits appropriés:
     - `PrimitiveCollection`: Pour les méthodes de base
     - `PrimitiveCollection\ToArray`: Pour la conversion en array
   - Implémenter les méthodes requises:
     - `asList()`: Factory method statique avec validation
     - `toArray()`: Conversion en array (via trait)
     - `toLog()`: Si loggable, retourner les infos de log

8. **Structure de la classe Collection générée**
   ```php
   <?php
   declare(strict_types=1);

   namespace [COLLECTION_NAMESPACE];

   use Atournayre\Common\Assert\Assert;
   use Atournayre\Contracts\Collection\AsListInterface;
   use Atournayre\Contracts\Collection\ToArrayInterface;
   use Atournayre\Contracts\Log\LoggableInterface;
   use Atournayre\Primitives\Collection;
   use Atournayre\Primitives\Traits\Collection as PrimitiveCollection;
   use [OBJECT_NAMESPACE]\[OBJECT_CLASS];

   final class [OBJECT_CLASS]Collection implements AsListInterface, ToArrayInterface[, LoggableInterface]
   {
       use PrimitiveCollection;
       use PrimitiveCollection\ToArray;

       public static function asList(array $collection): self
       {
           Assert::allIsInstanceOf($collection, [OBJECT_CLASS]::class);

           return new self(Collection::of($collection));
       }

       [SI LoggableInterface:]
       /**
        * @return array<string, mixed>
        */
       public function toLog(): array
       {
           return [
               'collection' => self::class,
               'nombreElements' => Collection::of($this->collection)->count()->value(),
           ];
       }
   }
   ```

9. **Génération des tests unitaires**
   - Créer la structure de répertoires pour les tests
   - Générer un fichier de test avec les cas de test essentiels:
     - Test de création avec `asList()`
     - Test de validation des types d'éléments
     - Test de conversion `toArray()`
     - Test de `toLog()` si applicable
     - Test avec collection vide
     - Test avec éléments invalides (doit lever une exception)

10. **Structure du test généré**
   ```php
   <?php
   declare(strict_types=1);

   namespace Tests\Collection\[Module]\[Object];

   use PHPUnit\Framework\TestCase;
   use [COLLECTION_NAMESPACE]\[OBJECT_CLASS]Collection;
   use [OBJECT_NAMESPACE]\[OBJECT_CLASS];

   final class [OBJECT_CLASS]CollectionTest extends TestCase
   {
       public function testAsListCreeUneCollectionValide(): void
       {
           // Test implementation
       }

       public function testAsListRejetteLesElementsInvalides(): void
       {
           // Test implementation
       }

       public function testToArrayRetourneLesElementsSousFormeDeTableau(): void
       {
           // Test implementation
       }

       [SI LoggableInterface:]
       public function testToLogRetourneLesInformationsDeLog(): void
       {
           // Test implementation
       }
   }
   ```

11. **Validation du code généré**
    - Vérifier la syntaxe PHP avec `php -l`
    - Exécuter PHPStan sur la nouvelle classe
    - Exécuter PHP-CS-Fixer pour le formatage
    - Lancer les tests unitaires

## Expertise
- **Principles Elegant Objects**: Classes finales, objets immuables, pas de setters
- **Domain-Driven Design**: Séparation claire entre différents types d'objets et leurs collections
- **Type Safety**: Validation stricte des types avec Assert
- **PHP Best Practices**: PSR-12, typage strict, docblocks complets
- **Testing**: Couverture de test complète avec cas nominaux et cas d'erreur
- **Namespace Detection**: Extraction automatique depuis composer.json

## Template
Le template ci-dessus dans la section "Structure de la classe Collection générée" sert de base pour la génération.

## Examples

### Exemple 1: Collection pour une entité
```bash
/make:collection User
```
Génère `UserCollection` pour l'entité `User`, namespace détecté depuis composer.json

### Exemple 2: Collection pour un Value Object
```bash
/make:collection Money
```
Génère `MoneyCollection` pour le value object `Money`


## Report
- Afficher le chemin du fichier Collection créé
- Afficher le chemin du fichier de test créé
- Afficher le namespace détecté depuis composer.json
- Résumer les interfaces implémentées
- Lister les méthodes générées
- Afficher les résultats de validation (PHPStan, PHP-CS-Fixer, tests)
