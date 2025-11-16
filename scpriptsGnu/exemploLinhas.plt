set title "Exemplo de Linhas - Arquivo de Dados"
set xlabel "Eixo X"
set ylabel "Eixo Y"

plot "dadosLinha.dat" using 1:2 with lines linewidth 2 lc rgb "red" title "Dados", \
     "dadosLinha2.dat" using 1:2 with lines linewidth 2 lc rgb "blue" title "Dados2"
