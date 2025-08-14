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

