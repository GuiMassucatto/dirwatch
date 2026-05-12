#!/usr/bin/env bash

# ==========================
# DIRWATCH
# Sistema de monitoramento
# ==========================

source ./config/config.conf

# Verifica diretório
if [[ ! -d "$DIR_MONITORADO" ]]
then
    echo "Erro: diretório não existe."
    exit 1
fi

# Cria log
if [[ ! -f "$LOG_FILE" ]]
then
    touch "$LOG_FILE"
fi

echo "===================================="
echo " DIRWATCH INICIADO"
echo "===================================="
echo "Monitorando: $DIR_MONITORADO"
echo "Intervalo: ${INTERVALO}s"
echo "===================================="

# Estado inicial
estado_antigo=""

for arquivo in $(ls "$DIR_MONITORADO")
do
    tamanho=$(wc -c < "$DIR_MONITORADO/$arquivo")

    estado_antigo="$estado_antigo
$arquivo:$tamanho"
done

while true
do
    estado_novo=""

    # Monta estado novo
    for arquivo in $(ls "$DIR_MONITORADO")
    do
        tamanho=$(wc -c < "$DIR_MONITORADO/$arquivo")

        estado_novo="$estado_novo
$arquivo:$tamanho"
    done

    # ==========================
    # CRIAÇÃO E MODIFICAÇÃO
    # ==========================
    for arquivo in $(ls "$DIR_MONITORADO")
    do
        tamanho_novo=$(wc -c < "$DIR_MONITORADO/$arquivo")

        linha_antiga=$(echo "$estado_antigo" | grep "^$arquivo:")

        # Arquivo criado
        if [[ -z "$linha_antiga" ]]
        then
            mensagem="[CRIADO] $arquivo em $(date)"

            echo "$mensagem"
            echo "$mensagem" >> "$LOG_FILE"
        else
            tamanho_antigo=$(echo "$linha_antiga" | cut -d ":" -f 2)

            # Arquivo modificado
            if [[ "$tamanho_antigo" != "$tamanho_novo" ]]
            then
                mensagem="[MODIFICADO] $arquivo em $(date)"

                echo "$mensagem"
                echo "$mensagem" >> "$LOG_FILE"
            fi
        fi
    done

    # ==========================
    # REMOÇÃO
    # ==========================
    for linha in $(echo "$estado_antigo")
    do
        arquivo=$(echo "$linha" | cut -d ":" -f 1)

        if [[ -n "$arquivo" ]]
        then
            if ! ls "$DIR_MONITORADO" | grep -q "^$arquivo$"
            then
                mensagem="[REMOVIDO] $arquivo em $(date)"

                echo "$mensagem"
                echo "$mensagem" >> "$LOG_FILE"
            fi
        fi
    done

    # Atualiza estado
    estado_antigo="$estado_novo"

    sleep "$INTERVALO"
done
