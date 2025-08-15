# Guide de développement - Carte Météo

## 🚀 Démarrage rapide

### Option 1 : Avec VS Code (Recommandé)
1. Ouvrez ce dossier dans VS Code
2. Installez l'extension "Dev Containers" si pas déjà fait
3. Cliquez sur "Reopen in Container" dans la notification
4. Attendez que le conteneur se construise (3-5 minutes la première fois)
5. Home Assistant sera disponible sur http://localhost:8123

### Option 2 : Avec Docker directement
```bash
# Démarrer l'environnement
./start-dev.sh

# Ou manuellement
cd .devcontainer
docker-compose up -d
```

## 🛠️ Flux de développement

1. **Modifier le code** : Éditez `meteo-card.js`
2. **Recharger** : Exécutez `./reload-card.sh`
3. **Tester** : Rafraîchissez http://localhost:8123 (Ctrl+F5)

## 🧪 Test de la carte

### Accès à Home Assistant
- **URL** : http://localhost:8123
- **Première connexion** : Créez un utilisateur admin
- **Dashboard** : La carte météo est préconfigurée

### Entités de test disponibles
- `weather.demo_weather_north` - Météo principale (change automatiquement)
- `weather.demo_weather_south` - Météo secondaire
- Capteurs de température et humidité

### Conditions météo testées
- ☀️ `sunny` - Ensoleillé
- 🌧️ `rainy` - Pluvieux
- ☁️ `cloudy` - Nuageux
- 🌨️ `snowy` - Neigeux
- ⛅ `partlycloudy` - Partiellement nuageux
- 🌙 `clear-night` - Nuit claire

## 🔧 Commandes utiles

```bash
# Recharger la carte après modification
./reload-card.sh

# Voir les logs Home Assistant
cd .devcontainer && docker-compose logs -f homeassistant

# Redémarrer Home Assistant
cd .devcontainer && docker-compose restart homeassistant

# Arrêter l'environnement
cd .devcontainer && docker-compose down

# Entrer dans le conteneur pour debug
docker exec -it homeassistant-dev bash
```

## 🐛 Dépannage

### Problèmes courants

**❌ Port 8123 déjà utilisé**
```bash
# Trouver et arrêter le processus
lsof -ti :8123 | xargs kill -9
```

**❌ Carte non visible**
- Vérifiez que `meteo-card.js` est dans le conteneur : `docker exec homeassistant-dev ls -la /config/www/`
- Rechargez les ressources Lovelace : Configuration > Tableau de bord > ⋮ > Ressources

**❌ Erreurs JavaScript**
- Ouvrez la console du navigateur (F12)
- Vérifiez la syntaxe dans `meteo-card.js`

### Debug avancé

**Logs détaillés**
```bash
# Logs du conteneur
docker logs homeassistant-dev

# Logs Home Assistant en direct
docker exec homeassistant-dev tail -f /config/home-assistant.log
```

**Inspection du conteneur**
```bash
# Entrer dans le conteneur
docker exec -it homeassistant-dev bash

# Vérifier les fichiers
ls -la /config/www/
cat /config/configuration.yaml
```

## 📁 Structure du projet

```
.
├── .devcontainer/           # Configuration DevContainer
│   ├── devcontainer.json   # Config VS Code
│   ├── docker-compose.yml  # Services Docker
│   ├── configuration.yaml  # Config Home Assistant
│   ├── ui-lovelace.yaml   # Dashboard
│   └── setup.sh           # Script installation
├── meteo-card.js           # Votre carte météo
├── reload-card.sh          # Script rechargement
├── start-dev.sh           # Démarrage rapide
└── README.md              # Documentation
```

## 🚀 Prochaines étapes

### Améliorer la carte
- Ajouter plus d'animations CSS
- Supporter plus de conditions météo
- Ajouter des graphiques de tendance
- Intégrer des données UV/vent

### Tests avancés
- Tester avec de vraies entités météo
- Ajouter des tests unitaires
- Optimiser les performances

### Déploiement
- Publier sur HACS (Home Assistant Community Store)
- Créer une documentation utilisateur
- Ajouter des captures d'écran
