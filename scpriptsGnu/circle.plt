set title "Exemplo com Círculos"
set xlabel "Eixo X"
set ylabel "Eixo Y"
set size ratio 1       # mantém escala 1:1 para ficar redondo

plot "circulo.dat" using 1:2:3 with circles lc rgb "blue" fs transparent solid 0.3 border rgb "black" title "Círculos"
