#!/bin/bash

echo "🧪 Test final de la carte météo"
echo ""

# Vérifier Docker
if ! docker ps | grep -q homeassistant-dev; then
    echo "❌ Home Assistant non démarré"
    echo "💡 Lancez: cd .devcontainer && docker-compose up -d"
    exit 1
fi

# Vérifier l'accès web
if curl -s -f http://localhost:8123 > /dev/null; then
    echo "✅ Home Assistant accessible"
else
    echo "❌ Home Assistant non accessible"
    echo "💡 Attendez quelques minutes ou redémarrez le conteneur"
    exit 1
fi

# Vérifier les fichiers
if docker exec homeassistant-dev test -f /config/www/meteo-card.js; then
    echo "✅ Carte météo installée"
else
    echo "❌ Carte météo manquante"
    echo "💡 Exécutez: ./reload-card.sh"
fi

echo ""
echo "🎯 Instructions de test:"
echo ""
echo "1. 🌐 Ouvrez votre navigateur sur:"
echo "   http://localhost:8123"
echo ""
echo "2. 👤 Première connexion:"
echo "   - Créez un compte administrateur"
echo "   - Choisissez nom/mot de passe"
echo ""
echo "3. 🔍 Debug si problème:"
echo "   - Appuyez sur F12 (Console développeur)"
echo "   - Recherchez 'MeteoCard Debug'"
echo "   - Vérifiez les données des entités"
echo ""
echo "4. ✅ Résultat attendu:"
echo "   - Carte 'Valencin' : 21°C, Ensoleillé"
echo "   - Carte 'Demo' : Données variables"
echo "   - Design moderne avec dégradés"
echo ""
echo "📋 Entités configurées:"
echo "   - weather.valencin (template fixe)"
echo "   - weather.demo (démo Home Assistant)"
echo ""
echo "🔧 Si ça ne marche pas:"
echo "   - Consultez RESOLUTION_PROBLEME_DONNEES.md"
echo "   - Vérifiez la console du navigateur (F12)"
echo "   - Redémarrez: docker-compose restart homeassistant"
echo ""
echo "🚀 Bonne chance !"
