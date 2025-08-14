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

  _background(condition) {
    switch (condition) {
      case 'sunny':
        return 'sunny';
      case 'rainy':
        return 'rainy';
      case 'cloudy':
        return 'cloudy';
      case 'snowy':
        return 'snowy';
      default:
        return 'default';
    }
  }

  _icon(condition) {
    const icons = {
      sunny: 'mdi:white-balance-sunny',
      rainy: 'mdi:weather-rainy',
      cloudy: 'mdi:weather-cloudy',
      snowy: 'mdi:weather-snowy',
      partlycloudy: 'mdi:weather-partly-cloudy',
    };
    return icons[condition] || 'mdi:weather-cloudy';
  }

  render() {
    if (!this.entity || !this.today) {
      return html`<ha-card>Aucune donnée météo</ha-card>`;
    }

    const bg = this._background(this.today.condition || this.entity.state);
    const low = this.today.templow !== undefined ? this.today.templow : this.today.temperature;
    const high = this.today.temperature;

    return html`
      <ha-card class="${bg}">
        <div class="header">
          <ha-icon icon="${this._icon(this.today.condition)}"></ha-icon>
          <div class="temps">
            <div class="high">${high}°</div>
            <div class="low">${low}°</div>
          </div>
        </div>
        <div class="forecast">
          ${this.entity.attributes.forecast.slice(0, 5).map(item => html`
            <div class="item">
              <div class="time">${new Date(item.datetime).toLocaleTimeString([], {hour: '2-digit', minute: '2-digit'})}</div>
              <ha-icon icon="${this._icon(item.condition)}"></ha-icon>
              <div class="temp">${item.temperature}°</div>
            </div>
          `)}
        </div>
      </ha-card>
    `;
  }

  static get styles() {
    return css`
      ha-card {
        color: var(--primary-text-color);
        padding: 16px;
      }
      .header {
        display: flex;
        justify-content: space-between;
        align-items: center;
      }
      .temps {
        display: flex;
        gap: 8px;
        font-size: 1.5em;
      }
      .forecast {
        display: flex;
        justify-content: space-between;
        margin-top: 16px;
      }
      .item {
        text-align: center;
        flex: 1;
      }
      .sunny {
        background: linear-gradient(to bottom, #4facfe, #00f2fe);
      }
      .rainy {
        background: linear-gradient(to bottom, #bdc3c7, #2c3e50);
      }
      .cloudy {
        background: linear-gradient(to bottom, #ece9e6, #ffffff);
      }
      .snowy {
        background: linear-gradient(to bottom, #e0eafc, #cfdef3);
      }
      .default {
        background: var(--card-background-color);
      }
    `;
  }
}

customElements.define('meteo-card', MeteoCard);
