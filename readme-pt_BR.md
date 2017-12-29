# Ambientum

![Readme Art](https://raw.githubusercontent.com/codecasts/ambientum/master/new-readme-art.png)

Manter um ambiente de desenvolvimento uniforme entre desenvolvimento, staging and produção geralmente não é uma tarefa fácil.
Nos últimos anos, nosso amigo Docker tem se tornado uma solução madura para resolver esse tipo de problema.

Todos nós amamos Laravel e Vue.JS, mas porquê desenvolver um código Rock Star sem um ambiente do mesmo nível?

Nunca mais ouça: "na minha máquina funcionou"!

## O que o Ambientum Faz?
Ambientum pode lhe ajudar com algumas coisas incríveis, os 3 cenários mais comuns estão listados a seguir:

- **Rodar Laravel e/ou Vue.JS em Desenvolvimento.**
- **Rodar Laravel e/ou Vue.JS em Produção (Includindo Integração Contínua).**
- **Substituir dependências locais com comandos que rodam no Docker.**

## O que eu Preciso Saber Antes de Começar?

Antes de começar com Ambientum, alguns conhecimentos são necessários:

- O básico sobre Docker e Containers.
- Estar confortável usando a linha de comando.
- Saber operar o **`docker-compose`**.


## Aviso
O **Docker Compose** que vem por padrão com o docker geralmente é antigo.
Por favor instale a versão estável mais recente disponível em https://github.com/docker/compose/releases.

## Imagens
Se você já se sente confortável com as habilidades listadas acima, você pode usar as seguintes imagens pra montar seu próprio ambiente:

|Repository                 | Images/Tags                   | Description                                          |
|---------------------------|-------------------------------|------------------------------------------------------|
| ambientum/**php**         | `7.1`, `latest`               | PHP v7.1 para linha de comando e queues              |
|                           | `7.1-nginx`, `latest-nginx`   | PHP v7.1 com Nginx webserver                         |
|                           | `7.1-apache`, `latest-apache` | PHP v7.1 com Apache webserver                        |
|                           | `7.0`,                        | PHP v7.0 para linha de comando e queues              |
|                           | `7.0-nginx`,                  | PHP v7.0 com Nginx webserver                         |
|                           | `7.0-apache`,                 | PHP v7.0 com Apache webserver                        |
| ambientum/**node**        | `8`, `latest`                 | Node.js v8.x                                         |
|                           | `7`                           | Node.js v7.x                                         |
|                           | `6`                           | Node.js v6.x                                         |
| ambientum/**mysql**       | `5.7`, `latest`               | MySQL Server v5.7 (com sql-mode='')                  |
|                           | `5.6`                         | MySQL Server v5.6                                    |
|                           | `5.5`                         | MySQL Server v5.5                                    |
| ambientum/**mariadb**     | `10.1`, `latest`              | MariaDB Server v10.1                                 |
|                           | `10.0`                        | MariaDB Server v10.0                                 |
|                           | `5.5`                         | MariaDB Server v5.5                                  |
| ambientum/**postgres**    | `9.6`, `latest`               | PostgreSQL Server v9.6                               |
|                           | `9.5`                         | PostgreSQL Server v9.5                               |
|                           | `9.4`                         | PostgreSQL Server v9.4                               |
|                           | `9.3`                         | PostgreSQL Server v9.3                               |
| ambientum/**redis**       | `4.0`, `latest`               | Redis Server v4.0                                    |
|                           | `3.2`                         | Redis Server v3.2                                    |
|                           | `3.0`                         | Redis Server v3.0                                    |
| ambientum/**beanstalkd**  | `1.10`, `latest`              | Beanstalkd Server v1.10                              |
|                           | `1.9`                         | Beanstalkd Server v1.9                               |
| ambientum/**mailcatcher** | `latest`                      | MailCatcher alternativa open source ao MailTrap.io   |

## Guia rápido de uso:

### Substituindo comandos locais:
Umas das funcionaliades do Ambientum é permitir a utilização de comandos relacionados a PHP e NODE.JS dentro de
containers.

Existem alguns aliases que precisam ser setados, os comandos abaixo lhe mostram como os ativar:

#### Para usuários do Bash e ZSH:

(Utilize essa opção caso você não saiba qual o seu terminal)

```
curl -L https://github.com/codecasts/ambientum/raw/master/commands.bash -o ~/.ambientum_rc
source ~/.ambientum_rc
```

#### Para usuários do Fish:

```
curl -L https://github.com/codecasts/ambientum/raw/master/commands.fish -o ~/.ambientum_rc
source ~/.ambientum_rc
```

#### Para usuários do Windows (via Git Bash):

Para Outros consoles do Windows (como PowerShell ou Cmder), acesse esse [link](https://github.com/julihermes/ambientum-commands-for-windows).

```
curl https://github.com/codecasts/ambientum/raw/master/commands.git-bash -o ~/.ambientum_rc
source ~/.ambientum_rc
```

Uma vez que os comandos foram declarados, podemos começar a usá-los imediatamente.

#### Importante: A primeira execução pode demorar algum tempo, desde que as imagens serão baixadas.

Tudo relacionado ao Node.JS pode ser executado utilizando-se o prefixo `n`.
Por exemplo, digamos que você precisa utilizar o gulp, que é uma dependência global:

```
n npm install -g gulp
n gulp --version
```

Você também pode usar o Yarn:

```
n yarn global add gulp
n gulp
```

Precisa do NPM apenas?

```
n npm install
```

Tudo relacionado ao PHP pode ser executao utilizando-se o prefixo `p` command.
Por exemplo, se você precisar do `composer`:

```
p composer global require minha/dependencia-global
```

Você pode inclusive somente usar o binario do php contra algum arquivo:
```
p php teste.php
```

Outro exemplo, vamos criar um Projeto Laravel:

```
p composer create laravel/laravel nome-do-meu-projeto
```

## Eu Tenho um Projeto, E gostaria de usar Docker!

Bom, esse é o objetivo princial desse projeto.

Ajuste os arquivos `docker-compose.yml` a seguir ao seu agrado, adicionando ou removendo serviços que você precisar:

#### Laravel docker-compose.yml


```yml
####
# ATENCAO:
# Troque todas as ocorrencias de "sandbox" com o nome do seu projeto
####

# sintaxe v2 do docker-compose
version: '2'

# Volumes (para que os dados nao se percam)
volumes:
  # Dados do Postgres
  # remova se voce nao for usar postgres
  sandbox-postgres-data:
    driver: local

  # Dados do MySQL
  # remova se voce nao for usar mysql
  sandbox-mysql-data:
    driver: local

  # Dados do Redis
  # remova se nao for usar redis
  sandbox-redis-data:
    driver: local

services:
  # Postgres (9.5)
  postgres:
    image: ambientum/postgres:9.6
    container_name: sandbox-postgres
    volumes:
      - sandbox-postgres-data:/var/lib/postgresql/data
    ports:
      - "5432:5432"
    environment:
      - POSTGRES_PASSWORD=sandbox
      - POSTGRES_DB=sandbox
      - POSTGRES_USER=sandbox

  # MySQL (5.7)
  mysql:
    image: ambientum/mysql:5.7
    container_name: sandbox-mysql
    volumes:
      - sandbox-mysql-data:/var/lib/mysql
    ports:
      - "3306:3306"
    environment:
      - MYSQL_ROOT_PASSWORD=sandbox
      - MYSQL_DATABASE=sandbox
      - MYSQL_USER=sandbox
      - MYSQL_PASSWORD=sandbox

  # Redis
  cache:
    image: ambientum/redis:3.2
    container_name: sandbox-redis
    command: --appendonly yes
    volumes:
      - sandbox-redis-data:/data
    ports:
      - "6379:6379"

  # PHP (com Nginx)
  # voce pode mudar de nginx para apache, basta trocar a sessao 'image'
  app:
    image: ambientum/php:7.0-nginx
    container_name: sandbox-app
    volumes:
      - .:/var/www/app
    ports:
      - "80:8080"
    links:
      - postgres
      - mysql
      - cache

  # Laravel Queues
  queue:
    image: ambientum/php:7.0
    container_name: sandbox-queue
    command: php artisan queue:listen
    volumes:
      - .:/var/www/app
    links:
      - mysql
      - cache
```

### Vue.js docker-compose.yml
Desenvolvendo um SPA com Vue.JS? Aqui está seu `docker-compose.yml`:

```yml
# ATENCAO
# Nomeie os containers de acordo com seu projeto, na sessao "container_name"

version: '2'

services:
  # Web server - Para livereload e desenvolvimento.
  # Esse container pode ser usado para rodar comandos do npm
  # ao invez de usar n npm
  # utilize: docker-compose run dev [comando]
  dev:
    image: ambientum/node:6
    container_name: sandbox-vue-dev
    command: npm run dev
    volumes:
      - .:/var/www/app
    ports:
      - 8080:8080

  # Container que faz uma previa do build usando o nginx
  # somente útil para fazer preview do build que irǻ pra produção
  production-server:
    image: nginx:stable-alpine
    container_name: sandbox-preview-server
    volumes:
      - ./dist:/usr/share/nginx/html
    ports:
      - 9090:80
```
