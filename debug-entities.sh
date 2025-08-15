#!/bin/bash

echo "🔍 Debug des entités météo dans Home Assistant"
echo ""

# Attendre que Home Assistant soit prêt
echo "📡 Test de connexion à Home Assistant..."
max_attempts=10
attempts=0
while [ $attempts -lt $max_attempts ]; do
    if curl -s -f http://localhost:8123 > /dev/null; then
        echo "✅ Home Assistant accessible"
        break
    fi
    sleep 2
    attempts=$((attempts + 1))
    echo "⏳ Tentative $attempts/$max_attempts..."
done

if [ $attempts -eq $max_attempts ]; then
    echo "❌ Home Assistant non accessible"
    exit 1
fi

echo ""
echo "🌤️ Recherche des entités météo..."

# Utiliser l'API REST de Home Assistant (sans authentification en mode développement)
curl -s "http://localhost:8123/api/states" 2>/dev/null | \
python3 -c "
import json, sys
try:
    data = json.load(sys.stdin)
    weather_entities = [entity for entity in data if entity['entity_id'].startswith('weather.')]
    
    if weather_entities:
        print(f'📋 {len(weather_entities)} entité(s) météo trouvée(s):')
        print('')
        for entity in weather_entities:
            entity_id = entity['entity_id']
            state = entity['state']
            attrs = entity.get('attributes', {})
            friendly_name = attrs.get('friendly_name', 'Pas de nom')
            temperature = attrs.get('temperature', 'N/A')
            
            print(f'  🌡️  {entity_id}')
            print(f'      📍 Nom: {friendly_name}')
            print(f'      🌈 État: {state}')
            print(f'      🌡️ Température: {temperature}°')
            print(f'      📊 Attributs disponibles: {len(attrs)} attributs')
            if 'forecast' in attrs:
                forecast_count = len(attrs['forecast']) if attrs['forecast'] else 0
                print(f'      📅 Prévisions: {forecast_count} entrées')
            print('')
    else:
        print('❌ Aucune entité météo trouvée!')
        print('')
        print('📋 Entités disponibles (toutes):')
        all_entities = [entity['entity_id'] for entity in data]
        for entity_id in sorted(all_entities)[:20]:  # Afficher les 20 premières
            print(f'  - {entity_id}')
        if len(all_entities) > 20:
            print(f'  ... et {len(all_entities) - 20} autres')

except json.JSONDecodeError as e:
    print(f'❌ Erreur lors de la lecture de l\'API: {e}')
except Exception as e:
    print(f'❌ Erreur: {e}')
"

echo ""
echo "🔧 Configuration actuelle dans ui-lovelace.yaml:"
docker exec homeassistant-dev grep -A2 -B2 "custom:meteo-card" /config/ui-lovelace.yaml | head -10

echo ""
echo "💡 Instructions:"
echo "  1. Vérifiez les entités listées ci-dessus"
echo "  2. Utilisez une entité qui EXISTE dans votre configuration"
echo "  3. Consultez la console du navigateur (F12) pour les logs de debug"
echo "  4. Ouvrez http://localhost:8123 pour tester"
