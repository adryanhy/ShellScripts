#!/bin/bash

compactar_arquivos() {
    echo "Digite o nome do arquivo tar.gz a ser criado (ex: arquivo.tar.gz):"
    read nome_tar

    echo "Digite o caminho dos arquivos ou diretórios a serem compactados:"
    read arquivos

    tar -czvf "$nome_tar" $arquivos
    if [ $? -eq 0 ]; then
        echo "Arquivos compactados com sucesso em $nome_tar"
    else
        echo "Erro ao compactar arquivos."
    fi
}

descompactar_arquivos() {
    echo "Digite o nome do arquivo tar.gz a ser descompactado:"
    read nome_tar

    if [ ! -f "$nome_tar" ]; then
        echo "Erro: O arquivo $nome_tar não existe."
        return
    fi

    restore_dir="/home/restore"
    mkdir -p "$restore_dir"
    tar -xzvf "$nome_tar" -C "$restore_dir"
    if [ $? -eq 0 ]; then
        echo "Arquivos descompactados com sucesso em $restore_dir"
    else
        echo "Erro ao descompactar arquivos."
    fi
}

descompactar_unico_arquivo() {
    echo "Digite o nome do arquivo tar.gz:"
    read nome_tar

    if [ ! -f "$nome_tar" ]; then
        echo "Erro: O arquivo $nome_tar não existe."
        return
    fi

    echo "Digite o nome do arquivo a ser extraído:"
    read arquivo

    restore_dir="/home/restore"
    mkdir -p "$restore_dir"
    tar -xzvf "$nome_tar" -C "$restore_dir" "$arquivo"
    if [ $? -eq 0 ]; then
        echo "Arquivo $arquivo descompactado com sucesso em $restore_dir"
    else
        echo "Erro ao descompactar o arquivo $arquivo."
    fi
}

# Função para exibir o menu de opções
menu() {
    echo "Escolha uma opção:"
    echo "1 - Compactar arquivos com TAR"
    echo "2 - Descompactar arquivos"
    echo "3 - Descompactar um único arquivo de um arquivo tar.gz"
    echo "4 - Sair"
    read opcao

    case $opcao in
        1) compactar_arquivos ;;
        2) descompactar_arquivos ;;
        3) descompactar_unico_arquivo ;;
        4) exit 0 ;;
        *) echo "Opção inválida! Por favor, escolha uma opção válida." ;;
    esac
}

while true; do
    menu
done
