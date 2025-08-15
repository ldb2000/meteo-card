# Configuration de l'entité weather.valencin

## Dans l'environnement de développement

Dans le devcontainer, nous utilisons `weather.demo_weather_north` avec le nom "Valencin" pour les tests.

## Dans votre Home Assistant réel

Pour créer une entité `weather.valencin` dans votre installation Home Assistant, vous avez plusieurs options :

### Option 1 : Intégration météo dédiée

Configurez une intégration météo spécifique pour Valencin :

```yaml
# configuration.yaml
weather:
  - platform: openweathermap
    api_key: !secret openweather_api_key
    name: "Valencin"
    latitude: 45.1833  # Coordonnées de Valencin
    longitude: 5.1167
```

Cette configuration créera automatiquement l'entité `weather.valencin`.

### Option 2 : Alias d'une entité existante

Si vous avez déjà une entité météo locale, créez un alias :

1. **Via l'interface graphique :**
   - Allez dans Configuration > Entités
   - Trouvez votre entité météo existante
   - Cliquez dessus
   - Modifiez l'ID d'entité pour `weather.valencin`

2. **Via configuration.yaml :**
```yaml
# configuration.yaml
homeassistant:
  customize:
    weather.votre_entite_existante:
      entity_id: weather.valencin
      friendly_name: "Météo Valencin"
```

### Option 3 : Template Weather

Créez une entité template basée sur une autre source :

```yaml
# configuration.yaml
template:
  - weather:
      - name: "Valencin"
        condition_template: "{{ states('weather.votre_source') }}"
        temperature_template: "{{ state_attr('weather.votre_source', 'temperature') }}"
        humidity_template: "{{ state_attr('weather.votre_source', 'humidity') }}"
        pressure_template: "{{ state_attr('weather.votre_source', 'pressure') }}"
        wind_bearing_template: "{{ state_attr('weather.votre_source', 'wind_bearing') }}"
        wind_speed_template: "{{ state_attr('weather.votre_source', 'wind_speed') }}"
        visibility_template: "{{ state_attr('weather.votre_source', 'visibility') }}"
        forecast_template: "{{ state_attr('weather.votre_source', 'forecast') }}"
```

### Option 4 : Intégrations populaires

**Met.no (gratuit, très précis) :**
```yaml
# configuration.yaml
weather:
  - platform: met
    name: "Valencin"
    latitude: 45.1833
    longitude: 5.1167
```

**AccuWeather :**
```yaml
# configuration.yaml
weather:
  - platform: accuweather
    api_key: !secret accuweather_api_key
    name: "Valencin"
    latitude: 45.1833
    longitude: 5.1167
```

## Coordonnées de Valencin

- **Latitude :** 45.1833
- **Longitude :** 5.1167
- **Altitude :** ~200m
- **Région :** Auvergne-Rhône-Alpes, France

## Vérification

Une fois configuré, vérifiez que l'entité fonctionne :

1. Allez dans Outils de développeur > États
2. Recherchez `weather.valencin`
3. Vérifiez que les attributs sont présents :
   - `temperature`
   - `humidity`
   - `pressure`
   - `forecast` (recommandé)

## Utilisation avec la carte

Une fois `weather.valencin` configuré, utilisez-le dans votre carte :

```yaml
type: custom:meteo-card
entity: weather.valencin
name: "Valencin"
```

## Notes importantes

- L'entité `weather.valencin` doit exister **avant** d'utiliser la carte
- Redémarrez Home Assistant après avoir modifié `configuration.yaml`
- Certaines intégrations peuvent prendre quelques minutes pour récupérer les premières données
- Vérifiez les logs si l'entité n'apparaît pas : Configuration > Système > Logs
