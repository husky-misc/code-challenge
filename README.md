## Hunger Games ##
## O que foi realizado ##
No sistema existe dois models: game onde o upload é realizado e o match onde os dados das partidas de cada game são armazenadas.

## Como é realizado ##
Depois que o upload é realizado o service StoreMatchService é chamado e as partidas dentro do arquivo são individualizadas, os dados são extraídos, tratados, e armazenados com um JSON no banco onde ficam prontos para serem consultados e exibidos.

## Visualização da informação ##
Foi criado uma view para o upload do arquivo de log e a visualização do Ranking global

## Objetivos alcançados ##
* Montar o ranking de cada partida, com a quantidade de frags* e a quantidade de mortes de cada jogador; (Ranking montando mas view não foi criada)
* Permitir que o seu código receba logs de múltiplas rodadas em um único arquivo.
* Descobrir a arma preferida (a que mais matou) do vencedor
* Identificar a maior sequência de frags efetuadas por um jogador (streak) sem morrer, dentro da partida;(Objetivo alcançado mas view não foi criada)
Jogadores que vencerem uma partida sem morrerem devem ganhar um "award";(Objetivo alcançado mas view não foi criada)
Jogadores que matarem 5 vezes em 1 minuto devem ganhar um "award";(Objetivo alcançado mas view não foi criada)
* Ranking Global dos jogadores, computando dados de todas as partidas existentes;

## Sistema ##
ruby - 3.0.0
rails - 6.1.2
Postgresql

## Execução ##
rails db:create
rails db:migrate
rails s
