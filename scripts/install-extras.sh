#!/bin/bash
# Script d'installation des extras (output-styles et status-lines)
# À exécuter après l'installation du plugin

set -e

CLAUDE_DIR="$HOME/.claude"
PLUGIN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "🔧 Installation des extras pour claude-config..."
echo ""

# Vérifier que le répertoire .claude existe
if [ ! -d "$CLAUDE_DIR" ]; then
    echo "❌ Erreur: Le répertoire $CLAUDE_DIR n'existe pas"
    echo "   Veuillez d'abord installer Claude Code"
    exit 1
fi

# Créer les répertoires si nécessaire
mkdir -p "$CLAUDE_DIR/output-styles"
mkdir -p "$CLAUDE_DIR/status_lines"

# Copier les output-styles
if [ -d "$PLUGIN_DIR/output-styles" ]; then
    echo "📋 Installation des output-styles..."
    cp -r "$PLUGIN_DIR/output-styles/"* "$CLAUDE_DIR/output-styles/"
    echo "✅ Output-styles installés"
else
    echo "⚠️  Aucun output-style trouvé (répertoire absent)"
fi

echo ""

# Copier les status-lines
if [ -d "$PLUGIN_DIR/status_lines" ]; then
    echo "📊 Installation des status-lines..."
    cp -r "$PLUGIN_DIR/status_lines/"* "$CLAUDE_DIR/status_lines/"
    echo "✅ Status-lines installés"
else
    echo "⚠️  Aucune status-line trouvée (répertoire absent)"
fi

echo ""
echo "✅ Installation des extras terminée!"
echo ""
echo "ℹ️  Note: N'oubliez pas de configurer les permissions"
echo "   Voir docs/PERMISSIONS.md pour plus d'informations"
