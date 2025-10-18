#!/bin/bash

set -e

CLAUDE_DIR="$HOME/.claude"
CONFIG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Fonction d'aide
show_help() {
    echo "Usage: $0 [install|sync|backup|restore|aliases] [--target-dir DIR]"
    echo ""
    echo "Commands:"
    echo "  install  - Copie la configuration vers ~/.claude (défaut)"
    echo "  sync     - Synchronise les modifications vers ~/.claude"
    echo "  backup   - Sauvegarde la configuration actuelle de ~/.claude"
    echo "  restore  - Restaure depuis la dernière sauvegarde"
    echo "  aliases  - Installe les alias Claude Code dans .bashrc/.zshrc"
    echo ""
    echo "Options:"
    echo "  --target-dir DIR  - Utilise DIR au lieu de ~/.claude (pour test)"
    echo ""
    echo "Exemples:"
    echo "  $0 install --target-dir /tmp/claude-test"
    echo "  $0 sync --target-dir ./test-claude"
    echo "  $0 aliases"
}

# Fonction pour installer les alias
# Usage: install_aliases [silent]
#   silent: mode automatique sans questions
install_aliases() {
    local silent_mode="${1:-false}"

    echo "Installation des alias Claude Code..."

    # Détecter le shell principal
    local shell_files=()

    if [ -n "$ZSH_VERSION" ] || [ "$SHELL" = "$(which zsh 2>/dev/null)" ]; then
        shell_files+=("$HOME/.zshrc")
    fi

    if [ -n "$BASH_VERSION" ] || [ "$SHELL" = "$(which bash 2>/dev/null)" ]; then
        shell_files+=("$HOME/.bashrc")
    fi

    # Si aucun shell détecté
    if [ ${#shell_files[@]} -eq 0 ]; then
        if [ "$silent_mode" = "true" ]; then
            # Mode silencieux : installer dans les deux fichiers
            shell_files=("$HOME/.bashrc" "$HOME/.zshrc")
        else
            # Mode interactif : demander
            echo "Shell non détecté. Quel fichier voulez-vous modifier ?"
            echo "1) ~/.bashrc"
            echo "2) ~/.zshrc"
            echo "3) Les deux"
            read -p "Choix [1-3]: " choice

            case $choice in
                1) shell_files=("$HOME/.bashrc") ;;
                2) shell_files=("$HOME/.zshrc") ;;
                3) shell_files=("$HOME/.bashrc" "$HOME/.zshrc") ;;
                *) echo "❌ Choix invalide"; exit 1 ;;
            esac
        fi
    fi

    # Définir les alias
    local aliases=(
        "alias cc='claude'"
        "alias ccy='claude --dangerously-skip-permissions'"
        ""
        "alias cld='claude'"
        "alias cldy='claude --dangerously-skip-permissions'"
        ""
        "alias cld-chrome='claude --mcp-config ~/.claude/mcp/chrome-dev-tools.json --strict-mcp-config'"
        "alias cldy-chrome='claude --mcp-config ~/.claude/mcp/chrome-dev-tools.json --strict-mcp-config --dangerously-skip-permissions'"
        ""
        "alias cld-sentry='claude --mcp-config ~/.claude/mcp/sentry.json --strict-mcp-config'"
        "alias cldy-sentry='claude --mcp-config ~/.claude/mcp/sentry.json --strict-mcp-config --dangerously-skip-permissions'"
    )

    local marker_start="# >>> Claude Code aliases >>>"
    local marker_end="# <<< Claude Code aliases <<<"

    # Traiter chaque fichier de configuration shell
    for shell_file in "${shell_files[@]}"; do
        echo ""
        echo "Traitement de $shell_file..."

        # Créer le fichier s'il n'existe pas
        if [ ! -f "$shell_file" ]; then
            touch "$shell_file"
            echo "✅ Fichier $shell_file créé"
        fi

        # Vérifier si les alias existent déjà
        if grep -q "$marker_start" "$shell_file"; then
            if [ "$silent_mode" = "true" ]; then
                # Mode silencieux : remplacer automatiquement
                sed -i "/$marker_start/,/$marker_end/d" "$shell_file"
                echo "✅ Anciens alias remplacés dans $shell_file"
            else
                # Mode interactif : demander confirmation
                echo "⚠️  Des alias Claude Code existent déjà dans $shell_file"
                read -p "Voulez-vous les remplacer ? [o/N]: " replace

                if [[ "$replace" =~ ^[Oo]$ ]]; then
                    # Supprimer l'ancienne section
                    sed -i "/$marker_start/,/$marker_end/d" "$shell_file"
                    echo "✅ Anciens alias supprimés"
                else
                    echo "⏭️  Alias non modifiés dans $shell_file"
                    continue
                fi
            fi
        fi

        # Ajouter les nouveaux alias
        echo "" >> "$shell_file"
        echo "$marker_start" >> "$shell_file"
        for alias_line in "${aliases[@]}"; do
            echo "$alias_line" >> "$shell_file"
        done
        echo "$marker_end" >> "$shell_file"

        echo "✅ Alias ajoutés à $shell_file"
    done

    if [ "$silent_mode" = "true" ]; then
        echo "✅ Alias installés"
    else
        echo ""
        echo "✅ Installation des alias terminée !"
        echo ""
        echo "Pour activer les alias immédiatement, exécutez :"
        for shell_file in "${shell_files[@]}"; do
            echo "  source $shell_file"
        done
    fi
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
    "_templates"
    "agents"
    "commands"
    "docs"
    "hooks"
    "mcp"
    "output-styles"
    "status_lines"
    "task"
)

# Fonction pour copier la configuration
install_config() {
    echo "Installation/synchronisation de la configuration Claude Code..."
    echo "Répertoire de config: $CONFIG_DIR"
    echo "Répertoire Claude: $CLAUDE_DIR"
    
    # Créer le répertoire ~/.claude s'il n'existe pas
    mkdir -p "$CLAUDE_DIR"
    
    # Gestion spéciale pour settings.json
    if [ -f "$CONFIG_DIR/settings.json" ]; then
        echo "Copie de settings.json..."
        cp "$CONFIG_DIR/settings.json" "$CLAUDE_DIR/settings.json"
    elif [ -f "$CONFIG_DIR/settings.json" ]; then
        echo "Copie de settings.json (template)..."
        cp "$CONFIG_DIR/settings.json" "$CLAUDE_DIR/settings.json"
        echo "⚠️  Conseil: créez settings.json pour vos paramètres personnels"
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

    # Installation automatique des alias
    echo ""
    install_aliases true

    # Détecter le shell actuel pour afficher la bonne commande
    local shell_config=""
    if [ -n "$ZSH_VERSION" ]; then
        shell_config="~/.zshrc"
    elif [ -n "$BASH_VERSION" ]; then
        shell_config="~/.bashrc"
    elif [ "$SHELL" = "$(which zsh 2>/dev/null)" ]; then
        shell_config="~/.zshrc"
    elif [ "$SHELL" = "$(which bash 2>/dev/null)" ]; then
        shell_config="~/.bashrc"
    else
        shell_config="~/.bashrc ou ~/.zshrc"
    fi

    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "✅ Installation terminée avec succès!"
    echo ""
    echo "Pour activer les alias immédiatement, exécutez :"
    echo ""
    echo "  source $shell_config"
    echo ""
    echo "Ou ouvrez un nouveau terminal."
    echo ""
    echo "Pour synchroniser après des modifications : $0 sync"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
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
    "aliases")
        install_aliases
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
