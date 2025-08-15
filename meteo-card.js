import { LitElement, html, css } from 'https://unpkg.com/lit@2.8.0/index.js?module';

class MeteoCard extends LitElement {
  static get properties() {
    return {
      hass: {},
      config: {},
    };
  }

  setConfig(config) {
    if (!config.entity) {
      throw new Error('Vous devez définir une entité météo');
    }
    this.config = config;
  }

  get entity() {
    return this.hass.states[this.config.entity];
  }

  get today() {
    const forecast = this.entity?.attributes?.forecast;
    return Array.isArray(forecast) && forecast.length > 0 ? forecast[0] : null;
  }

  _getLocationName() {
    return this.config.name || 
           this.entity?.attributes?.friendly_name || 
           this.config.entity.replace('weather.', '').replace(/_/g, ' ') || 
           'Météo';
  }

  _getConditionText(condition) {
    const conditions = {
      'clear-night': 'Nuit claire',
      'cloudy': 'Nuageux',
      'fog': 'Brouillard',
      'hail': 'Grêle',
      'lightning': 'Orageux',
      'lightning-rainy': 'Orageux',
      'partlycloudy': 'Belles éclaircies',
      'pouring': 'Forte pluie',
      'rainy': 'Pluvieux',
      'snowy': 'Neigeux',
      'snowy-rainy': 'Neige et pluie',
      'sunny': 'Ensoleillé',
      'windy': 'Venteux',
      'windy-variant': 'Venteux',
      'exceptional': 'Exceptionnel',
    };
    return conditions[condition] || 'Conditions variables';
  }

  _background(condition) {
    switch (condition) {
      case 'sunny':
        return 'sunny';
      case 'partlycloudy':
        return 'partlycloudy';
      case 'rainy':
      case 'pouring':
      case 'lightning-rainy':
        return 'rainy';
      case 'cloudy':
      case 'fog':
        return 'cloudy';
      case 'snowy':
      case 'snowy-rainy':
        return 'snowy';
      case 'clear-night':
        return 'clear-night';
      case 'lightning':
        return 'lightning';
      default:
        return 'default';
    }
  }

  render() {
    // Debug: afficher les informations de l'entité
    console.log('MeteoCard Debug:', {
      entity: this.entity,
      config: this.config,
      entityId: this.config?.entity,
      state: this.entity?.state,
      attributes: this.entity?.attributes
    });

    if (!this.entity) {
      return html`
        <ha-card class="error">
          <div class="error-content">
            <div class="error-title">Entité non trouvée</div>
            <div class="error-text">L'entité ${this.config?.entity} n'existe pas</div>
          </div>
        </ha-card>
      `;
    }

    // Vérifier que l'entité a les attributs nécessaires
    if (!this.entity.attributes || this.entity.attributes.temperature === undefined) {
      return html`
        <ha-card class="error">
          <div class="error-content">
            <div class="error-title">Données météo manquantes</div>
            <div class="error-text">L'entité ${this.config?.entity} n'a pas d'attribut température</div>
          </div>
        </ha-card>
      `;
    }

    const currentTemp = Math.round(this.entity.attributes.temperature || 0);
    const condition = this.entity.state;
    const bg = this._background(condition);
    
    // Utiliser les prévisions du jour si disponibles, sinon les attributs de base
    const tempLow = this.today?.templow ?? this.entity.attributes.temperature_low ?? currentTemp - 5;
    const tempHigh = this.today?.temperature ?? this.entity.attributes.temperature_high ?? currentTemp + 5;

    return html`
      <ha-card class="weather-card ${bg}">
        <div class="weather-content">
          <div class="location">${this._getLocationName()}</div>
          <div class="current-temp">${currentTemp}°</div>
          <div class="condition">${this._getConditionText(condition)}</div>
          <div class="temp-range">
            <span class="temp-high">↑ ${Math.round(tempHigh)}°</span>
            <span class="temp-low">↓ ${Math.round(tempLow)}°</span>
          </div>
        </div>
      </ha-card>
    `;
  }

