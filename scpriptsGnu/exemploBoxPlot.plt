set title "Exemplo de Boxes 2D"
set style fill solid 1.0          # preenchimento das barras
set boxwidth 0.5                  # largura das barras
set xrange [0.5:5.5]              # apenas pra dar espaço

plot "dados.dat" using 1:2 with boxes lc rgb "blue" title "Valores"
