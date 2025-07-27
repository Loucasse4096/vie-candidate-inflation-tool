# 🔍 VIE Candidate Inflation Tool

> **⚠️ AVERTISSEMENT LÉGAL : Ce projet est fourni à des fins éducatives et de test uniquement. L'utilisation de cet outil pour manipuler des données réelles peut être illégale et violer les conditions d'utilisation des services ciblés.**

## 📋 Description

Outil de test de sécurité pour analyser la robustesse des systèmes de candidature VIE (Volontariat International en Entreprise). Ce projet permet de tester les mécanismes de protection contre les attaques automatisées et l'inflation artificielle de candidatures.

## 🎯 Objectifs

- **Test de sécurité** : Évaluer la résistance aux attaques automatisées
- **Recherche académique** : Étudier les vulnérabilités des systèmes de candidature
- **Développement défensif** : Améliorer les mécanismes de protection
- **Éducation** : Comprendre les vecteurs d'attaque pour mieux s'en protéger

## 🚀 Installation

### Prérequis

- macOS (testé sur macOS 12+)
- Homebrew
- NordVPN (application graphique)
- Bash 4.0+

### Installation

```bash
# Cloner le repository
git clone https://github.com/votre-username/vie-candidate-inflation-tool.git
cd vie-candidate-inflation-tool

# Rendre le script exécutable
chmod +x inflate_candidates_existing_vpn.sh
```

## 🔧 Configuration

### 1. Connexion NordVPN

Assurez-vous d'être connecté à NordVPN via l'application graphique :

1. Ouvrez l'application NordVPN
2. Cliquez sur "Quick Connect" ou choisissez un serveur
3. Attendez que la connexion soit établie

### 2. Vérification de la connexion

Le script vérifie automatiquement :
- La présence du processus NordVPN
- Les routes réseau VPN
- L'IP publique pour confirmer la connexion

## 📖 Utilisation

### Exécution interactive

```bash
./inflate_candidates_existing_vpn.sh
```

Le script vous demandera :
1. **ID de l'offre VIE** (ex: 228195)
2. **Nombre d'appels** à effectuer (défaut: 3)

### Exemple d'utilisation

```bash
$ ./inflate_candidates_existing_vpn.sh

🔍 Script d'inflation de candidatures VIE
========================================

Entrez l'ID de l'offre VIE (ex: 228195): 228195
Nombre d'appels à effectuer (défaut: 3): 5

🎯 URL cible: https://civiweb-api-prd.azurewebsites.net/api/Offers/ApplyLink/228195

📊 Configuration:
   - ID Offre: 228195
   - Nombre d'appels: 5

🔍 Vérification de la connexion VPN...
✅ NordVPN GUI détecté et connecté!
🌐 IP actuelle: 185.xxx.xxx.xxx
📍 Localisation: NL

🚀 Démarrage des appels avec protection VPN...
Appel #1
200
Appel #2
200
...
```

## 🛡️ Fonctionnalités de sécurité

### Protection VPN
- **Détection automatique** de la connexion NordVPN
- **Vérification continue** de la connexion VPN
- **Arrêt automatique** si le VPN se déconnecte
- **Affichage de l'IP** pour confirmer l'anonymat

### Validation des entrées
- **Vérification** que l'ID est un nombre valide
- **Validation** du nombre d'appels
- **Protection** contre les entrées malveillantes

### Headers HTTP réalistes
- **User-Agent** de navigateur réel
- **Headers de sécurité** appropriés
- **Referer** et **Origin** cohérents
- **Accept-Language** français

## 📁 Structure du projet

```
vie-candidate-inflation-tool/
├── README.md                           # Documentation principale
├── inflate_candidates_existing_vpn.sh  # Script principal
├── .gitignore                          # Fichiers à ignorer
├── LICENSE                             # Licence du projet
└── docs/                               # Documentation supplémentaire
    ├── legal.md                        # Considérations légales
    └── security.md                     # Guide de sécurité
```

## ⚖️ Considérations légales et éthiques

### Usage autorisé
- ✅ Tests sur vos propres systèmes
- ✅ Recherche académique avec autorisation
- ✅ Tests de pénétration autorisés
- ✅ Développement de contre-mesures

### Usage interdit
- ❌ Manipulation de données réelles
- ❌ Attaques sur des systèmes tiers
- ❌ Violation des conditions d'utilisation
- ❌ Usage commercial sans autorisation

### Responsabilité
L'utilisateur est entièrement responsable de l'utilisation de cet outil. Les auteurs ne peuvent être tenus responsables de toute utilisation inappropriée.

## 🔒 Sécurité

### Bonnes pratiques
1. **Utilisez uniquement sur des systèmes autorisés**
2. **Respectez les rate limits**
3. **Documentez vos tests**
4. **Contactez l'organisation de manière responsable**
5. **Ne partagez pas les vulnérabilités publiquement**

### Protection VPN
- Le script nécessite une connexion VPN active
- Vérification automatique de la connexion
- Arrêt en cas de déconnexion VPN

## 🤝 Contribution

Les contributions sont les bienvenues ! Veuillez :

1. Fork le projet
2. Créer une branche pour votre fonctionnalité
3. Commit vos changements
4. Push vers la branche
5. Ouvrir une Pull Request

### Guidelines
- Respectez les standards de sécurité
- Documentez les nouvelles fonctionnalités
- Testez sur des environnements autorisés
- Suivez les bonnes pratiques éthiques

## 📄 Licence

Ce projet est sous licence MIT. Voir le fichier [LICENSE](LICENSE) pour plus de détails.

## ⚠️ Disclaimer

**ATTENTION** : Ce projet est fourni "tel quel" sans garantie. L'utilisation de cet outil pour des activités illégales est strictement interdite. Les auteurs ne sont pas responsables de toute utilisation inappropriée.

## 📞 Support

Pour des questions légitimes concernant la sécurité ou l'utilisation éthique :

- 📧 Email : [votre-email@domain.com]
- 🐛 Issues : [GitHub Issues](https://github.com/votre-username/vie-candidate-inflation-tool/issues)
- 📖 Wiki : [Documentation](https://github.com/votre-username/vie-candidate-inflation-tool/wiki)

---

**🔒 Utilisez cet outil de manière responsable et éthique** 