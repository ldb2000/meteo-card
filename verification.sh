#!/bin/bash

echo "🔍 Vérification de la carte météo"
echo ""

# Vérifier que Home Assistant fonctionne
echo "📡 Test de Home Assistant..."
if curl -s -f http://localhost:8123 > /dev/null; then
    echo "✅ Home Assistant accessible sur http://localhost:8123"
else
    echo "❌ Home Assistant non accessible"
    echo "💡 Lancez: ./start-dev.sh ou utilisez VS Code Dev Containers"
    exit 1
fi

# Vérifier que la carte est bien copiée
echo ""
echo "📁 Vérification des fichiers..."
if docker exec homeassistant-dev test -f /config/www/meteo-card.js; then
    echo "✅ meteo-card.js présent dans Home Assistant"
else
    echo "❌ meteo-card.js manquant"
    echo "💡 Exécutez: ./reload-card.sh"
fi

# Vérifier la configuration Lovelace
if docker exec homeassistant-dev test -f /config/ui-lovelace.yaml; then
    echo "✅ Configuration Lovelace présente"
else
    echo "❌ Configuration Lovelace manquante"
fi

# Vérifier que les entités météo sont mentionnées
echo ""
echo "🌤️ Vérification des entités météo..."
if docker exec homeassistant-dev grep -q "weather.demo_weather_north" /config/ui-lovelace.yaml; then
    echo "✅ Entité weather.demo_weather_north configurée"
else
    echo "❌ Entité météo non trouvée dans la configuration"
fi

echo ""
echo "📋 Résumé de la configuration actuelle:"
echo "  🌐 URL: http://localhost:8123"
echo "  🏷️ Entité: weather.demo_weather_north"
echo "  📍 Nom affiché: Valencin"
echo "  🎨 Style: Design moderne avec dégradés"

echo ""
echo "🎯 Actions suggérées:"
echo "  1. Ouvrez http://localhost:8123"
echo "  2. Créez un compte admin si première fois"
echo "  3. Vérifiez que la carte affiche les données météo"
echo "  4. Testez les modifications avec ./reload-card.sh"

echo ""
echo "📖 Documentation:"
echo "  - DEVELOPMENT.md : Guide de développement complet"
echo "  - CORRECTION_DONNEES_METEO.md : Solution au problème des données"
echo "  - CONFIGURATION_VALENCIN.md : Configuration pour l'installation réelle"