  static get styles() {
    return css`
      :host {
        --meteo-card-height: 120px;
        height: var(--meteo-card-height) !important;
        min-height: var(--meteo-card-height) !important;
        max-height: var(--meteo-card-height) !important;
      }

      ha-card {
        height: var(--meteo-card-height) !important;
        min-height: var(--meteo-card-height) !important;
        border-radius: 16px;
        border: none;
        box-shadow: 0 4px 20px rgba(0,0,0,0.1);
        overflow: hidden;
        background: var(--card-background-color);
        position: relative;
        color: white;
        font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
      }

      .weather-content {
        padding: 12px;
        height: 100%;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        text-align: center;
        position: relative;
        z-index: 2;
      }

      .location {
        font-size: 14px;
        font-weight: 300;
        margin-bottom: 2px;
        opacity: 0.9;
        text-transform: capitalize;
      }

      .current-temp {
        font-size: 36px;
        font-weight: 100;
        line-height: 1;
        margin: 2px 0;
        text-shadow: 0 2px 4px rgba(0,0,0,0.3);
      }

      .condition {
        font-size: 12px;
        font-weight: 400;
        margin-bottom: 4px;
        opacity: 0.9;
      }

      .temp-range {
        display: flex;
        gap: 12px;
        font-size: 12px;
        font-weight: 500;
      }

      .temp-high, .temp-low {
        opacity: 0.9;
      }

      /* Backgrounds avec effets de nuages */
      .sunny {
        background: linear-gradient(135deg, #74b9ff 0%, #0984e3 100%);
      }

      .sunny::before {
        content: '';
        position: absolute;
        top: -50%;
        left: -50%;
        width: 200%;
        height: 200%;
        background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><filter id="noiseFilter"><feTurbulence type="fractalNoise" baseFrequency="0.9" numOctaves="1" stitchTiles="stitch"/><feColorMatrix type="saturate" values="0"/></filter></defs><rect width="100%" height="100%" filter="url(%23noiseFilter)" opacity="0.1"/></svg>') repeat;
        opacity: 0.3;
        z-index: 1;
        animation: float 20s ease-in-out infinite;
      }

      .partlycloudy {
        background: linear-gradient(135deg, #74b9ff 0%, #0984e3 80%, #636e72 100%);
      }

      .cloudy {
        background: linear-gradient(135deg, #636e72 0%, #2d3436 100%);
      }

      .rainy {
        background: linear-gradient(135deg, #636e72 0%, #2d3436 100%);
      }

      .snowy {
        background: linear-gradient(135deg, #ddd6fe 0%, #8b5cf6 100%);
      }

      .clear-night {
        background: linear-gradient(135deg, #2d3436 0%, #000000 100%);
      }

      .lightning {
        background: linear-gradient(135deg, #2d3436 0%, #636e72 50%, #2d3436 100%);
      }

      .default {
        background: linear-gradient(135deg, #74b9ff 0%, #0984e3 100%);
      }

      .error {
        background: linear-gradient(135deg, #fd79a8 0%, #e84393 100%);
        color: white;
      }

      .error-content {
        padding: 24px;
        text-align: center;
      }

      .error-title {
        font-size: 18px;
        font-weight: 600;
        margin-bottom: 8px;
      }

      .error-text {
        font-size: 14px;
        opacity: 0.8;
      }

      @keyframes float {
        0%, 100% { transform: translateY(0px) rotate(0deg); }
        33% { transform: translateY(-10px) rotate(1deg); }
        66% { transform: translateY(5px) rotate(-1deg); }
      }

      /* Animation subtile au hover */
      .weather-card {
        transition: transform 0.2s ease;
      }

      .weather-card:hover {
        transform: translateY(-2px);
      }
    `;
  }
}

customElements.define('meteo-card', MeteoCard);
