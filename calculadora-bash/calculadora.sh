#!/bin/bash

echo ""
echo "***********************************************************************"
echo "***************        Calculadora             ************************"
echo "***********************************************************************"
echo ""

printf "Digite o primeiro numero\n: ";
read numero1
printf "Digite o segundo numero\n: ";
read numero2

function soma() {
ns=$(($numero1 + $numero2))
echo "Resultado: $ns";
echo ""

}

function subtracao() {
ns=$(($numero1 - $numero2))
echo "Resultado: $ns";
echo ""

}

function divisao() {
ns=$(($numero1 / $numero2))
echo "Resultado: $ns";
echo ""

}

function multiplicacao() {
ns=$(($numero1 * $numero2))
echo "Resultado: $ns";
echo ""

}
echo "Escolha a opção desejada:"
echo "1 - Soma";
echo "2 - Subtrair";
echo "3 - Multiplicar";
echo "4 - Dividir"
echo "5 - Sair"
read -p "Digite uma opção: " opcaoDigitada

if [ "$opcaoDigitada" = 1 ]; 
then
   soma
elif [ "$opcaoDigitada" = 2 ]
  then
   subtracao
elif [ "$opcaoDigitada" = 3 ]
  then 
   multiplicacao
elif [ "$opcaoDigitada" = 4 ]
  then 
   divisao
elif [ "$opcaoDigitada" = 5 ]
  then 
   exit;
else
 echo "opção inválida";
fi

