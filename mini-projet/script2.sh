#!/bin/bash

# Vérification si un argument est fourni (nom du fichier)
if [ -z "$1" ]; then
    echo "Erreur : veuillez fournir le nom du fichier en argument."
    exit 1
fi

# Initialiser un compteur de ligne
line_number=1

# Lire le fichier ligne par ligne
while IFS= read -r line; do
    # Extraire l'URL de la ligne
    url=$(echo "$line" | cut -f1)
    
    # Faire la requête HTTP et récupérer le code de statut et l'encodage
    response=$(curl -s -I "$url")
    http_code=$(echo "$response" | grep "HTTP" | cut -d' ' -f2)
    encoding=$(echo "$response" | grep -i "content-type" | grep -o "charset=[^;]*" | cut -d'=' -f2)
    
    # Récupérer le contenu de la page et compter les mots
    page_content=$(curl -s "$url")
    word_count=$(echo "$page_content" | wc -w)
    
    # Si l'encodage n'est pas trouvé, mettre "non spécifié"
    if [ -z "$encoding" ]; then
        encoding="non spécifié"
    fi
    
    # Afficher la ligne avec les nouvelles informations
    echo -e "${line}\t${http_code}\t${encoding}\t${word_count}"
    
    ((line_number++))
done < "$1"
