#!/bin/bash

mostrar_conteudo_diretorio() {
    echo "Digite o caminho do diretório:"
    read diretorio

    if [ -d "$diretorio" ]; then
        echo "Conteúdo do diretório $diretorio:"
        ls "$diretorio"
    else
        echo "Erro: O diretório $diretorio não existe."
    fi
}


copiar_arquivo() {
    echo "Digite o caminho do arquivo de origem:"
    read origem

    echo "Digite o caminho do diretório de destino:"
    read destino

    if [ ! -f "$origem" ]; then
        echo "Erro: O arquivo $origem não existe."
        return
    fi

    if [ ! -d "$destino" ]; then
        echo "O diretório $destino não existe. Criando diretório..."
        mkdir -p "$destino"
    fi

    cp "$origem" "$destino"
    if [ $? -eq 0 ]; then
        echo "Arquivo copiado com sucesso para $destino"
    else
        echo "Erro ao copiar o arquivo."
    fi
}


mostrar_usuarios_logados() {
    log_acesso="/home/log_acesso.txt"
    users > "$log_acesso"
    echo "Usuários logados no sistema:"
    cat "$log_acesso"
    echo "Lista de usuários logados armazenada em $log_acesso"
}


copiar_arquivos_modificados() {
    echo "Digite o diretório de origem:"
    read origem

    echo "Digite o diretório de destino:"
    read destino

    if [ ! -d "$origem" ]; then
        echo "Erro: O diretório $origem não existe."
        return
    fi

    if [ ! -d "$destino" ]; then
        echo "O diretório $destino não existe. Criando diretório..."
        mkdir -p "$destino"
    fi

    find "$origem" -type f -mtime -1 -exec cp {} "$destino" \;
    echo "Arquivos modificados nas últimas 24 horas copiados para $destino"
}

# Função para exibir o menu de opções
menu() {
    echo "Escolha uma opção:"
    echo "1 - Mostrar conteúdo de um diretório"
    echo "2 - Copiar um arquivo"
    echo "3 - Mostrar usuários logados"
    echo "4 - Copiar arquivos modificados nas últimas 24 horas"
    echo "5 - Sair"
    read opcao

    case $opcao in
        1) mostrar_conteudo_diretorio ;;
        2) copiar_arquivo ;;
        3) mostrar_usuarios_logados ;;
        4) copiar_arquivos_modificados ;;
        5) exit 0 ;;
        *) echo "Opção inválida!" ;;
    esac
}

while true; do
    menu
done
