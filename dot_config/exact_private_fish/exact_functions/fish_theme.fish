function fish_theme --argument- some_file
    if not test -f "$some_file"
        echo "Erreur : Fichier '$some_file' introuvable."
        return 1
    end

    while read -l line
        # On cible uniquement les lignes qui commencent par 'set -g'
        if string match -qr '^set -g' "$line"
            # 1. Extraire le nom de la variable (le 3ème mot de la ligne)
            set -l var_name (string split -m 3 ' ' $line)[3]

            # 2. Supprimer la variable globale qui "cache" la vue
            set -e -g $var_name

            # 3. Transformer 'set -g' en 'set -U' et exécuter
            set -l universal_cmd (string replace 'set -g' 'set -U' "$line")
            eval $universal_cmd
        end
    end <"$some_file"

    echo "✅ Thème appliqué ! (Les ombres globales ont été supprimées)"
end
