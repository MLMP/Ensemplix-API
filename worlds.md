Мир
==========

| Метод | Описание | OA2 |
| ----- | -------- |:---:|
| [GET /worlds/](worlds.md) | Названия миров. | - |
| [GET /world/blocks/](worlds.md) | Изменения блоков в мире на указанных координатах. | - |
| [GET /world/warps/](worlds.md) | Получение информации о ближайший варпах. | - |
| [GET /world/region/](worlds.md) | Информация о регионе. | - |

## ``` GET /worlds/ ``` 

### Параметры

Параметры не нужны

### Пример запроса
``` 
http://enapi.ru/worlds/
```
### Пример ответа 
```json 
["Sandbox","CarnageR4","CogitoR4","HiTech152","Davids152","Magnus152","Theos","DedalR2","AmberR4"]
```

## ``` GET /world/blocks/ ``` 

### Параметры

Параметры не нужны

### Пример запроса
``` 
http://enapi.ru/worlds/blocks/x/521/y/66/z/199/world/Davids152/
```
### Пример ответа 
```json 
[{"player":"serg_next12","id":"1","data":"0","time":"2013-08-13 11:36:25.547936","world":"Davids152","location":"521,66,199"},{"player":"serg_next12","id":"1","data":"0","time":"2013-08-13 11:35:38.817372","world":"Davids152","location":"521,66,199"},{"player":"serg_next12","id":"250","data":"5","time":"2013-08-11 10:32:42.879287","world":"Davids152","location":"521,66,199"},{"player":"vovance","id":"35","data":"0","time":"2013-08-11 09:14:32.625149","world":"Davids152","location":"521,66,199"},{"player":"serg_next12","id":"0","data":"0","time":"2013-08-08 07:10:06.394314","world":"Davids152","location":"521,66,199"},{"player":"serg_next12","id":"0","data":"0","time":"2013-08-08 07:09:49.925695","world":"Davids152","location":"521,66,199"}]
```





