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
    # Afficher le numéro de ligne suivi de tabulations et du contenu de la ligne
    echo -e "${line_number}\t\t${line}"
    # Incrémenter le numéro de ligne
    ((line_number++))
done < "$1"

# Dans cet exercice , il est recommandé d'utiliser while read 
# cat ne peut pas lire un fichier ligne par ligne  individuellement 
# While read  est plus efficace avec les fichiers volimineux
# afin de traiter chaque ligne séparément
