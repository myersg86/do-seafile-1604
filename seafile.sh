#!/bin/bash
set -ex

adduser greg
usermod -aG sudo greg
# vi /etc/ssh/sshd_config
apt update
apt upgrade -y

su sammy
mkdir ~/.ssh
chmod 700 ~/.ssh
nano ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
