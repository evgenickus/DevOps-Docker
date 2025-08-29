Создать Docker Compose скрипт для развертки кластера из трех инстансов cassandra, причем каждый из них должен быть доступен из основной (локальной) сети по отдельному ip адресу.

# Задание
1. На машине А (ubuntu 24.04 lts) в локальной сети с ip 192.168.1.197 запускается скрипт docker-compose для поднятия 3 образов с ip адресами 192.168.1.200-202.
2. Затем с машины Б (ubuntu 24.04 lts) из той же локальной сети с ip 192.168.1.198 необходимо подключиться через cqlsh к каждой из машин-образов.
3. Настроить ssh для возможности подключения к 1.200 с 1.197
4. Все приведённые операции необходимо задокументировать и описать инструкцией с командами и объяснениями в Readme
5. Добавить скриншот результата в Readme.


# Решение

### Выводим информацию о версии операционных систем:
## *<span style="color:blue">cat /etc/\*release\*</span>*
#### На server-A
![alt text](./images/ver-A.png)

#### На server-B
![alt text](./images/ver-B.png)

### Выводим информацию об адресе машин в локальной сети:
## *<span style="color:blue">ip a show enp0s8</span>*
#### На server-A
![alt text](./images/ipaddr-A.png)
#### На server-B
![alt text](./images/ipaddr-B.png)

### Теперь на server-А выполним запуск файла docker-compose.yml который выполнит установку трех docker контейнеров с базой данных Cassandra, имеющих сетевые адреса: *<span style="color:blue">192.168.1.200, 192.168.1.201, 192.168.1.202</span>*
### Для контейнера с именем cassandra_01 и IP 192.168.1.200 будет создан кастомный образ с именем test-cassandra-0 в котором сразу будет настроен SSH сервер и создан пользователь
### Запускаем командой:
## <span style="color:blue">*docker-compose up -d*</span>
![alt text](./images/dc-up.png)

### Проверяем что контейнеры работают:
## *<span style="color:blue">docker ps</span>*
![alt text](./images/d-ps.png)

### Выводим информацию о сетевых адресах запущенных контейнеров:
## *<span style="color:blue">docker network inspect test_clusternet</span>*
![alt text](./images/network.png)
### Далее подключаемся с server-B к каждому контейнеру через сqlsh:
## *<span style="color:blue">cqlsh 192.168.1.200</span>*
![alt text](./images/cqlsh200.png)
## *<span style="color:blue">cqlsh 192.168.1.201</span>*
![alt text](./images/cqlsh201.png)
## *<span style="color:blue">cqlsh 192.168.1.202</span>*
![alt text](./images/cqlsh202.png)

### Все подключения выполнены успешно

### Для обеспечения сетевой доступности с контейнером имеющим IP адрес *<span style="color:blue">192.168.1.200* необходимо на server-А добавить сетевой маршрут
### Для этого запустим скрипт командой:
## *<span style="color:blue">sudo ./add_route_script.sh</span>*
### Проверяем что маршрут добавлен:
## *<span style="color:blue">ip route</span>*
![alt text](./images/iproutes.png)

### Для подключения по SSH ключу нам нужно скопировать в текущую директорию файл с публичным ключом пользователя:
## *<span style="color:blue">cp ~/.ssh/id_rsa.pub ./</span>*

### Выполняем подключение по протоколу SSH:
## *<span style="color:blue">ssh <span style="color:blue">evgeniy</span>@192.168.1.200</span>*
![alt text](./images/ssh.png)

### Подключение выполнено успешно
