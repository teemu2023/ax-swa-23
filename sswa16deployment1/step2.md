Контроллер Deployments делает всё, чтобы реальное состояние совпадало с желаемым. И в случае изменения желаемого состояния он производит соответствующие изменения в реальном состоянии.

Например, одна из задач контроллера **Deployments** — это поддерживать требуемое количество реплик приложения. Если поменять количество реплик в объекте Deployments, то контроллер запустит новые поды или остановит работающие, так, чтобы количество подов в общем счёте соответствовало желаемому состоянию.

Поменяйте количество реплик в манифесте с 2 до 3:

<pre class="file" data-filename="./deployment.yaml" data-target="insert" data-marker="  replicas: 2">
replicas: 3</pre>

И примените его:

`kubectl apply -f deployment.yaml`{{execute T1}}

Состояние развёртывания можно получить с помощью команды:

`kubectl get deploy hello-deployment `{{execute T1}}

## Масштабирование развёртывания с помощью kubectl scale

Масштабировать Deployments можно с помощью императивной команды **kubectl scale**.

Например, `kubectl scale deploy/hello-deployment --replicas=2`{{execute T1}}

Состояние развёртывания можно получить с помощью команды:

`kubectl get deploy hello-deployment `{{execute T1}}

А после команды:

`kubectl scale deploy/hello-deployment --replicas=3`{{execute T1}}

создается еще один под:

`kubectl get deploy hello-deployment `{{execute T1}}


## Удаление одного из подов развёртывания

Одна из задач контроллера Deployments — это поддерживать требуемое количество реплик. Если что-то случится с одним из подов, управляемых Deployments, то контроллер создаст новый под по шаблону на замену упавшему.

Удалим один под, и посмотрим, что произойдет.

Чтобы получить список всех подов, воспользуемся параметром **-l** в команде **kubectl get**. Этот параметр позволяет фильтровать все объекты, имеющие соответствующие метки. Таким образом будут отфильтрованы все необходимые поды:

`kubectl get pod -l app=hello-demo`{{execute T1}}

С помощью **jsonpath** выведите имя первого пода из списка:

`kubectl get pod -l app=hello-demo -o jsonpath="{.items[0].metadata.name}"`{{execute T1}}

Запомните его в переменную POD_NAME:

`POD_NAME=$(kubectl get pod -l app=hello-demo -o jsonpath="{.items[0].metadata.name}")`{{execute T1}}

А теперь удалите под:

`kubectl delete pod $POD_NAME`{{execute T1}}

Чтобы увидеть как создастся ещё одна новая пода, выполните команду:

`kubectl get deploy hello-deployment `{{execute T1}}

## 
