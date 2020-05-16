#!/bin/bash

echo ""
echo "***********************************************************************"
echo "*****************            Microservice CALCULADORA            **********************"
echo "***********************************************************************"
echo ""

function verificarSeEstaRodando() {
    [ "$(sudo docker ps -a -q -f name=$name)" ]
}

function verificarSeExisteAImagem() {
    [ "$(sudo docker images -q $nomeImagem)" ]
}

function startMicroservice() {
    if ! verificarSeExisteAImagem; then
        echo "A imagem docker $nomeImagem ainda não existe e está sendo construida ... :)"
        sudo docker build -t $nomeImagem .
    fi

    if ! verificarSeEstaRodando; then
        sudo docker run --name $nomeImagem -p 8080:8080 $nomeImagem
        echo "O Microservico $nomeImagem está rodando em http://localhost:8080"
    else
        echo 'Imagem' $nomeImagem "será iniciada ..."
        sudo docker start $nomeImagem
    fi
}

function stopMicroservice() {
    if verificarSeEstaRodando && verificarSeExisteAImagem; then
        echo "A Imagem docker $nomeImagem foi pausada :("
        sudo docker stop $nomeImagem

    elif ! verificarSeEstaRodando && verificarSeExisteAImagem; then
        echo "A Imagem docker $nomeImagem não está em execução para ser pausada.... :)"
    else
        echo "A imagem com o nome" $nomeImagem "não existe."
    fi
}

function statusMicroservice() {
    if verificarSeEstaRodando && verificarSeExisteAImagem; then
        echo "RUNNING"
    else
        echo "NOT RUNING"
    fi
}

function setCommand() {
    command=$1
}

function setMicroserviceName() {
    nomeImagem=$1
}

function executarServico() {
    case $command in
    start)
        startMicroservice
        ;;
    status)
        statusMicroservice
        ;;
    stop)
        stopMicroservice
        ;;
    *)
        echo "Comando Inválido"
        ;;
    esac
}

setCommand $1
setMicroserviceName $2
executarServico



