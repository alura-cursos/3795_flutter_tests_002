![Mobile-Flutter: Flutter com testes de integração para apps consistentes](capa.png)

# Flutter: Comunicação Web API com Dio

O projeto Listin é um gerenciador de listas de compras para que você possa planejar sua feira e, no supermercado, possa anotar quanto já gastou para evitar surpresas na hora do caixa!

### Tópicos abordados no curso:

- Testes de Integração;
- Configuração para rodar os testes em várias plataformas;
- Instrumentação para ferramentas como Test Lab;

Este curso é ideal para pessoas desenvolvedoras que já possuam uma boa base em testes unitários e de widget com FLutter, e desejem progredir com seus conhecimentos de testes para tornar suas aplicações ainda mais seguras e confiáveis utilizando testes de integração.

## 📑 Requisitos

- Conhecimentos básicos de Flutter e Dart;
- VS Code com plugins do Flutter e Dart instalados (recomendado para acompanhar este curso);
- É importante ter o Flutter na versão 3.19.6.
- Será essencial ter a CLI do Firebase instalado para configurar um projeto Firebase no projeto Flutter;

## ✨ Funcionalidades do projeto

- Arquivos de testes separados por arquivo testado;
- Função `test` para execução de testes de unidade;
- Função `expect` para verificação dos valores esperados;
- Função `group` para agrupamento, pré-configurações e legibilidade dos testes;
- Uso do `mockito` para simular dependências externas;
- Função `setUp` para pré-configurações seguras;
- Função `testWidget` para testes de widget;

![GIF da aplicação em execução](gif.gif)
O mouse está sendo mostrado parado na execução para evidenciar que os "inputs" estão sendo feitos pelo teste de integração, e não por uma interação usual com a aplicação.

## 🛠️ Abrir e rodar o projeto

Aqui vem um passo a passo para abrir e rodar o projeto.

- **Open an Existing Project** (ou alguma opção similar)
- Procure o local onde o projeto está e o selecione (Caso o projeto seja baixado via zip, é necessário extraí-lo antes de procurá-lo)
- Por fim clique em OK
- Configure o Firebase no projeto;
- Depois basta rodar o comando `flutter run` na pasta do projeto