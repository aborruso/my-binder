#!/bin/bash

set -euo pipefail

# Configurazioni
DATA_REPO="https://github.com/aborruso/my-binder-data.git"
BRANCH="main"
DEST_DIR="/home/jovyan/file"
LOG_FILE="/tmp/file_clone.log"

# Funzione per loggare i messaggi
log() {
    local timestamp
    timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$timestamp] $1" | tee -a "$LOG_FILE"
}

# Verifica se git è installato
if ! command -v git &> /dev/null; then
    log "ERRORE: Git non è installato!"
    exit 1
fi

# Crea directory temporanea
TEMP_DIR=$(mktemp -d)
trap 'rm -rf "$TEMP_DIR"' EXIT

log "Inizio operazione di clonazione..."
log "Repository: $DATA_REPO"
log "Branch: $BRANCH"
log "Destinazione: $DEST_DIR"

# Clona solo la cartella `file`
log "Clonazione della cartella 'file'..."
if ! git clone --branch "$BRANCH" --depth 1 --filter=blob:none --sparse "$DATA_REPO" "$TEMP_DIR" >> "$LOG_FILE" 2>&1; then
    log "ERRORE: Clonazione fallita!"
    exit 1
fi

cd "$TEMP_DIR"
git sparse-checkout set file >> "$LOG_FILE" 2>&1

# Crea directory di destinazione
log "Creazione directory di destinazione..."
mkdir -p "$DEST_DIR"

# Copia i file
log "Copia dei file..."
if ! cp -r file/* "$DEST_DIR" >> "$LOG_FILE" 2>&1; then
    log "ERRORE: Copia dei file fallita!"
    exit 1
fi

# Verifica il contenuto copiato
log "Verifica dei file copiati..."
if [ -z "$(ls -A "$DEST_DIR")" ]; then
    log "ERRORE: La directory di destinazione è vuota!"
    exit 1
fi

log "Operazione completata con successo!"
log "File disponibili in: $DEST_DIR"
log "Log completo disponibile in: $LOG_FILE"
