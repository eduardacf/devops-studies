#!/bin/bash


echo ""
echo "***********************************************************************"
echo "******************Bem vindo ao compactador de arquivos*****************"
echo "***********************************************************************"

echo ""
echo "Escolha a opção desejada:"
echo "1 - Compactar para .zip"
echo "2 - Sair"
read opcaoDigitada

compactarZip(){
   echo -n "Digite a pasta que deseja compactar:"
   read PASTA
compactar=$(zip -r $PASTA.zip $PASTA)

today=$(date +%Y_%m_%d__%H_%M_%S);
 if [ $? -eq 0 ]; then
      echo "Arquivo compactado com sucesso!"
      echo "Movendo para .backup/data/DataDeHoje... "
        mkdir -p ./backup/data/$today/ 
        mv ${PASTA%/}.zip backup/data/$today/; 
   else
       echo "Arquivo não localizado :("
 fi

}

if [ "$opcaoDigitada" = 1 ]; 
then
   compactarZip
elif [ "$opcaoDigitada" = 2 ]
  then
   exit;
else
 echo "opção inválida";
fi

