#!/bin/bash
# VERIFICA QUANTIDADE DE PARAMETROS
if [ $# -ne 4 ]; then
	echo "Sintaxe errada!"
	echo "Utilize -l <linguagem> -a <algoritmo>"
	exit
fi

# PARAMETROS
LINGUAGEM=$2
ALGORITMO=$4
CASO=3
EXECUCOES=10

# ARQUIVOS
LOG_BRUTO="log_${ALGORITMO}_${LINGUAGEM}.csv"
echo "N_Execucao;Tamanho;Tempo" > "$LOG_BRUTO"

LOG_FLT="LogFLT_${ALGORITMO}_${LINGUAGEM}.csv"
echo "Tamanho;Tempo" > "$LOG_FLT"

# VERIFICA ALGORITMO
if [ "$ALGORITMO" != "mergesort" -a "$ALGORITMO" != "bubblesort" ]; then
	echo "Sintaxe de algoritmo errada!"
	echo "Utilize 'mergesort' ou 'bubblesort'"
	exit
fi

# VERIFICA LINGUAGEM E DEFINE COMANDO
case $LINGUAGEM in
	c)
		PROGRAMA="./${ALGORITMO}-casos_${LINGUAGEM}";;
	python)
		PROGRAMA="python3 ${ALGORITMO}-casos.py";;		
	*)
	echo "Sintaxe de linguagem errada!"
	echo "Utilize 'c' ou 'python'"
	exit;;
esac

# EXECUTA ARQUIVO DE ORDENACAO
for ENTRADA in 1 2 3 4 5
do
	TAMANHO=$(( 10 ** $ENTRADA ))
	
	for (( LOOP=0; LOOP < $EXECUCOES; LOOP++ )); do
		RESULTADO=$($PROGRAMA $TAMANHO $CASO)
		echo "$((LOOP+1));$TAMANHO;$RESULTADO" >> "$LOG_BRUTO"
	done
done
echo "Dados brutos salvos em: $LOG_BRUTO"

# CALCULO DAS MÉDIAS
# Lemos o arquivo bruto para gerar o filtrado
TAMANHOS_TESTADOS=$(cut -d ';' -f2 "$LOG_BRUTO" | tail -n +2 | sort -n | uniq)

for T in $TAMANHOS_TESTADOS; do
    TEMPOS=$(grep ";$T;" "$LOG_BRUTO" | cut -d ';' -f3)
    
    SOMA=0
    CONTA=0
    for TEMPO in $TEMPOS; do
        SOMA=$(echo "$SOMA + $TEMPO" | bc)
        CONTA=$((CONTA + 1))
    done

    if [ $CONTA -gt 0 ]; then
        MEDIA=$(echo "scale=7; $SOMA/$CONTA" | bc | awk '{printf "%.7f", $0}')
        echo "$T;$MEDIA" >> "$LOG_FLT"
    fi
done

echo "  -> Médias salvas em: $LOG_FLT"
exit