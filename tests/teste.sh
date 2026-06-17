#!/usr/bin/env bash

# ==========================
# CARREGA CONFIGURAÇÕES
# ==========================
# Importa as variáveis definidas no arquivo config.conf, como o diretório monitorado.
source ./config/config.conf

# ==========================
# VERIFICA DIRETÓRIO
# ==========================
# Verifica se o diretório definido na configuração existe. Caso não exista, encerra o script.
if [[ ! -d "$DIR_MONITORADO" ]]
then
    echo "Erro: diretório monitorado não existe."
    exit 1
fi

# ==========================
# ARQUIVO DE TESTE
# ==========================
# Define o caminho do arquivo que será utilizado durante os testes automáticos.
ARQUIVO_TESTE="$DIR_MONITORADO/teste.txt"

# Exibe mensagem de início do teste.
echo "==============================="
echo " INICIANDO TESTE AUTOMÁTICO"
echo "==============================="

sleep 2

# ==========================
# CRIAÇÃO DE ARQUIVO
# ==========================
# Cria um novo arquivo dentro do diretório monitorado para verificar se o DirWatch detecta o evento.
echo "Criando arquivo..."

touch "$ARQUIVO_TESTE"

sleep 3

# ==========================
# MODIFICAÇÃO DE ARQUIVO
# ==========================
# Adiciona conteúdo ao arquivo criado, simulando uma modificação para que o DirWatch registre o evento.
echo "Modificando arquivo..."

echo "Teste do DirWatch" >> "$ARQUIVO_TESTE"

sleep 3

# ==========================
# REMOÇÃO DE ARQUIVO
# ==========================
# Remove o arquivo de teste para verificar se o DirWatch detecta corretamente a exclusão.
echo "Removendo arquivo..."

rm "$ARQUIVO_TESTE"

sleep 2

# Exibe mensagem de término do teste.
echo "==============================="
echo " TESTE FINALIZADO"
echo "==============================="
