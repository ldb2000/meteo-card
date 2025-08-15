# Changelog - Carte Météo

## Version 2.0.0 - Design Moderne (Août 2025)

### 🎨 Refonte complète du design
- **Design moderne** inspiré des applications météo iOS/macOS
- **Layout centré** avec grande température au centre
- **Typographie moderne** utilisant les polices système
- **Arrière-plans adaptatifs** avec dégradés selon les conditions météo

### ✨ Nouvelles fonctionnalités
- **Nom de ville personnalisable** via le paramètre `name`
- **Descriptions météo en français** pour toutes les conditions
- **Températures min/max** avec flèches ↑ ↓ pour une lecture intuitive
- **Animations subtiles** avec effet de survol
- **Support de nouvelles conditions** : lightning, fog, windy, etc.

### 🛠️ Améliorations techniques
- **Meilleure gestion d'erreurs** avec interface dédiée
- **Code plus maintenable** avec séparation des responsabilités
- **Performance optimisée** avec CSS moderne
- **Responsive design** pour toutes les tailles d'écran

### 🧪 Environnement de développement
- **DevContainer complet** pour VS Code
- **Configuration Home Assistant** automatique
- **Scripts de rechargement** pour développement rapide
- **Tests visuels** avec aperçu de toutes les conditions
- **Documentation complète** pour développeurs

### 📁 Nouveaux fichiers
- `.devcontainer/` - Configuration complète DevContainer
- `test-conditions.html` - Aperçu visuel de toutes les conditions
- `example-config.yaml` - Exemples de configuration
- `DEVELOPMENT.md` - Guide de développement
- `reload-card.sh` - Script de rechargement rapide
- `start-dev.sh` - Démarrage rapide de l'environnement

### 🔄 Migration depuis v1.x
1. Remplacez `meteo-card.js` par la nouvelle version
2. Ajoutez le paramètre `name` si souhaité :
   ```yaml
   type: custom:meteo-card
   entity: weather.ma_station
   name: "Ma Ville"  # Nouveau paramètre optionnel
   ```
3. Profitez du nouveau design ! 🎉

### 🐛 Corrections
- **Gestion des entités manquantes** améliorée
- **Températures par défaut** quand les prévisions ne sont pas disponibles
- **Descriptions conditions** couvrent tous les états météo HA
- **Compatibilité** avec différentes intégrations météo

---

## Version 1.0.0 - Version initiale
- Carte météo basique avec prévisions
- Arrière-plans selon les conditions
- Support des conditions principales
