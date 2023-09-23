## Описание проекта
Репозиторий содержит код, который позволяет развернуть в облаке Yandex.Cloude учебный проект "Пельменная". 
Интернет-магазин "Пельменная" состоит из бэкенда и фронтенда.
- бэкенд: бинарный файл Go в Docker-образе
- фронтенд: HTML-страница раздаётся с Nginx

## Структура проекта
- директория "terraform" содержит код, позволяющий развернуть кластер Kubernetes в облаке Yandex.Cloude;
- директория "backend" содержит: 
  - исходный код бэкэнда на языке Go;
  - файл .gitlab-ci.yml содержит описание конвейера GitLab CI/CD для бэкэнда;
  - файл Dockerfile описывает процесс многоэтапной сборки бэкэнда в Docker образ;
- директория "frontend" содержит: 
  - исходный код фронтэнда на языке HTML и JS;
  - файл .gitlab-ci.yml содержит описание конвейера GitLab CI/CD для фронтэнда;
  - файл Dockerfile описывает процесс многоэтапной сборки фронтэнда в Docker образ.

## Создание кластера Kubernetes в облаке Yandex.Cloude
### Предварительная настройка в Yandex.Cloude
1) Создайте каталог, в котором будут храниться ресурсы кластера
2) Создайте сервисный аккаунт с ролью editor на каталог, в котором создаётся кластер. От имени этого сервисного аккаунта будут создаваться ресурсы, необходимые кластеру Managed Service for Kubernetes.
3) Создайте статический ключ доступа.

### Доменное имя
Зарегистрируйте домен для интернет-магазина, субдомен для сервиса "monitoring" и субдомен для сервиса "grafana". 
Для этого укажите адреса серверов имен Yandex Cloud в NS-записях вашего регистратора:
- ns1.yandexcloud.net
- ns2.yandexcloud.net

### Доступ к Yandex.Cloude 
Создайте временный iam-token для доступа к Yandex.Cloude
```bash
yc iam create-token
```
Присвойте значение токена переменной iam_token в файле terraform.tfvars.

# Momo Store aka Пельменная №2

<img width="900" alt="image" src="https://user-images.githubusercontent.com/9394918/167876466-2c530828-d658-4efe-9064-825626cc6db5.png">

## Frontend

```bash
npm install
NODE_ENV=production VUE_APP_API_URL=http://localhost:8081 npm run serve
```

## Backend

```bash
go run ./cmd/api
go test -v ./... 
```
