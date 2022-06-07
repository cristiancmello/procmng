#!/bin/bash

ENVVAR="hello" # criar um shell variable
export ENVVAR # colocar a variavel no environment do processo

# forma abreviada
export ENVVAR="hello"

# Em Bash e Korn Shell podemos adicionar env var para somente
# processo filho, enquanto o pai fica inalterado
ENVVAR="world" ./print_envvar_child.sh &

echo "(parent) ENVVAR=$ENVVAR"

# Mostre o environ que o processo herdou de seu pai
printenv

# Outra maneira de mostrar o environ do processo
# Cada par name=value termina com NULL
cat /proc/self/environ

