#!/usr/bin/env bash

# ==========================
# DIRWATCH
# Sistema de monitoramento de diretórios em Bash
# ==========================

# Carrega as configurações do sistema, como diretório monitorado, intervalo de verificação e local do arquivo de log.
source ./config/config.conf

# ==========================
# CORES ANSI
# ==========================
# Utilizadas para destacar visualmente os eventos detectados no terminal.

VERDE='\033[0;32m'
VERMELHO='\033[0;31m'
AMARELO='\033[1;33m'
RESET='\033[0m'

# ==========================
# CONTADORES DE EVENTOS
# ==========================
# Armazenam a quantidade de arquivos criados, modificados e removidos durante a execução do sistema.

criadas=0
modificadas=0
removidas=0

# ==========================
# VERIFICA DIRETÓRIO
# ==========================
# Garante que o diretório informado na configuração exista antes de iniciar o monitoramento.

if [[ ! -d "$DIR_MONITORADO" ]]
then
    echo "Erro: diretório não existe."
    exit 1
fi

# ==========================
# CRIA ARQUIVO DE LOG
# ==========================
# Caso o arquivo de log ainda não exista, ele é criado automaticamente.

if [[ ! -f "$LOG_FILE" ]]
then
    touch "$LOG_FILE"
fi

# ==========================
# TELA INICIAL
# ==========================
# Exibe informações básicas sobre a execução do sistema.

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
# Armazena uma fotografia inicial do diretório monitorado.
# Cada linha possui o formato: nome_do_arquivo:tamanho.

estado_antigo=""

for arquivo in $(ls "$DIR_MONITORADO")
do
    tamanho=$(wc -c < "$DIR_MONITORADO/$arquivo")

    estado_antigo="$estado_antigo
$arquivo:$tamanho"
done

# ==========================
# FUNÇÃO DE ENCERRAMENTO
# ==========================
# Executada quando o usuário pressiona CTRL+C e exibe estatísticas finais antes de encerrar o programa.

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

# Associa o sinal SIGINT (CTRL+C) à função de encerramento.
trap encerrar SIGINT

# ==========================
# MONITORAMENTO
# ==========================
# Executa continuamente enquanto o sistema estiver ativo.

while true
do
    estado_novo=""

    # ==========================
    # MONTA O ESTADO ATUAL
    # ==========================
    # Captura novamente os arquivos existentes e seus tamanhos para posterior comparação.

    for arquivo in $(ls "$DIR_MONITORADO")
    do
        tamanho=$(wc -c < "$DIR_MONITORADO/$arquivo")

        estado_novo="$estado_novo
$arquivo:$tamanho"
    done

    # ==========================
    # CRIAÇÃO E MODIFICAÇÃO
    # ==========================
    # Verifica se os arquivos atuais são novos ou tiveram alteração de tamanho desde a última leitura.

    for arquivo in $(ls "$DIR_MONITORADO")
    do
        tamanho_novo=$(wc -c < "$DIR_MONITORADO/$arquivo")

        linha_antiga=$(echo "$estado_antigo" | grep "^$arquivo:")

        # Arquivo não existia anteriormente.
        if [[ -z "$linha_antiga" ]]
        then
            mensagem="[CRIADO] $arquivo em $(date)"

            ((criadas++))

            echo -e "${VERDE}$mensagem${RESET}"
            echo "$mensagem" >> "$LOG_FILE"

        else
            tamanho_antigo=$(echo "$linha_antiga" | cut -d ":" -f 2)

            # Caso o tamanho seja diferente, considera-se que o arquivo foi modificado.
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
    # REMOÇÃO DE ARQUIVOS
    # ==========================
    # Percorre o estado anterior e verifica se algum arquivo deixou de existir no diretório monitorado.

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

    # ==========================
    # ATUALIZA REFERÊNCIA
    # ==========================
    # O estado atual passa a ser o estado antigo da próxima iteração.

    estado_antigo="$estado_novo"

    # Aguarda o intervalo definido antes de realizar nova verificação.
    sleep "$INTERVALO"
done
