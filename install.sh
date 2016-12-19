#!/usr/bin/env bash

# Definindo Diretorio
HOME=$(cd $(dirname $0); pwd)
cd $HOME

UpdateSystem () {
  sudo apt-get update && sudo apt-get upgrade && sudo apt-get dist-upgrade -y
}

Install () {
  sudo apt-get install $1 -y --force-yes
  sudo apt-get autoremove
}

menu(){
  clear
  screenfetch
  echo "########### MENU ###########"
  echo "# 1 - Atualizar e Instalar #"
  echo "# 0 - Sair                 #"
  echo "############################"
  echo -n "Digite o número da opção: "
  read OPC
}

iProgramas(){
  clear
  echo "##########################"
  echo "#  1) Atualizar Sistema  #"
  echo "#  2) Instalar           #"
  echo "#  0) Voltar             #"
  echo "##########################"
  echo -n "Digite o número da opção: "
  read VAR

  if [ "$VAR" = 1 ]; then
    clear
    UpdateSystem
    read -n1 -r -p 'Pressione uma tecla para voltar '
    iProgramas
  elif [ "$VAR" = 2 ]; then
    clear
    Install numlockx vlc gimp unity-tweak-tool gdebi deborphan
    read -n1 -r -p 'Pressione uma tecla para voltar '
    iProgramas
  elif [ "$VAR" = 0 ]; then
    menu
  else
    iProgramas
    sleep 2
  fi
}

OPC=0
while [ $OPC -ne 3 ];do
  sf=$(dpkg --get-selections | grep screenfetch)
  if [ -n "$sf" ] ;
  then
    clear
    menu
  else
    sudo apt-get install -y screenfetch xtitle
    menu
  fi

  # Utilizando Case para selecionar a opcao desejada
  case $OPC in
    1) iProgramas;;
    0) break;;
    *) echo "Opção Inválida";;
  esac
done
