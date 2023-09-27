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

### Сертификат доменного имени
Добавте в конфигурационный файл Terraform ресурс сертификата
```
resource "yandex_cm_certificate" "le-certificate" {
  name = "<имя_сертификата>"
  domains = ["<домен>"]
  managed {
    challenge_type = "DNS_CNAME"
  }
}

resource "yandex_dns_recordset" "validation-record" {
  zone_id = "<идентификатор_зоны>"
  name = yandex_cm_certificate.le-certificate.challenges[0].dns_name
  type = yandex_cm_certificate.le-certificate.challenges[0].dns_type
  data = [yandex_cm_certificate.le-certificate.challenges[0].dns_value]
  ttl = <время_жизни_записи_секунд>
}

data "yandex_cm_certificate" "example" {
  depends_on = [yandex_dns_recordset.example]
  certificate_id = yandex_cm_certificate.example.id
  wait_validation = true
}

# Use data.yandex_cm_certificate.example.id to get validated certificate

output "cert-id" {
  description = "Certificate ID"
  value  = data.yandex_cm_certificate.example.id
}
```
Создать ресурс
```
terraform validate
terraform plan
terraform apply
```


Проверить появление сертификата и его настройки
```
yc certificate-manager certificate get <имя_сертификата>
```

```
terraform init -backend-config=backend.tfvars
terraform plan
terraform apply
```



## Установка Ingress-контроллера Application Load Balancer
1) Назначте сервисному аккаунту роли:
- alb.editor — для создания необходимых ресурсов
- vpc.publicAdmin — для управления внешней связностью
- certificate-manager.certificates.downloader — для работы с сертификатами, зарегистрированными в сервисе Yandex Certificate Manager
- compute.viewer — для использования узлов кластера Managed Service for Kubernetes в целевых группах балансировщика

2) Создайте статический ключ доступа для сервисного аккаунта в формате JSON
```
yc iam key create \
  --service-account-name <имя_сервисного_аккаунта_для_Ingress-контроллера> \
  --format=json > sa-key.json
```
3) Для установки Helm-чарта с Ingress-контроллером выполните команды:
```
export HELM_EXPERIMENTAL_OCI=1 && \
cat sa-key.json | helm registry login cr.yandex --username 'json_key' --password-stdin && \
helm pull oci://cr.yandex/yc-marketplace/yandex-cloud/yc-alb-ingress/yc-alb-ingress-controller-chart \
  --version v0.1.22 \
  --untar && \
helm install \
  --namespace <пространство_имен> \
  --create-namespace \
  --set folderId=<идентификатор_каталога> \
  --set clusterId=<идентификатор_кластера> \
  --set-file saKeySecretKey=sa-key.json \
  yc-alb-ingress-controller ./yc-alb-ingress-controller-chart/
```












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
