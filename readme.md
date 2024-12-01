# Jenkins Docker Container

Этот проект предоставляет Dockerfile для сборки образа jenkins на базе ubuntu 20:04.

## Сборка Docker-образа

1. Клонируйте этот репозиторий или создайте директорию с `Dockerfile`.

2. В `Dockerfile` можно изменить ветку Jenkins. По умолчанию используется версия `master`. Чтобы использовать другую ветку или версию, отредактируйте строку:

   ```
   ARG JENKINS_TAG=master
   ```
3. Соберите Docker-образ с помощью команды:

    ```bash
    docker build -t jenkins-container .
    ```


## Запуск контейнера

После того как образ будет создан, вы можете запустить контейнер с помощью команды:

```bash
docker run -d -p 8080:8080 -v /var/jenkins_home:/root/.jenkins --name jenkins-container jenkins-container
```

Для получения пароля администратора выполнить:

```bash
docker exec jenkins-container cat /root/.jenkins/secrets/initialAdminPassword
```
