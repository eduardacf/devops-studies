date > /etc/vagrant_provisioned_at

echo "---- Iniciando instalacao da máquina virtual com vagrant e Ansible(Tema09) ---"

sudo apt update
sudo apt install software-properties-common
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt install -y ansible

echo "---- Finalizando configuração do sistema ---"

