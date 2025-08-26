### Выводим информацию о версии операционных систем
## *cat /etc/\*release\**
#### На виртуальной машине А: 
![alt text](./images/ver-A.png)


#### На виртуальной машине B:
![alt text](./images/ver-B.png)

### Выводим информацию о адресе машин в локальной сети
## *ip a show enp0s8*
#### На виртуальной машине А: 
![alt text](./images/ipaddr-A.png)
#### На виртуальной машине B:
![alt text](./images/ipaddr-B.png)

### Теперь на сервере А выполним запуск файла docker-compose.yml который выполнит установку трех
### docker контейнеров с базой данных Cassandra, имеющих сетевые адреса: *192.168.1.200, 192.168.1.201, 192.168.1.202*
## *docker-compose up -d*
![alt text](./images/dc-up.png)

### Проверяем что контейнеры работают
## *docker ps*
![alt text](./images/d-ps.png)

### Выводим информаци о сетевых адресах запущенных контейнеров
## *docker network inspect test_clusternet*
 ![alt text](./images/network.png)

### Далее подключаемся с сервера B к каждому контейнеру через утилиту cqlsh
## *cqlsh 192.168.1.200*
![alt text](./images/cqlsh200.png)
## *cqlsh 192.168.1.201*
![alt text](./images/cqlsh201.png)
## *cqlsh 192.168.1.202*
![alt text](./images/cqlsh202.png)

### Теперь необходимо настроить SSH сервер внутри контейнера с IP адресом *192.168.1.200*
### Для это вначале выполним обновление и установку необходимых пакетов
## *docker exec -it cassandra_01 apt update*
## *docker exec -it cassandra_01 apt install -y ssh*
### Установим пароль для пользователя root
## *docker exec -it cassandra_01 passwd*
![alt text](./images/passwd.png)

### Далее подключимся к контейнеру и разрешим соединение по  SSH для пользователя root
## *docker exec -it cassandra_01 bash*
## *echo PermitRootLogin yes >> /etc/ssh/sshd_config*
![alt text](./images/sshd_config.png)

### Запускаем службу SSH внутри контейнера
## *docker exec -it cassandra_01 /etc/init.d/ssh start*
![alt text](./images/ssh_start.png)


### Для обеспечения сетевой доступности с контейнером имеющим IP адрес *192.168.1.200* необходимо добавить
### сетевой маршрут интерфейсу *br-28de1fe84ef6* 
![alt text](./images/ipa.png)
### Запускаем команду:
## *sudo ip route add 192.168.1.200/32 dev br-28de1fe84ef6*
### Проверяем что маршрут добавлен
## *ip route*
![alt text](./images/iproutes.png) <!-- ip route -->


## *ssh root@192.168.1.200*
![alt text](./images/ssh.png)

