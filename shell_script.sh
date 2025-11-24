#!/bin/bash

# VERIFICA QUANTIDADE DE PARAMETROS
if [ $# -ne 4 ]; then
	echo "Sintaxe errada!"
	echo "Utilize -l <linguagem> -a <algoritimo> -n <execuções> -t <tamanho> -c <caso>"
	exit
fi

# PARAMETROS
LINGUAGEM=$2
ALGORITIMO=$4
EXECUCOES=10
CASO=3

#ARQUIVOS
ARQUIVO_RESULTADOS="resultados-${ALGORITIMO}_caso-${CASO}_${LINGUAGEM}.csv"
echo "N_Execucao;Tamanho;Tempo_Execucao" > "$ARQUIVO_RESULTADOS"
ARQUIVO_MEDIAS="medias.csv"
echo "Tamanho;Media" > "$ARQUIVO_MEDIAS"

#VERIFICA ALGORITIMO
if [ $ALGORITIMO != "mergesort" -a $ALGORITIMO != "bubblesort" ]; then
	echo "Sintaxe de algoritimo errada!"
	echo "Utilize 'mergesort' ou 'bubblesort'"
	exit
fi

#VERIFICA LINGUAGEM E ABRE ARQUIVO DE ORDENACAO
case $LINGUAGEM in
	c)
		PROGRAMA="./${ALGORITIMO}-casos_${LINGUAGEM}";;
	python)
		PROGRAMA="python3 ${ALGORITIMO}-casos.py";;		
	*)
	echo "Sintaxe de linguagem errada!"
	echo "Utilize 'c' ou 'python'"
	exit;;
esac

# EXECUTA ARQUIVO DE ORDENACAO
for ENTRADA in 1 2 3 4 5
do
	TAMANHO=$(( 10 ** $ENTRADA ))
	for (( LOOP=0;  LOOP < $EXECUCOES; LOOP++ ));do
		RESULTADO=$($PROGRAMA $TAMANHO $CASO)
		echo "$((LOOP+1));$RESULTADO" >> "$ARQUIVO_RESULTADOS"
	done
done
echo "Resultados salvos em: $ARQUIVO_RESULTADOS"


#VETOR DOS TEMPOS
VET_TEMPOS=($(cut -d ';' -f3 "$ARQUIVO_RESULTADOS"))

# CALCULO DAS MEDIAS
for ((i=1; i<${#VET_TEMPOS[@]}; i+=$EXECUCOES)); do
	SOMA=0

	for ((j=0; j<10 ; j++)); do
		SOMA=$(echo "$SOMA + ${VET_TEMPOS[i+j]}" | bc)
	done
	
	MEDIA=$(echo "scale=8; $SOMA/$EXECUCOES" | bc)
    	echo "$((10 ** (i/10 + 1)));$MEDIA" >> "$ARQUIVO_MEDIAS"
done

echo "Médias de tempo salvas em: $ARQUIVO_MEDIAS"

exit