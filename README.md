# Momo Store aka Пельменная №2

<img width="900" alt="image" src="https://user-images.githubusercontent.com/9394918/167876466-2c530828-d658-4efe-9064-825626cc6db5.png">

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

## Создание инфраструктуры в облаке Yandex.Cloude
Процесс создание инфраструктуры состоит из двух этапов:
- Создание в s3 хранилище двух бакетов для хранения состояния terraform и ресурсов приложения
- Создание кластера Kubernetes

### Создание бакета
1) Перейти в директорию terraform/s3
2) Присвоить значения переменным в файле terraform.tfvars
```
token = "<IAM-_или_OAuth-токен>"
zone = "название <зоны>"
cloud_id = "<идентификатор_облака>"
folder_id = "<идентификатор_каталога>"
service_account_name = "<имя_сервисного_аккаунта>"
bucket = "<имя_бакета>"
```
3) Последовательно выполнить команды
```
terraform init
terraform plan
terraform apply
```
4) Выполнить команду для получения значений и service_account_id, access_key и secret_key (потребуются для доступа к s3 хранилищу)
```
terraform output -json
```

### Создание кластера Kubernetes
1) Перейдите в директорию terraform/kubernetes
2) Присвоить значения переменным в файле terraform.tfvars
```
token = "<IAM-_или_OAuth-токен>"
service_account_id = "<идентификатор_сервисного_аккаунта>"
cloud_id = "<идентификатор_облака>"
folder_id = "<идентификатор_каталога>"

endpoint = "storage.yandexcloud.net"
bucket = "<имя_бакета>"
region = "ru-central1"
key = "<путь_к_файлу_состояния_в_бакете>/<имя_файла_состояния>.tfstate"
access_key = "<идентификатор_ключа>"
secret_key = "<секретный_ключ>"
skip_region_validation      = true
skip_credentials_validation = true
```
3) Последовательно выполнить команды
```
terraform init
terraform plan
terraform apply
```

## Настройка кластера Kubernetes
1) Создайте статический файл конфигурации для доступа к кластеру Kubernetes
2) В сервисе Yandex Certificate Manager добавьте сведения о сертификате
3) Установите Ingress-контроллер NGINX
```
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx 
helm repo update
helm install ingress-nginx ingress-nginx/ingress-nginx
```
4) Установите менеджер сертификатов
```
kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v1.13.1/cert-manager.yaml
```
5) Убедитесь, что в пространстве имен cert-manager создано три пода с готовностью 1/1 и статусом Running:
```
kubectl get pods -n cert-manager --watch
```
6) Узнайте внешний ip-адрес ingress-контроллера(EXTERNAL-IP)
```
kubectl get svc
```
В сервисе Cloud DNS выберите зону соответствующую вашему домену и установите значение записи типа А равное внешнему ip-адресу ingress-контроллера.

### Доменное имя
Зарегистрируйте домен для интернет-магазина.
Для этого укажите адреса серверов имен Yandex Cloud в NS-записях вашего регистратора:
- ns1.yandexcloud.net
- ns2.yandexcloud.net






