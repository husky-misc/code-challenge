Para rodar o projeto os comandos abaixo devem ser o suficiente

1. bundle install
2. yarn install
3. rails db:create db:migrate
4. rails s

Objetivos concluídos:

- Frag é quando um jogador mata outro player no jogo;

- Frags realizados pelo player WORLD devem ser desconsiderados;

- Permitir que uma rodada tenha múltiplos players, limitado a 20 jogadores por partida.

- Descobrir a arma preferida (a que mais matou) do vencedor;

- Ranking Global dos jogadores, computando dados de todas as partidas existentes;

- Jogadores que vencerem uma partida sem morrerem devem ganhar um "award";

Objetivos não concluídos(motivo: Só tinha tempo no sabado para terminar o projeto):

- Jogadores que matarem 5 vezes em 1 minuto devem ganhar um "award";

- Identificar a maior sequência de frags efetuadas por um jogador (streak) sem morrer, dentro da partida;

- Permitir que os jogadores sejam classificados em times, quando um jogador mata outro player do mesmo time - Friendly Fire - é computado -1 no score de frags do atirador.