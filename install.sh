#!/bin/bash

set -e

CLAUDE_DIR="$HOME/.claude"
CONFIG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Fonction d'aide
show_help() {
    echo "Usage: $0 [install|sync|backup|restore] [--target-dir DIR]"
    echo ""
    echo "Commands:"
    echo "  install  - Copie la configuration vers ~/.claude (défaut)"
    echo "  sync     - Synchronise les modifications vers ~/.claude"
    echo "  backup   - Sauvegarde la configuration actuelle de ~/.claude"
    echo "  restore  - Restaure depuis la dernière sauvegarde"
    echo ""
    echo "Options:"
    echo "  --target-dir DIR  - Utilise DIR au lieu de ~/.claude (pour test)"
    echo ""
    echo "Exemples:"
    echo "  $0 install --target-dir /tmp/claude-test"
    echo "  $0 sync --target-dir ./test-claude"
}

# Fonction pour sauvegarder
backup_config() {
    local backup_dir="$CLAUDE_DIR.backup.$(date +%Y%m%d_%H%M%S)"
    
    if [ -d "$CLAUDE_DIR" ]; then
        echo "Sauvegarde de ~/.claude vers $backup_dir"
        cp -r "$CLAUDE_DIR" "$backup_dir"
        echo "✅ Sauvegarde créée: $backup_dir"
    else
        echo "Aucune configuration à sauvegarder"
    fi
}

# Configuration des répertoires à copier
DIRECTORIES=(
    "output-styles"
    "hooks"
    "commands"
)

# Fonction pour copier la configuration
install_config() {
    echo "Installation/synchronisation de la configuration Claude Code..."
    echo "Répertoire de config: $CONFIG_DIR"
    echo "Répertoire Claude: $CLAUDE_DIR"
    
    # Créer le répertoire ~/.claude s'il n'existe pas
    mkdir -p "$CLAUDE_DIR"
    
    # Gestion spéciale pour settings.json
    if [ -f "$CONFIG_DIR/settings.local.json" ]; then
        echo "Copie de settings.local.json..."
        cp "$CONFIG_DIR/settings.local.json" "$CLAUDE_DIR/settings.json"
    elif [ -f "$CONFIG_DIR/settings.json" ]; then
        echo "Copie de settings.json (template)..."
        cp "$CONFIG_DIR/settings.json" "$CLAUDE_DIR/settings.json"
        echo "⚠️  Conseil: créez settings.local.json pour vos paramètres personnels"
    fi
    
    # Copier tous les répertoires
    local copied_items=("~/.claude/settings.json")
    
    for dir in "${DIRECTORIES[@]}"; do
        if [ ! -d "$CONFIG_DIR/$dir" ]; then
            echo "⚠️  Le répertoire $dir n'existe pas, ignoré"
            continue
        fi
        
        echo "Copie du dossier $dir..."
        rm -rf "$CLAUDE_DIR/$dir"
        cp -r "$CONFIG_DIR/$dir" "$CLAUDE_DIR/$dir"
        copied_items+=("~/.claude/$dir/")
        
        # Post-traitement spécial pour les hooks
        if [ "$dir" = "hooks" ]; then
            chmod +x "$CLAUDE_DIR/$dir"/*.sh 2>/dev/null || true
        fi
    done
    
    echo "✅ Configuration installée!"
    echo ""
    echo "Les fichiers suivants ont été copiés:"
    for item in "${copied_items[@]}"; do
        echo "  $item"
    done
    echo ""
    echo "Pour synchroniser après des modifications, utilisez: $0 sync"
}

# Fonction pour restaurer depuis une sauvegarde
restore_config() {
    local latest_backup=$(ls -1d "$CLAUDE_DIR.backup."* 2>/dev/null | sort | tail -1)
    
    if [ -z "$latest_backup" ]; then
        echo "❌ Aucune sauvegarde trouvée"
        exit 1
    fi
    
    echo "Restauration depuis: $latest_backup"
    rm -rf "$CLAUDE_DIR"
    cp -r "$latest_backup" "$CLAUDE_DIR"
    echo "✅ Configuration restaurée!"
}

# Parser les arguments
COMMAND="${1:-install}"
shift || true

# Parser les options
while [[ $# -gt 0 ]]; do
    case $1 in
        --target-dir)
            CLAUDE_DIR="$2"
            shift 2
            ;;
        *)
            echo "❌ Option inconnue: $1"
            show_help
            exit 1
            ;;
    esac
done

# Afficher le répertoire cible si ce n'est pas le défaut
if [ "$CLAUDE_DIR" != "$HOME/.claude" ]; then
    echo "🧪 Mode test - répertoire cible: $CLAUDE_DIR"
fi

case "$COMMAND" in
    "install"|"sync")
        install_config
        ;;
    "backup")
        backup_config
        ;;
    "restore")
        restore_config
        ;;
    "help"|"-h"|"--help")
        show_help
        ;;
    *)
        echo "❌ Commande inconnue: $COMMAND"
        show_help
        exit 1
        ;;
esac