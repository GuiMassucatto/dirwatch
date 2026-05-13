#!/usr/bin/env bash

# ==========================
# DIRWATCH
# Sistema de monitoramento
# ==========================

source ./config/config.conf

# ==========================
# CORES
# ==========================

VERDE='\033[0;32m'
VERMELHO='\033[0;31m'
AMARELO='\033[1;33m'
RESET='\033[0m'

# ==========================
# CONTADORES
# ==========================

criadas=0
modificadas=0
removidas=0

# ==========================
# VERIFICA DIRETÓRIO
# ==========================

if [[ ! -d "$DIR_MONITORADO" ]]
then
    echo "Erro: diretório não existe."
    exit 1
fi

# ==========================
# CRIA LOG
# ==========================

if [[ ! -f "$LOG_FILE" ]]
then
    touch "$LOG_FILE"
fi

# ==========================
# TELA INICIAL
# ==========================

echo "===================================="
echo " DIRWATCH INICIADO"
echo "===================================="
echo "Monitorando: $DIR_MONITORADO"
echo "Intervalo: ${INTERVALO}s"
echo "Iniciado em: $(date '+%d/%m/%Y %H:%M:%S')"
echo "===================================="

# ==========================
# ESTADO INICIAL
# ==========================

estado_antigo=""

for arquivo in $(ls "$DIR_MONITORADO")
do
    tamanho=$(wc -c < "$DIR_MONITORADO/$arquivo")

    estado_antigo="$estado_antigo
$arquivo:$tamanho"
done

# ==========================
# ENCERRAMENTO
# ==========================

encerrar() {
    echo
    echo "===================================="
    echo " DIRWATCH ENCERRADO"
    echo "===================================="
    echo "Encerrado em: $(date '+%d/%m/%Y %H:%M:%S')"
    echo
    echo "Arquivos criados: $criadas"
    echo "Arquivos modificados: $modificadas"
    echo "Arquivos removidos: $removidas"
    echo
    echo "Log salvo em: $LOG_FILE"
    echo "Até logo!"
    exit 0
}

trap encerrar SIGINT

# ==========================
# MONITORAMENTO
# ==========================

while true
do
    estado_novo=""

    # ==========================
    # MONTA ESTADO NOVO
    # ==========================

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

	    ((criadas++))

            echo -e "${VERDE}$mensagem${RESET}"
            echo "$mensagem" >> "$LOG_FILE"

        else
            tamanho_antigo=$(echo "$linha_antiga" | cut -d ":" -f 2)

            # Arquivo modificado
            if [[ "$tamanho_antigo" != "$tamanho_novo" ]]
            then
                mensagem="[MODIFICADO] $arquivo em $(date)"

		((modificadas++))
		
                echo -e "${AMARELO}$mensagem${RESET}"
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

		((removidas++))

                echo -e "${VERMELHO}$mensagem${RESET}"
                echo "$mensagem" >> "$LOG_FILE"
            fi
        fi
    done

    # Atualiza estado
    estado_antigo="$estado_novo"

    sleep "$INTERVALO"
done
