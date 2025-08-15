#!/bin/bash

echo "🚀 Configuration de l'environnement de développement pour la carte météo..."

# Installation des outils de développement
echo "📦 Installation des outils de développement..."
apt-get update
apt-get install -y curl wget git vim nano

# Installation de Node.js si pas déjà présent
if ! command -v node &> /dev/null; then
    echo "📦 Installation de Node.js..."
    curl -fsSL https://deb.nodesource.com/setup_lts.x | bash -
    apt-get install -y nodejs
fi

# Configuration Git (optionnel)
echo "🔧 Configuration Git..."
git config --global --add safe.directory /workspace

# Création d'un script de rechargement pour faciliter le développement
cat > /workspace/reload-card.sh << 'EOF'
#!/bin/bash
echo "🔄 Rechargement de la carte météo..."
cp /workspace/meteo-card.js /config/www/
echo "✅ Carte copiée ! Rafraîchissez votre navigateur sur http://localhost:8123"
EOF

chmod +x /workspace/reload-card.sh

echo "✅ Configuration terminée !"
echo ""
echo "🌤️  Carte météo prête pour le développement !"
echo "🌐 Home Assistant sera disponible sur : http://localhost:8123"
echo "🔄 Pour recharger la carte après modifications : ./reload-card.sh"
echo ""
echo "Démarrage de Home Assistant..."
