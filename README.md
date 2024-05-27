# Projeto final de MC613 - 2024s1

Grupo:

- ARTHUR TSUYOSHI KINA (260370)
- BEATRIZ VITÓRIA PEREIRA MOURA (232076)
- FELIPE LEME DE ARGOLLO FERRÃO (260431)
- RAFAEL MASATO HAGA COSTA (247348)

## Descrição

### Conceito do projeto

Como projeto final da disciplina de MC613, o grupo optou por implementar um jogo de ritmo
utilizando os conhecimentos adquiridos e os módulos desenvolvidos em Verilog ao longo do semestre.
Nesse contexto, o projeto será baseado em outros jogos da mesma vertente, como “Taiko no Tatsujin”,
“Guitar Hero” e “Rock Band” da categoria drums ou percussão (veja as figuras 1 e 2 abaixo).
A ideia geral do jogo é que o usuário interaja com o game por meio do reconhecimento de cores e
da repetição dos padrões exibidos no monitor, os quais são pré-determinados pelos desenvolvedores.
Desse modo, um jogador pode acumular pontos por acertos e participar de diversas rodadas competindo
por melhores pontuações, explorando novos padrões de jogabilidade, além de acompanhar o seu desempenho.

### Objetivos

O objetivo deste projeto é adaptar um jogo de ritmo em realidade aumentada dentro do módulo
FPGA, para tanto existem alguns desafios de implementação que deverão ser solucionados ao longo do
desenvolvimento. Estes são:
● Utilizar a câmera para detectar os gestos do jogador que servirão como entrada do sistema. A
captura será feita através do mapeamento de um ponto com uma cor específica que será segurado
pelo jogador, que poderá movê-lo ao longo de diferentes coordenadas da tela, a sessão da tela que
contém o ponto será útil mais a frente para indicar a cor que o jogador está selecionando no
momento;
● A câmera também servirá para dar um retorno visual para o jogador no monitor, através do
módulo VGA. A tela mostrará o vídeo capturado pela câmera, indicando as sessões da tela que o
jogador pode selecionar através das cores correspondentes;
● Apresentar na tela comandos que deverão ser seguidos pelo jogador, e que transmitam uma noção
de ritmo, central para o conceito do jogo. Os comandos serão mostrados por formas em um
padrão de cores específico que, de modo semelhante ao que é feito no jogo “Guitar Hero”, se
moverão de forma descendente ao longo de seções verticais da tela, o objetivo do jogador então
será selecionar, no momento apropriado, a cor que corresponde a cor da forma que passa por uma
sessão específica da tela neste instante;
● A implementação de um sistema de pontuação que corresponderá a quantidade de acertos do
jogador ao longo da partida.

### Especificação

Os componentes que serão utilizados do kit serão alguns já vistos durante o curso:
● A saída VGA da placa DE1-SoC para gerar um sinal de vídeo em um monitor. Esse sinal
mostrará o local e o momento em que o jogador deve mirar sua mão de acordo com certo padrão
de ritmo.
● A Câmera OV7670, que utilizaremos para detectar as cores e as coordenadas dos gestos do
jogador.
● O display de 7 segmentos, que será utilizado para mostrar a quantidade de acertos na rodada

