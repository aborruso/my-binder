#!/bin/bash

# URL del repository dei dati
DATA_REPO="https://github.com/aborruso/my-binder-data.git"

# Branch da utilizzare (opzionale)
BRANCH="main"

# Cartella temporanea per clonare il repository
TEMP_DIR=$(mktemp -d)

# Cartella di destinazione per i file
DEST_DIR="/home/jovyan/file"

# Clona solo la cartella `file` dal repository
echo "Clonazione della cartella 'file'..."
git clone --branch "$BRANCH" --depth 1 --filter=blob:none --sparse "$DATA_REPO" "$TEMP_DIR"
cd "$TEMP_DIR"
git sparse-checkout set file

# Copia la cartella `file` nella destinazione
echo "Copia dei file in $DEST_DIR..."
mkdir -p "$DEST_DIR"
cp -r file/* "$DEST_DIR"

# Pulizia: elimina la cartella temporanea
echo "Pulizia..."
rm -rf "$TEMP_DIR"

echo "Operazione completata! I file sono disponibili in $DEST_DIR."
