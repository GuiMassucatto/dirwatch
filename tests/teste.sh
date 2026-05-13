#!/usr/bin/env bash

echo "==============================="
echo " INICIANDO TESTE AUTOMÁTICO"
echo "==============================="

sleep 2

# ==========================
# CRIAÇÃO
# ==========================

echo "Criando arquivo..."

touch ./monitored/teste.txt

sleep 3

# ==========================
# MODIFICAÇÃO
# ==========================

echo "Modificando arquivo..."

echo "Teste do DirWatch" >> ./monitored/teste.txt

sleep 3

# ==========================
# REMOÇÃO
# ==========================

echo "Removendo arquivo..."

rm ./monitored/teste.txt

sleep 2

echo "==============================="
echo " TESTE FINALIZADO"
echo "==============================="
