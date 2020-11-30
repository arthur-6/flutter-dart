# webapiflutter
Aplicativo demonstrativo do uso de uma web API.

Utilizei da API CatFacts (https://alexwohlbruck.github.io/cat-facts/) p/ uso.

### funcionalidade ###
O aplicativo mostra uma curiosidade sobre gatos aleatória e a cada vez que o botão é apertado, uma nova curiosidade é trazida para o display principal.

### documentação ###
- **catfacts.models.dart** - Definição do modelo CatFacts
- **catfacts.repositories.dart** - Repositório de funções de declaração de leitura do tipo CatFacts
  - **getCatFacts()** - Função dentro da classe CatRepository do tipo get(), ou seja, funciona analogamente a uma requisição GET de http: "pega" os dados da API
- **catfacts.controllers.dart** - Arquivo para definir métodos de tratamento dos dados nas quais serão chamados pela view
  - **getCatFacts()** - Função que chama o getCatFacts() dentro de catfacts.repositories.dart para poder retornar um fato sobre gatos
- **catfacts.views.dart** - Telas do aplicativo
