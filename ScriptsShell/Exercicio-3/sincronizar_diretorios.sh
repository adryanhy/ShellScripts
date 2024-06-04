#!/bin/bash

sincronizar_diretorios() {
    echo "Digite o caminho do diretório de origem (produção):"
    read origem

    echo "Digite o caminho do diretório de destino (backup):"
    read destino

    if [ ! -d "$origem" ]; then
        echo "Erro: O diretório de origem $origem não existe."
        return
    fi

    if [ ! -d "$destino" ]; then
        echo "O diretório de destino $destino não existe. Criando diretório..."
        mkdir -p "$destino"
    fi

    # Sincroniza os arquivos usando rsync
    rsync -av --update "$origem/" "$destino/"

    if [ $? -eq 0 ]; then
        echo "Sincronização concluída com sucesso."
    else
        echo "Erro ao sincronizar os diretórios."
    fi
}

menu() {
    echo "Escolha uma opção:"
    echo "1 - Sincronizar diretórios"
    echo "2 - Sair"
    read opcao

    case $opcao in
        1) sincronizar_diretorios ;;
        2) exit 0 ;;
        *) echo "Opção inválida!" ;;
    esac
}

while true; do
    menu
done
