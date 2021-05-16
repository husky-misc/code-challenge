# PROBLEMA

Dado o seguinte log de um jogo de tiro em primeira pessoa:

```
23/04/2013 15:34:22 - New match 11348965 has started
23/04/2013 15:36:04 - Roman killed Nick using M16
23/04/2013 15:36:33 - <WORLD> killed Nick by DROWN
23/04/2013 15:39:22 - Match 11348965 has ended

23/04/2013 16:14:22 - New match 11348966 has started
23/04/2013 16:26:04 - Roman killed Marcus using M16
23/04/2013 16:36:33 - <WORLD> killed Marcus by DROWN
23/04/2013 16:49:22 - Match 11348966 has ended
```

# Resultado esperado

- Montar o ranking de cada partida, com a quantidade de _frags_\* e a quantidade de mortes de cada jogador;
- Permitir que o seu código receba logs de múltiplas rodadas em um único arquivo.

# Observações

- Frag é quando um jogador mata outro player no jogo;
- Frags realizados pelo player WORLD devem ser desconsiderados;
- Permitir que uma rodada tenha múltiplos players, limitado a 20 jogadores por partida.

# Bônus

Faça caso se identifique com o problema ou se achar que há algo interessante a ser mostrado na solução:

- Descobrir a arma preferida (a que mais matou) do vencedor;
- Identificar a maior sequência de _frags_ efetuadas por um jogador (streak) sem morrer, dentro da partida;
- Jogadores que vencerem uma partida sem morrerem devem ganhar um "award";
- Jogadores que matarem 5 vezes em 1 minuto devem ganhar um "award";
- Ranking Global dos jogadores, computando dados de todas as partidas existentes;
- Permitir que os jogadores sejam classificados em times, quando um jogador mata outro player do mesmo time - Friendly Fire - é computado `-1` no score de frags do atirador.

# Solução

- Seja criativo;
- Explore ao máximo a orientação a objetos e engenharia de software (SOLID; UseCases; Services; Interactors, etc)
- Crie testes unitários e tente usar TDD;
- Faça commits atômicos e progressivos;
- Utilize Ruby on Rails para fazer o upload do arquivo, persistir os dados das partidas e criar e as views necessárias para exibir o ranking, estatisticas dos jogadores e os dados das partidas.

Utilize o arquivo de read.me para adicionar algum comentário/observação que achar importante.

# Como instalar?

(É necessário ter instalado ruby, rails e node em sua máquina!)

- Clone o projeto
- Acesse o diretório principal do projeto no terminal
- Rode os comandos (Usuário padrão -> email: "gideon.de.fernandes@gmail.com", password: "123456789"):

```
bundle install
rails db:create
rails db:migrate
rails db:seed
rails s
```

- Com a API rails rodando, em outra aba do terminal, acesse o diretório /client e rode os comandos

```
npm install ou yarn
npm run start ou yarn start
```

# Observações

- Preferi optar pela interface construída com React, pois tenho mais facilidade em entregar qualidade com essa ferramenta.
- Não foi possível entregar com mais agilidade devido aos compromisso que assumi (pouco tempo disponivel), mesmo assim dei o meu melhor considerando as variaveis de tempo.
- Entendo algumas possíveis melhorias como implementação do Jbuilder para formatação do JSON e restrição de dados desnecessários e alguns detalhes como a formatação de datas, uma melhor implementação para um esquema de modo team, etc... Posso implementar em uma próxima versão...
- Muito obrigado pela oportunidade de participar xD!
