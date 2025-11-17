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

#TAMANHOS POSSÍVEIS CASO -t: al
TAM_AL=(10 100 1000 10000 100000)

#LOG DE SAÍDA
LOG="log_${ALGORITIMO}_${LINGUAGEM}_${TAMANHO}_${CASO}.csv"

#CSV COM CABEÇALHO
case $LINGUAGEM in
    c)
        case $ALGORITIMO in
            bubblesort) PROGRAMA="./bubblesort-casos_c" ;;
            mergesort)  PROGRAMA="./mergesort-casos_c" ;;
            *) echo "Algoritmo inválido!"; exit ;;
        esac ;;
    
    python)
        case $ALGORITIMO in
            bubblesort) PROGRAMA="python3 bubblesort-casos.py" ;;
            mergesort)  PROGRAMA="python3 mergesort-casos.py" ;;
            *) echo "Algoritmo inválido!"; exit ;;
        esac ;;
    
    *)
        echo "Linguagem inválida!"; exit ;;
esac

for (( LOOP=0; LOOP < EXECUCOES; LOOP++ )); do

    if [ "$TAMANHO" == "al" ]; then
        TAM=${TAM_AL[$RANDOM % 5]}
        echo "Execução $((LOOP+1)): configuração de entrada escolhida aleatóriamente = $TAM"
    else
        TAM=$TAMANHO
    fi

    #TENTATIVA DE FILTRAR A IMPRESSÃO DO ALGORITMO DE ORDENAÇÃO PARA PEGAR TEMPO
    #RESULTADO=$($PROGRAMA $TAM $CASO | awk -F';' '{print $2}')
	RESULTADO=$($PROGRAMA $TAM $CASO)

    echo "$((LOOP+1)),$TAM,$RESULTADO" >> "$LOG"

done

echo "Log salvo em: $LOG"
exit
