# Desafio Mobile2You - TodoMovies

Este desafio consiste na criação de uma réplica da tela de detalhe dos filmes do aplicativo [TodoMovies](https://apps.apple.com/br/app/todomovies-4/id792499896) utilizando Swift.

<img alt="Captura da tela de detalhe dos filmes. Na imagem, temos uma foto em escala de cinza do rosto do ator Johnny Depp, e os detalhes do filme O melhor de Johnny Depp" src="https://is4-ssl.mzstatic.com/image/thumb/Purple114/v4/97/0e/e2/970ee217-13cf-1674-b016-461aca657663/pr_source.png/460x0w.png" height="500">

## 📝 Especificação

Para realizar este projeto, recebi instruções sobre os requisitos e também dicas que 

### ☑️ Requisitos

1. Usar algum design pattern: MVP, MVVM, MVVM-C, VIPER
2. As informações do filme devem vir do endpoint [getMovieDetails](https://developers.themoviedb.org/3/movies/get-movie-details)
3. Usar o `vote_count` que retorna da API para apresentar o número de likes
4. Substituir o "3 of 10 watched" por "`<popularity>` views", utilizando o valor retornado da API e mantendo algum ícone ao lado
5. O ícone de like(coração) deve mudar quando clicado, alternando entre preenchido e vazop.
6. Deve haver uma lista de filmes abaixo dos detalhes
7. O app deve ser desenvolvido utilizando a linguagemm Swift
8. O projeto deve ser disponibilizado em um repositório aberto no GitHub. Envie a URL assim que possível

### 💡 Dicas 

1. Você pode usar o Alamofire para facilitar a sua vcida (é apenas uma dica, não é obrigatório)
2. A lista de filmes abaixo do detalhe do filme pode ser o retorno da [getSimilarMovies](https://developers.themoviedb.org/3/movies/get-similar-movies)
3. Gostamos de Rx
4. Testes são sempre bem-vindos
5. Vamos olhar tudo, inclusive commits, branches, organização de pastas, etc.
6. Um código limpo e organizado pode ser mais importante do que o app todo pronto.
7. Vamos ler seu README, caso você queira deixar alguma mensagem para nós

## 📱 O projeto

Abaixo, temos o resultado final da interface da aplicação:

<img alt="Captura de tela da aplicação contida neste projeto. No topo, a capa do filme 'O Jogo da Imitação'. Logo em seguida, seu título. Abaixo do título temos um ícone de coração com o contador de likes, indicando 13 mil e 400 likes, e, ao lado, um ícone de fogo e o indicador de popularidade, indicando 0. Abaixo, uma lista de filmes relacionados." src="https://user-images.githubusercontent.com/23380987/115766012-4da66000-a35c-11eb-87ba-2397d4a80299.png" height="500">

Todos os requisitos foram atendidos na implementação deste projeto. O design pattern escolhido foi o MVP, os dados do filme e a lista de filmes recomendados são obtidos nos <i>endpoints</i> da [API](https://developers.themoviedb.org/3).

Para comunicação com a API, escolhi utilizar a biblioteca Alamofire, e implementei serviços para cada entidade(Filme e Gênero). Utilizei RxSwift nos serviços, com cada método retornando uma  `Observable` com o tipo do seu retorno. Cada serviço foi construído como um Singleton, sem precisar criar uma instância para utilizá-lo.

### ⬇️ Como baixar e executar

Primeiramente, é necessário clonar o repositório. Certifique-se de quê você tem o [Git](https://git-scm.com/downloads) instalado na sua máquina. Para obter o código-fonte, você pode utilizar o comando abaixo:

```bash
$ git clone https://github.com/reisdev/desafio-mobile2you
```

Feito isso, você deve abrir o projeto utilizando o Xcode.

Para conseguir construir e executar a aplicação é necessário configurar uma variável de ambiente no Xcode. Na parte superior, ao lado do nome do dispositivo simulador, clique em Mobile2You >  Edit Scheme, conforme o exemplo abaixo:

<img alt="Captura de tela do botão de Selecção de Esquema do XCode" src="https://user-images.githubusercontent.com/23380987/115759179-d15c4e80-a354-11eb-8817-db77e5b83631.png" width="300">


<img alt="Captura de tela do botão de edição de Esquema do XCode" src="https://user-images.githubusercontent.com/23380987/115759106-be497e80-a354-11eb-84df-41032abdad36.png" width="300">


Feito isso, uma janela irá se abrir. Certifique-se que, na lateral esquerda, a opção "Build" está selecionada. Na parte de  "Environment Variables", clique no botão "+" e, no campo de nome, coloque "API_KEY", e, no campo de valor, insira a sua chave da API TheMovieDB. Para obter sua chave, [clique aqui](https://developers.themoviedb.org/3/getting-started/introduction).

![Captura da tela de edição de Scheme do XCode](https://user-images.githubusercontent.com/23380987/115758730-4ed38f00-a354-11eb-917e-3f3fe0f038b2.png)

Agora que a chave está configurada, basta executar a aplicação clicando no botão de Run:

<img alt="Captura de tela do botão do botão de Run do XCode" src="https://user-images.githubusercontent.com/23380987/115758634-306d9380-a354-11eb-9969-3896dd07bb40.png" width="200">

E então a aplicação será executada na sua máquina.

### 🧾 Considerações

Desenvolver esse projeto foi muito interessante, pois pequenos detalhes, como a exibição dos gêneros dos filmes e o tratamento de exceções dos serviços, me fizeram pensar em soluções simples que me deixaram muito satisfeito. Me esforcei para cobrir o máximo possível de dicas. 

Sobre a especificação, vi apenas um problema: O requisito de número 4, o texto `<popularity> views` não me pareceu o mais adequado, talvez `<popularity> view rate` fizesse mais sentido.

Por fim, agradeço a oportunidade de participar deste processo e espero que gostem do resultado! Quaisquer dúvidas, estou à disposição!
