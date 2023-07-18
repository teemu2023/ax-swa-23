Как мы знаем, контроллер **Deployments** делает все, чтобы реальное состояние совпадало с  желаемым. И в случае изменения желаемого состояния он производит соответствующие действия. Т.е. если мы с вами изменим наш объект **Deployments**-а, это приведет к изменениям в реальном мире. 

Например, одна из задач контроллера **Deployments** - это поддерживать требуемое количество реплик приложения. Если мы поменяем количество реплик в объекте **Deployments**, то контроллер поднимет новые **Pods** или потушет работающие, так, чтобы количество **Pods** в общем счете соответствовало желаемому состоянию.

Давайте поменяем количество реплик в манифесте с 2 до 3:

<pre class="file" data-filename="./deployment.yaml" data-target="insert" data-marker="  replicas: 2">
  replicas: 3</pre>

И применим его.

`kubectl apply -f deployment.yaml`{{execute T1}}

Во второй вкладке можем наблюдать за тем, как создаcтся еще одна *пода*.

## Масштабирование деплоймента с помощью kubectl scale 

Также мы можем масштабировать **Deployments** с помощью *императивной* команды **kubectl scale**.

Например, `kubectl scale deploy/hello-deployment --replicas=2`{{execute T1}}

Во второй вкладке можем наблюдать за тем, как сначала удаляется *пода*:

```
NAME                               READY   STATUS        RESTARTS   AGE
hello-deployment-d67cff5cc-f96r6   1/1     Terminating   0          16s
hello-deployment-d67cff5cc-hrfh8   1/1     Running       0          95s
hello-deployment-d67cff5cc-hsf6g   1/1     Running       0          95s
```

А после команды:

`kubectl scale deploy/hello-deployment --replicas=3`{{execute T1}}

создается еще один *под*:
```
NAME                               READY   STATUS    RESTARTS   AGE
hello-deployment-d67cff5cc-8zbpd   1/1     Running   0          4s
hello-deployment-d67cff5cc-hrfh8   1/1     Running   0          2m55s
hello-deployment-d67cff5cc-hsf6g   1/1     Running   0          2m55s
```


## Удалим один из подов деплоймента

Одна из задач контроллера **Deployments** - это поддерживать требуемое количество реплик. Если что-то случится с одним из **Pods**, управляемых **Deployments**, то контроллер создаст новый **Pod** по шаблону на замену упавшему.

Давайте удалим один **Pod**, и посмотрим, что произойдет. 

Чтобы получить список всех под деплоймента, давайте воспользуемся параметром `-l` в команде **kubectl get**. Этот параметр позволяет фильтровать все объекты, имеющие соответствующие метки. Так мы отфильтруем все поды деплоймента:

`kubectl get pod -l app=hello-demo`{{execute T1}}

А теперь с помощью **jsonpath** выведем имя первого пода из списка:

`kubectl get pod -l app=hello-demo -o jsonpath="{.items[0].metadata.name}"`{{execute T1}}

Запомним его в переменную `POD_NAME`

`POD_NAME=$(kubectl get pod -l app=hello-demo -o jsonpath="{.items[0].metadata.name}")`{{execute T1}}

И удалим:

`kubectl delete pod $POD_NAME`{{execute T1}}

Во второй вкладке можем наблюдать за тем, как создаcтся еще одна новая пода.

```
NAME                               READY   STATUS        RESTARTS   AGE
hello-deployment-d67cff5cc-2vpkg   1/1     Running       0          6s
hello-deployment-d67cff5cc-8zbpd   1/1     Terminating   0          81s
hello-deployment-d67cff5cc-hrfh8   1/1     Running       0          4m12s
hello-deployment-d67cff5cc-hsf6g   1/1     Running       0          4m12s
```

## 
