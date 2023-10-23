## Развёртывание приложения
На этом шаге необходимо добавить в созданный проект конфигурацию для нашего приложения.

Изучите манифест:  
`application.yaml`{{open}}  

Примените его, выполнив команду:  
`kubectl apply -n argocd -f application.yaml`{{execute}}

После этого argocd должен из конфигурации в gogs развернуть в кластере наше приложение с указанным количеством реплик. Проверить их наличие можно командой:

`kubectl get po -n app`{{execute}}

После успешного развёртывания результат будет следующий:
```shell
~# kubectl get po -n app
NAME                        READY   STATUS    RESTARTS   AGE
nginx-app-d68f4f689-smmbh   1/1     Running   0          15m
nginx-app-d68f4f689-c9l77   1/1     Running   0          15m
```
## Внесение изменений

Перейдите в веб-интерфейс gogs и в режиме редактирования измените количество реплик нашего приложения, добавьте ещё одну:

![gogs_add_user](./assets/edit_app_replicas.png) 

Сохраните изменения, нажав «Фиксация изменений» под редактируемым файлом и дождитесь, когда argocd применит новую конфигурацию на кластере. У argocd таймаут 3 минуты между отслеживанием состояния + время на развёртывание.

Логи контроллера argocd можно посмотреть командой:
`kubectl logs -n argocd argocd-application-controller-0 --tail 20`{{execute}}

После успешного применения Вы увидите, что кол-во реплик увеличено до трёх:
```shell
~# kubectl get po -n app
NAME                        READY   STATUS    RESTARTS   AGE
nginx-app-d68f4f689-v4qnj   1/1     Running   0          5m39s
nginx-app-d68f4f689-sztz8   1/1     Running   0          5m39s
nginx-app-d68f4f689-n8hwk   1/1     Running   0          44s