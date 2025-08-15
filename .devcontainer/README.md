# DevContainer pour Carte Météo Home Assistant

Cette configuration DevContainer vous permet de développer et tester votre carte météo personnalisée dans un environnement Home Assistant complet.

## 🚀 Démarrage rapide

1. **Ouvrir dans VS Code** : Ouvrez ce dossier dans VS Code
2. **Reopenin Container** : Cliquez sur "Reopen in Container" quand VS Code le propose
3. **Attendre l'installation** : Le premier démarrage peut prendre quelques minutes
4. **Accéder à Home Assistant** : Une fois prêt, allez sur http://localhost:8123

## 🏠 Configuration Home Assistant

- **Port** : 8123 (mappé automatiquement)
- **Configuration** : `/config` dans le conteneur
- **Carte météo** : Automatiquement copiée dans `/config/www/`
- **Dashboard** : Configuré avec votre carte météo

## 🛠️ Développement

### Modification de la carte
1. Éditez `meteo-card.js` dans VS Code
2. Exécutez `./reload-card.sh` pour recharger
3. Rafraîchissez votre navigateur

### Entités disponibles pour les tests
- `weather.demo_weather_north` - Entité météo principale
- `weather.demo_weather_south` - Entité météo secondaire
- `sensor.temperature_test` - Capteur de température
- `sensor.humidity_test` - Capteur d'humidité

### Scripts utiles
- `./reload-card.sh` - Recharge la carte après modifications
- `docker-compose logs -f homeassistant` - Voir les logs Home Assistant

## 🐛 Dépannage

### Problèmes courants
- **Port 8123 occupé** : Arrêtez toute instance Home Assistant locale
- **Carte non visible** : Vérifiez que `meteo-card.js` est dans `/config/www/`
- **Erreurs JS** : Consultez la console du navigateur (F12)

### Logs
```bash
# Logs Home Assistant
docker-compose logs -f homeassistant

# Entrer dans le conteneur
docker exec -it homeassistant-dev bash
```

## 📁 Structure des fichiers

```
.devcontainer/
├── devcontainer.json     # Configuration DevContainer
├── docker-compose.yml    # Services Docker
├── configuration.yaml   # Config Home Assistant
├── ui-lovelace.yaml     # Dashboard personnalisé
├── setup.sh            # Script d'installation
└── README.md           # Ce fichier
```

## 🔧 Personnalisation

### Modifier la configuration Home Assistant
Éditez `.devcontainer/configuration.yaml` avant de démarrer le conteneur.

### Ajouter des entités de test
Ajoutez vos propres capteurs dans `configuration.yaml` section `sensor:`.

### Modifier le dashboard
Éditez `.devcontainer/ui-lovelace.yaml` pour personnaliser l'interface.
