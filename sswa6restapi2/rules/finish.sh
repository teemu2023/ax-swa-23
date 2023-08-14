#!/bin/bash

#
# Скрипт сбора фактов активности студента
#

# функция проверяет наличие заданного шаблона в логе ингреса
#
# в переменной $1 передаем содержимое лога
# в переменной $2 передаем шаблон
function lookupIngressLogs {
    while read line; do
        if [[ $line =~ $2 ]] ;then
            echo "true"
            return
        fi
    done <<< "$1"

    echo "false"
    return
}

# проверим, запускал ли пользователь prepare.sh ожидаем увидеть работающий ingress
controllerStatus=$(kubectl get po -l app.kubernetes.io/component=controller -n ingress-nginx -o json 2>&1)
#controllerStatus=$(echo "fail" 1 2>&1)

# проверим, что controllerStatus это валидный json
if [[ $(echo $controllerStatus | jq 2>&1) =~ "parse error:" ]]; then
    controllerStatus=$(jq --null-input --arg error "$controllerStatus" '$ARGS.named')
fi

# получаем логи из ингреса
logs=$(kubectl logs -n ingress-nginx -l app.kubernetes.io/name=ingress-nginx 2>&1 | tail -n 100)

# шаблоны ожидаемых записей в логе ингреса


# собираем факты в результирующий json
