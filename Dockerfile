FROM ubuntu:16.04

RUN apt-get -y update
RUN apt-get -y install openssh-server git sharutils


#RUN mkdir /repos \ --Directory for git repositories
#  && mkdir /var/run/sshd \ -- needed by ssh
#  && adduser --gecos "" --disabled-password --shell /usr/bin/git-shell git \ -- Create user and set git-shell
#  && echo git:`dd if=/dev/urandom bs=1 count=30 | uuencode -m - | head -2 | tail -1` | chpasswd \ -- Acivate user by setting a password
#  && mkdir /home/git/.ssh \ -- Directory for authorized_keys
#  && touch /home/git/.hushlogin \ -- Disable welcome message
#  && sed -i "s/#PasswordAuthentication yes/PasswordAuthentication no/" /etc/ssh/sshd_config -- Disable password Login

RUN mkdir /repos \
  && mkdir /var/run/sshd \
  && adduser --gecos "" --disabled-password --shell /usr/bin/git-shell git \
  && echo git:`dd if=/dev/urandom bs=1 count=30 | uuencode -m - | head -2 | tail -1` | chpasswd \
  && mkdir /home/git/.ssh \
  && touch /home/git/.hushlogin \
  && sed -i "s/#PasswordAuthentication yes/PasswordAuthentication no/" /etc/ssh/sshd_config

WORKDIR /home/git

COPY git-shell-commands /home/git/git-shell-commands
COPY start.sh start.sh

EXPOSE 22
CMD ["sh", "start.sh"]