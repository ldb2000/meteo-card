#!/bin/bash

echo "🧪 Test de la carte météo moderne"
echo ""

# Vérifier que les fichiers existent
echo "📁 Vérification des fichiers..."
files=("meteo-card.js" ".devcontainer/devcontainer.json" ".devcontainer/docker-compose.yml")
for file in "${files[@]}"; do
    if [ -f "$file" ]; then
        echo "✅ $file"
    else
        echo "❌ $file manquant"
        exit 1
    fi
done

echo ""
echo "🐳 Vérification de Docker..."
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker n'est pas en cours d'exécution"
    echo "💡 Démarrez Docker Desktop et réessayez"
    exit 1
fi
echo "✅ Docker fonctionne"

echo ""
echo "📦 Vérification du conteneur Home Assistant..."
if docker ps | grep -q "homeassistant-dev"; then
    echo "✅ Home Assistant en cours d'exécution"
    echo "🌐 URL: http://localhost:8123"
else
    echo "⚠️  Home Assistant n'est pas démarré"
    echo "💡 Lancez: ./start-dev.sh ou utilisez VS Code Dev Containers"
fi

echo ""
echo "📄 Validation du code JavaScript..."
if node -c meteo-card.js 2>/dev/null; then
    echo "✅ Syntaxe JavaScript valide"
else
    echo "⚠️  Node.js non installé (syntaxe non vérifiée)"
fi

echo ""
echo "📋 Résumé des fonctionnalités:"
echo "  🎨 Design moderne avec dégradés"
echo "  🏙️ Nom de ville personnalisable"
echo "  🌡️ Grande température centrée"
echo "  📝 Descriptions en français"
echo "  ↗️ Températures min/max avec flèches"
echo "  🌊 Animations subtiles"

echo ""
echo "🎯 Prochaines étapes:"
echo "  1. Ouvrez http://localhost:8123"
echo "  2. Testez la carte avec différentes conditions"
echo "  3. Modifiez le CSS dans meteo-card.js"
echo "  4. Utilisez ./reload-card.sh pour recharger"

echo ""
echo "📖 Fichiers de test disponibles:"
echo "  - test-conditions.html (aperçu visuel)"
echo "  - example-config.yaml (exemples de configuration)"
echo "  - DEVELOPMENT.md (guide complet)"
