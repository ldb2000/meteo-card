# 🌤️ Carte Météo Moderne

Une carte météo moderne et élégante pour Home Assistant avec un design inspiré des applications météo populaires. La carte affiche les informations essentielles dans un format visuel attractif avec des arrière-plans adaptatifs selon les conditions météo.

## ✨ Caractéristiques

- 🎨 **Design moderne** : Interface épurée avec typographie claire
- 🏙️ **Nom de ville personnalisable** : Affichez le nom de votre choix
- 🌡️ **Grande température centrée** : Lisibilité optimale
- 📝 **Descriptions en français** : Conditions météo traduites
- ↗️ **Températures min/max** : Avec flèches pour une lecture intuitive
- 🎨 **Arrière-plans adaptatifs** : Dégradés qui changent selon la météo
- 🌊 **Animations subtiles** : Effets de survol élégants
- 📱 **Design responsive** : S'adapte à toutes les tailles d'écran

### Conditions météo supportées

`sunny`, `partlycloudy`, `rainy`, `cloudy`, `snowy`, `clear-night`, `lightning`, `fog`, `windy`

## Installation

1. Copier `meteo-card.js` dans votre dossier `www` de Home Assistant.
2. Ajouter la ressource suivante dans votre configuration Lovelace :

```yaml
resources:
  - url: /local/meteo-card.js
    type: module
```

## Utilisation

### Configuration de base

```yaml
type: custom:meteo-card
entity: weather.valencin
```

### Configuration avec nom personnalisé

```yaml
type: custom:meteo-card
entity: weather.valencin
name: "Valencin"
```

### Exemples avancés

```yaml
# Plusieurs cartes en grille
type: grid
columns: 2
cards:
  - type: custom:meteo-card
    entity: weather.valencin
    name: "Valencin"
  - type: custom:meteo-card
    entity: weather.lyon
    name: "Lyon"
```

### Paramètres disponibles

| Paramètre | Type | Requis | Description |
|-----------|------|--------|-------------|
| `entity` | string | Oui | Entité météo Home Assistant |
| `name` | string | Non | Nom à afficher (par défaut: nom de l'entité) |

**Note** : L'entité météo doit fournir au minimum `temperature` et `state`. Les prévisions (`attributes.forecast`) sont optionnelles mais recommandées pour les températures min/max.

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

