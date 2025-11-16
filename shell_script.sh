#!/bin/bash
# VERIFICA QUANTIDADE DE PARAMETROS
if [ $# -ne 10 ]; then
	echo "Sintaxe errada!"
	echo "Utilize -l <linguagem> -a <algoritmo> -n <execuções> -t <tamanho> -c <caso>"
	exit
fi

# PARAMETROS
LINGUAGEM=$2
ALGORITIMO=$4
EXECUCOES=$6
TAMANHO=$8
CASO=${10}

# ESCOLHA DO ARQUIVO
case $LINGUAGEM in
	c)
	case $ALGORITIMO in
		bubblesort)
		echo "Bubblesort em C"
		PROGRAMA="./bubblesort-casos_c";;
		
		mergesort)
		echo "Mergesort em C"
		PROGRAMA="./mergesort-casos_c";;
		
		*)
		echo "Sintaxe de algoritimo errada!"
		echo "Utilize 'bubblesort' ou 'mergesort'"
		exit;;
	esac;;

	python)
		case $ALGORITIMO in
		bubblesort)
		echo "Bubblesort em Python"
		PROGRAMA="python3 bubblesort-casos.py";;
		
		mergesort)
		echo "Mergesort em Python"
		PROGRAMA="python3 mergesort-casos.py";;
		
		*)
		echo "Sintaxe de algoritimo errada!"
		echo "Utilize 'bubblesort' ou 'mergesort'"
		exit;;
	esac;;
		
	*)
	echo "Sintaxe de linguagem errada!"
	echo "Utilize 'c' ou 'python'"
	exit;;
esac

# EXECUCAO DO ARQUIVO
echo "Tamanho | Tempo"
for (( LOOP=0;  LOOP < $EXECUCOES; LOOP++ ));do
	$PROGRAMA $TAMANHO $CASO
done

exit
