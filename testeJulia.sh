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

#LOG DE SAÍDA
ARQUIVO="resultados-${ALGORITIMO}_caso-${CASO}_${LINGUAGEM}.csv"
echo "N_Execucao,Tamanho,Tempo_Execucao" > "$ARQUIVO"

# ESCOLHA DO ARQUIVO
case $LINGUAGEM in
c)
case $ALGORITIMO in
bubblesort)
PROGRAMA="./bubblesort-casos_c";;

mergesort)
PROGRAMA="./mergesort-casos_c";;

*)
echo "Sintaxe de algoritimo errada!"
echo "Utilize 'bubblesort' ou 'mergesort'"
exit;;
esac;;

python)
case $ALGORITIMO in
bubblesort)
PROGRAMA="python3 bubblesort-casos.py";;

mergesort)
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
for (( LOOP=0;  LOOP < $EXECUCOES; LOOP++ ));do
RESULTADO=$($PROGRAMA $TAMANHO $CASO)
echo "$((LOOP+1)),$RESULTADO" >> "$ARQUIVO"
done

echo "Resultados salvos em: $ARQUIVO"

exit

