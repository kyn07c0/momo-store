## Описание проекта
Репозиторий содержит код, который позволяет развернуть в облаке Yandex.Cloude учебный проект "Пельменная". 
Интернет-магазин "Пельменная" состоит из бэкенда и фронтенда.

## Структура проекта
- директория "terraform" содержит код, позволяющий развернуть кластер Kubernetes и другие ресурсы в облаке Yandex.Cloude;
- директория "backend" содержит исходный код бэкэнда на языке Go и Dockerfile, описывает процесс многоэтапной сборки бэкэнда в Docker образ;
- директория "frontend" содержит исходный код фронтэнда на языке HTML и JS, а так же Dockerfile описывает процесс многоэтапной сборки фронтэнда в Docker образ;
- директория "kubernetes" содержит kubernetes-манифесты для публикации приложения (frontend и backend);
- директоря "helm" содержит helm-чарты для запуска приложений внутри кластера Kubernetes.

## Создание инфраструктуры в облаке Yandex.Cloude
1) Создать сервисный аккаунт с ролью editor
2) Получить статический ключ доступа (access_key и secret_key)
3) Создать бакет с ограниченным доступом для хранения состояния terraform.
4) Присвоить значения переменным в файле backend.tf
```
endpoint = "storage.yandexcloud.net"
bucket = "<имя_файла_состояния>"
region = "ru-central1"
key = "<путь_к_файлу_состояния_в_бакете>/<имя_файла_состояния>.tfstate"
access_key = "<идентификатор_ключа>"
secret_key = "секретный_ключ" 
skip_region_validation = true
skip_credentials_validation = true
```
5) Присвоить значения переменным в файле terraform.tfvars
```
cloud_id = "<идентификатор_облака>"
folder_id = "<идентификатор_каталога>"
token = "<IAM-_или_OAuth-токен>"
zone_name = "<название зоны>"
domain = "<домен_приложения>"
```
6) Последовательно выполнить команды
```
terraform init
terraform plan
terraform apply
```

## Настройка кластера Kubernetes
1) Создайте статический файл конфигурации для доступа к кластеру Kubernetes
2) Установите Ingress-контроллер NGINX
```
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx 
helm repo update
helm install ingress-nginx ingress-nginx/ingress-nginx
```
3) Установите менеджер сертификатов
```
kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v1.13.1/cert-manager.yaml
```
4) Убедитесь, что в пространстве имен cert-manager создано три пода с готовностью 1/1 и статусом Running:
```
kubectl get pods -n cert-manager --watch
```
5) Узнайте внешний ip-адрес ingress-контроллера(EXTERNAL-IP)
```
kubectl get svc
```
В сервисе Cloud DNS выберите зону соответствующую вашему домену и установите значение записи типа А равное внешнему ip-адресу ingress-контроллера.


## Доменное имя
Зарегистрируйте домен для интернет-магазина.
Для этого укажите адреса серверов имен Yandex Cloud в NS-записях вашего регистратора:
- ns1.yandexcloud.net
- ns2.yandexcloud.net





