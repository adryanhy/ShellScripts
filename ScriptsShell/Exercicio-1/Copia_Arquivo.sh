#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Uso: $0 <caminho_do_arquivo>"
    exit 1
fi

origem="$1"

if [ ! -f "$origem" ]; then
    echo "Erro: O arquivo $origem não existe."
    exit 1
fi

# Obtém o diretório e o nome base do arquivo de origem
diretorio=$(dirname "$origem")
nome_base=$(basename "$origem")


data_hora=$(date '+%d-%m-%y--%H-%M')

# Cria o nome do arquivo de destino com a data e hora
destino="${diretorio}/${nome_base}-${data_hora}"

cp "$origem" "$destino"

if [ $? -eq 0 ]; then
    mensagem_log="Cópia do arquivo $origem para $destino"

    echo "$mensagem_log" >> log_copias.txt

    echo "$mensagem_log"
else
    echo "Erro ao copiar o arquivo."
    exit 1
fi
