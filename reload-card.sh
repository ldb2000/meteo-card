#!/bin/bash

echo "🔄 Rechargement de la carte météo dans Home Assistant..."

# Vérifier si Docker Compose est en cours d'exécution
if ! docker-compose -f .devcontainer/docker-compose.yml ps | grep -q "homeassistant-dev"; then
    echo "❌ Home Assistant ne semble pas être en cours d'exécution"
    echo "💡 Démarrez le devcontainer dans VS Code ou lancez :"
    echo "   cd .devcontainer && docker-compose up -d"
    exit 1
fi

# Copier la carte dans le conteneur
echo "📁 Copie de meteo-card.js..."
docker cp meteo-card.js homeassistant-dev:/config/www/

echo "✅ Carte rechargée avec succès !"
echo "🌐 Rafraîchissez votre navigateur sur http://localhost:8123"
echo ""
echo "💡 Conseils :"
echo "   - Utilisez Ctrl+F5 pour un rechargement forcé"
echo "   - Vérifiez la console du navigateur (F12) en cas d'erreur"
