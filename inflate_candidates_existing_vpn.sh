#!/bin/bash

# Demander l'ID de l'offre à l'utilisateur
echo "🔍 Script d'inflation de candidatures VIE"
echo "========================================"
echo ""

# Demander l'ID de l'offre
read -p "Entrez l'ID de l'offre VIE (ex: 228195): " OFFER_ID

# Valider que l'ID est un nombre
if ! [[ "$OFFER_ID" =~ ^[0-9]+$ ]]; then
    echo "❌ Erreur: L'ID doit être un nombre entier"
    exit 1
fi

# Construire l'URL avec l'ID fourni
URL="https://civiweb-api-prd.azurewebsites.net/api/Offers/ApplyLink/$OFFER_ID"

echo ""
echo "🎯 URL cible: $URL"
echo ""

# Demander le nombre d'appels
read -p "Nombre d'appels à effectuer (défaut: 3): " NUM_CALLS
NUM_CALLS=${NUM_CALLS:-3}

# Valider que le nombre d'appels est un nombre positif
if ! [[ "$NUM_CALLS" =~ ^[0-9]+$ ]] || [ "$NUM_CALLS" -lt 1 ]; then
    echo "❌ Erreur: Le nombre d'appels doit être un nombre positif"
    exit 1
fi

echo ""
echo "📊 Configuration:"
echo "   - ID Offre: $OFFER_ID"
echo "   - Nombre d'appels: $NUM_CALLS"
echo ""

# Fonction pour vérifier si NordVPN est connecté via l'interface graphique
check_nordvpn_gui() {
    # Vérifier si le processus NordVPN est en cours d'exécution
    if pgrep -f "NordVPN" > /dev/null; then
        # Vérifier la connexion réseau pour voir si on passe par NordVPN
        local current_ip=$(curl -s https://ipinfo.io/ip 2>/dev/null)
        local nordvpn_ip=$(curl -s https://nordvpn.com/ip 2>/dev/null)
        
        if [ "$current_ip" = "$nordvpn_ip" ]; then
            return 0
        fi
    fi
    return 1
}

# Fonction pour vérifier la connexion VPN via les routes réseau
check_vpn_connection() {
    # Vérifier si on a une route VPN active
    if netstat -rn | grep -q "utun\|tun"; then
        return 0
    fi
    return 1
}

# Fonction pour afficher l'IP actuelle
show_current_ip() {
    echo "🌐 IP actuelle: $(curl -s https://ipinfo.io/ip 2>/dev/null)"
    echo "📍 Localisation: $(curl -s https://ipinfo.io/country 2>/dev/null)"
}

echo "🔍 Vérification de la connexion VPN..."

# Vérifier si NordVPN GUI est connecté
if check_nordvpn_gui; then
    echo "✅ NordVPN GUI détecté et connecté!"
    show_current_ip
elif check_vpn_connection; then
    echo "✅ Connexion VPN détectée (probablement NordVPN GUI)"
    show_current_ip
else
    echo "❌ Aucune connexion VPN détectée"
    echo ""
    echo "📋 Pour vous connecter à NordVPN:"
    echo "   1. Ouvrez l'application NordVPN"
    echo "   2. Cliquez sur 'Quick Connect' ou choisissez un serveur"
    echo "   3. Attendez que la connexion soit établie"
    echo "   4. Relancez ce script"
    echo ""
    exit 1
fi

echo ""
echo "🚀 Démarrage des appels avec protection VPN..."

for i in $(seq 1 $NUM_CALLS); do
  # Vérifier que le VPN est toujours connecté avant chaque appel
  if ! check_vpn_connection; then
    echo "❌ VPN déconnecté! Arrêt du script."
    exit 1
  fi
  
  echo "Appel #$i"
  curl "$URL" \
    -X POST \
    -H 'Accept: application/json, text/plain, */*' \
    -H 'Accept-Language: fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7' \
    -H 'Cache-Control: no-cache' \
    -H 'Connection: keep-alive' \
    -H 'Content-Length: 0' \
    -H 'Origin: https://mon-vie-via.businessfrance.fr' \
    -H 'Pragma: no-cache' \
    -H 'Referer: https://mon-vie-via.businessfrance.fr/' \
    -H 'Sec-Fetch-Dest: empty' \
    -H 'Sec-Fetch-Mode: cors' \
    -H 'Sec-Fetch-Site: cross-site' \
    -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36' \
    -H 'sec-ch-ua: "Not)A;Brand";v="8", "Chromium";v="138", "Google Chrome";v="138"' \
    -H 'sec-ch-ua-mobile: ?0' \
    -H 'sec-ch-ua-platform: "macOS"' \
    -s -o /dev/null -w "%{http_code}\n"

  sleep 2
done

echo ""
echo "✅ Script terminé avec succès!"
echo "🔒 Tous les appels ont été effectués via votre connexion VPN"
echo "📊 Résumé: $NUM_CALLS appels effectués pour l'offre #$OFFER_ID" 