#!/bin/sh

cd /home/git
chown -R git:git .ssh
chmod 700 .ssh
chmod -R 600 .ssh/*

# Checking permissions and fixing SGID bit in repos folder
cd /repos
chown -R git:git .
chmod -R ug+rwX .
find . -type d -exec chmod g+s '{}' +

# -D flag avoids executing sshd as a daemon
/usr/sbin/sshd -D