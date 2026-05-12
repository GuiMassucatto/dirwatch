#!/usr/bin/env bash

# ==========================
# DIRWATCH
# Sistema de monitoramento
# de diretórios em Bash
# ==========================

# Carrega configurações
source ./config/config.conf

# Verifica diretório
if [[ ! -d "$DIR_MONITORADO" ]]
then
    echo "Erro: diretório monitorado não existe."
    exit 1
fi

# Verifica log
if [[ ! -f "$LOG_FILE" ]]
then
    touch "$LOG_FILE"
fi

echo "===================================="
echo " DIRWATCH INICIADO"
echo "===================================="
echo "Monitorando: $DIR_MONITORADO"
echo "Intervalo: ${INTERVALO}s"
echo "Log: $LOG_FILE"
echo "===================================="

# Estado inicial
estado_antigo=$(ls -l "$DIR_MONITORADO")

while true
do
    estado_novo=$(ls -l "$DIR_MONITORADO")

    # ==========================
    # VERIFICAR CRIAÇÕES
    # ==========================
    for arquivo in $(ls "$DIR_MONITORADO")
    do
        if ! echo "$estado_antigo" | grep -q "$arquivo"
        then
            mensagem="[CRIADO] $arquivo em $(date)"

            echo "$mensagem"
            echo "$mensagem" >> "$LOG_FILE"
        fi
    done

    # ==========================
    # VERIFICAR REMOÇÕES
    # ==========================
    for arquivo in $(echo "$estado_antigo" | grep -v "^total" | cut -d " " -f 9)
    do
        if ! ls "$DIR_MONITORADO" | grep -q "^$arquivo$"
        then
            mensagem="[REMOVIDO] $arquivo em $(date)"

            echo "$mensagem"
            echo "$mensagem" >> "$LOG_FILE"
        fi
    done

    # ==========================
    # VERIFICAR MODIFICAÇÕES
    # ==========================
    for arquivo in $(ls "$DIR_MONITORADO")
    do
        linha_antiga=$(echo "$estado_antigo" | grep "$arquivo")
        linha_nova=$(echo "$estado_novo" | grep "$arquivo")

        if [[ -n "$linha_antiga" && -n "$linha_nova" ]]
        then
            if [[ "$linha_antiga" != "$linha_nova" ]]
            then
                mensagem="[MODIFICADO] $arquivo em $(date)"

                echo "$mensagem"
                echo "$mensagem" >> "$LOG_FILE"
            fi
        fi
    done

    # Atualiza estado
    estado_antigo="$estado_novo"

    sleep "$INTERVALO"
done
