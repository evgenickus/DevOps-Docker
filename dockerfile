FROM cassandra:latest

RUN apt update && apt install -y ssh && mkdir -p /var/run/sshd
RUN useradd -m evgeniy && mkdir /home/evgeniy/.ssh && chsh -s /bin/bash evgeniy && echo 'PubkeyAuthentication yes' >> /etc/ssh/sshd_config

COPY id_rsa.pub /home/evgeniy/.ssh/authorized_keys

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]