set title "Gráfico"
set xlabel "Eixo X"
set ylabel "Eixo Y"

set datafile separator ","
plot "resultados_c_bubblesort_1.csv" using 1:2 every ::1 with lines lc "red" title "testeCSV"
