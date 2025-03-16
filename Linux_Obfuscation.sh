#!/bin/bash

# Fonction d'obfuscation de la commande
obfuscate_command() {
    local cmd="$1"
    # Appliquer les remplacements
    local obfuscated_cmd=$(echo "$cmd" | sed \
        -e 's/,/{ls,-la}/g' \
        -e 's/ /${IFS}/g' \
        -e 's/;/${LS_COLORS:10:1}/g' \
        -e 's#/#${PATH:0:1}#g')

    # Vérifier si la commande a été modifiée
    if [[ "$obfuscated_cmd" == "$cmd" ]]; then
        echo -e "\n⚠️  Aucun caractère spécifique n'a été modifié."
        echo -e "💡 Exemples d'obfuscation possibles :"
        echo -e "   - Mettre des majuscules aléatoires : WhoAmI"
	echo -e '	Run la commande avec : $(a="WhOaMi";printf %s "${a,,}")'
        echo -e "   - Ajouter des doubles apostrophes : who''ami"
        echo -e "   - Ajouter au milieu de votre fonction \$@ ou encore \\. Exemple : who\$@am\\i"
    else
        echo -e "\n🔹 Commande obfusquée :"
        echo "$obfuscated_cmd"
    fi
}

# Fonction d'inversion de la commande
reverse_command() {
    local cmd="$1"
    local reversed_cmd=$(echo "$cmd" | rev)

    echo -e "\n🔹 Commande inversée :"
    echo "$reversed_cmd"

    echo -e "\n💡 Pour exécuter votre commande, utilisez :"
    echo "\$(rev<<<'$reversed_cmd')"
}

# Fonction d'encodage Base64
encode_base64() {
    local cmd="$1"
    local encoded_cmd=$(echo -n "$cmd" | base64)

    echo -e "\n🔹 Commande encodée en Base64 :"
    echo "$encoded_cmd"

    echo -e "\n💡 Pour exécuter votre commande, utilisez :"
    echo "bash -c \"\$(echo '$encoded_cmd' | base64 -d)\""
    echo "Ou encore bash<<<\$(base64 -d<<<$encoded_cmd)"
}

# Menu interactif
while true; do
    # Demande à l'utilisateur de saisir une commande
    read -p "Entrez la commande à modifier : " cmd

    # Vérifie si la commande est vide
    if [[ -z "$cmd" ]]; then
        echo -e "❌ Erreur : Vous devez entrer une commande !"
        continue
    fi

    echo -e "\n🔹 Que voulez-vous faire avec cette commande ?"
    echo "1. Obfusquer la commande"
    echo "2. Inverser la commande"
    echo "3. Encoder en Base64"
    echo "4. Quitter"

    # Demande le choix de l'utilisateur
    read -p "Entrez votre choix (1-4) : " choice

    case $choice in
        1) obfuscate_command "$cmd" ;;
        2) reverse_command "$cmd" ;;
        3) encode_base64 "$cmd" ;;
        4) echo "👋 Au revoir !"; exit ;;
        *) echo "❌ Option invalide, veuillez choisir entre 1 et 4." ;;
    esac

    echo -e "\n🔄 Retour au menu..."
done
