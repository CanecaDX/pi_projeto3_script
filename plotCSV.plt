set terminal pngcairo size 1280,720
set output "grafico.png"

# Remover ".csv" do nome do arquivo
base = ARQUIVO
pos = strstrt(base, ".csv")
if (pos > 0) {
    base = substr(base, 1, pos-1)
}

# estetica do grafico

set border lw 2
set grid lw 1 lc rgb "#bbbbbb"
set key top left box opaque 
# set style line 1 lw 3 lc rgb "#d62728" pt 7 ps 1.5
# set style line 2 lw 3 lc rgb "#1f77b4" pt 7 ps 1.5 

set xlabel "Tamanho"
set ylabel "Tempo"

set datafile separator ","
set key autotitle columnheader
plot ARQUIVO using 1:2 every ::1 with lines lc "red" title "testeCSV"

set output
