set terminal pngcairo size 1280,720

# Remover ".csv" do nome do arquivo
base = ARQUIVO
pos = strstrt(base, ".csv")
if (pos > 0) {
    base = substr(base, 1, pos-1)
}

set output sprintf("%s.png", base)

# estetica do grafico

set border lw 2
set grid lw 2 lc rgb "black"
set key top left box opaque 
# set style line 1 lw 3 lc rgb "#d62728" pt 7 ps 1.5
# set style line 2 lw 3 lc rgb "#1f77b4" pt 7 ps 1.5 

set xlabel "X"
set ylabel "Y"

set datafile separator ";"
set key autotitle columnheader
plot ARQUIVO using 1:2 every ::1 with lines lc "red" title "Tamanho x Tempo"

set output
set terminal qt persist
replot

print sprintf("Gráfico salvo em: %s.png", base)

