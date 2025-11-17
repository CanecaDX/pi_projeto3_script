#!/bin/bash

# VERIFICA QUANTIDADE DE PARAMETROS
if [ $# -ne 10 ]; then
    echo "Sintaxe errada!"
    echo "Utilize -l <linguagem> -a <algoritmo> -n <execuções> -t <tamanho|al> -c <caso>"
    exit
fi

# PARAMETROS
LINGUAGEM=$2
ALGORITIMO=$4
EXECUCOES=$6
TAMANHO=$8
CASO=${10}

#TAMANHOS POSSÍVEIS CASO -t: al
TAMANHOS_ALEATORIOS=(10 100 1000 10000 100000)

#LOG DE SAÍDA
ARQUIVO="resultados_${LINGUAGEM}_${ALGORITIMO}_${CASO}.csv"

#CSV COM CABEÇALHO
echo "Execucao,Tamanho,TempoPrograma,TempoExecucao" > "$ARQUIVO"

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
        TAM_ESCOLHIDO=${TAMANHOS_ALEATORIOS[$RANDOM % 5]}
        echo "Execução $((LOOP+1)): tamanho aleatório escolhido = $TAM_ESCOLHIDO"
    else
        TAM_ESCOLHIDO=$TAMANHO
    fi

    INICIO=$(date +%s%N)
    RESULTADO=$($PROGRAMA $TAM_ESCOLHIDO $CASO)
    FIM=$(date +%s%N)
    TEMPO_EXEC=$(echo "scale=6; ($FIM - $INICIO)/1000000000" | bc)

    echo "$((LOOP+1)),$TAM_ESCOLHIDO,$RESULTADO,$TEMPO_EXEC" >> "$ARQUIVO"

done

echo "Resultados salvos em: $ARQUIVO"
exit
