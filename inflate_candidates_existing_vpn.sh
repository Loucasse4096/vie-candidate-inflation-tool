#!/bin/bash

# Demander l'ID de l'offre à l'utilisateur
echo "🔍 Script d'inflation de candidatures VIE (Version Optimisée)"
echo "============================================================="
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

# Demander le délai entre les appels
read -p "Délai entre les appels en secondes (défaut: 0.5): " DELAY
DELAY=${DELAY:-0.5}

# Valider que le délai est un nombre positif
if ! [[ "$DELAY" =~ ^[0-9]+\.?[0-9]*$ ]] || [ "$(echo "$DELAY < 0" | bc -l 2>/dev/null)" = "1" ]; then
    echo "❌ Erreur: Le délai doit être un nombre positif"
    exit 1
fi

# Demander si on veut paralléliser
read -p "Paralléliser les appels ? (y/n, défaut: n): " PARALLEL
PARALLEL=${PARALLEL:-n}

echo ""
echo "📊 Configuration:"
echo "   - ID Offre: $OFFER_ID"
echo "   - Nombre d'appels: $NUM_CALLS"
echo "   - Délai entre appels: ${DELAY}s"
echo "   - Parallélisation: $([ "$PARALLEL" = "y" ] && echo "Oui" || echo "Non")"
echo ""

# Fonction optimisée pour vérifier la connexion VPN
check_vpn_connection() {
    # Vérification rapide via les routes réseau
    if netstat -rn | grep -q "utun\|tun"; then
        return 0
    fi
    return 1
}

# Fonction pour afficher l'IP actuelle (une seule fois)
show_current_ip() {
    echo "🌐 IP actuelle: $(curl -s https://ipinfo.io/ip 2>/dev/null)"
    echo "📍 Localisation: $(curl -s https://ipinfo.io/country 2>/dev/null)"
}

echo "🔍 Vérification de la connexion VPN..."

# Vérification unique du VPN au début
if check_vpn_connection; then
    echo "✅ Connexion VPN détectée!"
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

# Fonction pour effectuer un appel
make_call() {
    local call_num=$1
    echo "Appel #$call_num"
    local response=$(curl "$URL" \
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
        -s -o /dev/null -w "%{http_code}" 2>/dev/null)
    
    echo "   → Code de réponse: $response"
}

# Mode parallèle
if [ "$PARALLEL" = "y" ]; then
    echo "⚡ Mode parallèle activé - Lancement de tous les appels simultanément..."
    
    # Lancer tous les appels en arrière-plan
    for i in $(seq 1 $NUM_CALLS); do
        make_call $i &
    done
    
    # Attendre que tous les appels soient terminés
    wait
    
    echo ""
    echo "✅ Tous les appels parallèles terminés!"
else
    # Mode séquentiel optimisé
    echo "🔄 Mode séquentiel - Appels avec délai de ${DELAY}s..."
    
    for i in $(seq 1 $NUM_CALLS); do
        make_call $i
        
        # Délai réduit entre les appels (sauf pour le dernier)
        if [ $i -lt $NUM_CALLS ]; then
            sleep $DELAY
        fi
    done
fi

echo ""
echo "✅ Script terminé avec succès!"
echo "🔒 Tous les appels ont été effectués via votre connexion VPN"
echo "📊 Résumé: $NUM_CALLS appels effectués pour l'offre #$OFFER_ID"
echo "⏱️  Temps d'exécution optimisé!" 