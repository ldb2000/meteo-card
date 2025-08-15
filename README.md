# Meteo Card

Une carte météo simple pour Home Assistant. Le fond change en fonction de la condition météo du jour et affiche les températures minimale et maximale ainsi que la prévision de la journée.

Les conditions prises en charge pour le fond d'écran sont : `sunny`, `rainy`, `cloudy`, `snowy`, `partlycloudy` et `clear-night`.

## Installation

1. Copier `meteo-card.js` dans votre dossier `www` de Home Assistant.
2. Ajouter la ressource suivante dans votre configuration Lovelace :

```yaml
resources:
  - url: /local/meteo-card.js
    type: module
```

## Utilisation

Ajouter la carte dans votre tableau de bord :

```yaml
type: custom:meteo-card
entity: weather.ma_station
```

L'entité doit fournir des prévisions (`attributes.forecast`) pour que la carte fonctionne correctement.

## Développement avec DevContainer

Pour développer et tester cette carte dans un environnement Home Assistant complet :

1. **Prérequis** : Docker et VS Code avec l'extension Dev Containers
2. **Ouvrir le projet** : Ouvrez ce dossier dans VS Code
3. **Démarrer le devcontainer** : Cliquez sur "Reopen in Container"
4. **Accéder à Home Assistant** : http://localhost:8123 (après le démarrage)

### Flux de développement

1. Modifiez `meteo-card.js`
2. Exécutez `./reload-card.sh` pour recharger la carte
3. Rafraîchissez votre navigateur

Le devcontainer inclut :
- Home Assistant avec configuration de test
- Entités météo de démonstration
- Dashboard préconfiguré avec votre carte
- Scripts de rechargement automatique

Voir `.devcontainer/README.md` pour plus de détails.

