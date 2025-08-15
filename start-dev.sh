#!/bin/bash

echo "🚀 Démarrage de l'environnement de développement..."
echo ""

# Vérifier que Docker est en cours d'exécution
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker ne semble pas être en cours d'exécution"
    echo "💡 Démarrez Docker Desktop et réessayez"
    exit 1
fi

# Aller dans le dossier devcontainer
cd .devcontainer

echo "🐳 Démarrage des conteneurs Docker..."
docker-compose up -d

echo ""
echo "⏳ Attente du démarrage de Home Assistant..."
echo "   Cela peut prendre quelques minutes au premier démarrage..."

# Attendre que Home Assistant soit prêt
max_attempts=60
attempts=0
while [ $attempts -lt $max_attempts ]; do
    if curl -s http://localhost:8123 > /dev/null 2>&1; then
        echo ""
        echo "✅ Home Assistant est prêt !"
        echo ""
        echo "🌐 Accédez à Home Assistant : http://localhost:8123"
        echo "🛠️  Pour recharger la carte : ./reload-card.sh"
        echo "📋 Logs : docker-compose logs -f homeassistant"
        echo "🛑 Arrêter : docker-compose down"
        echo ""
        break
    fi
    
    sleep 5
    attempts=$((attempts + 1))
    echo -n "."
done

if [ $attempts -eq $max_attempts ]; then
    echo ""
    echo "⚠️  Home Assistant met du temps à démarrer"
    echo "🔍 Vérifiez les logs : docker-compose logs homeassistant"
    echo "🌐 Essayez d'accéder à : http://localhost:8123"
fi
