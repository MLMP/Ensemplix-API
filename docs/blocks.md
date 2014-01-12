Блоки
==========

| Метод | Описание | OA2 |
| ----- | -------- |:---:|
| [GET /blocks/](docs/blocks.md#get-blocks) | Список изменений блоков. | - |
| [GET /blocks/location/](docs/blocks.md#get-blockslocation) | Список изменений блоков в указанных координатах. | - |
| [GET /blocks/player/:player/](docs/blocks.md#get-blocksplayer) | Список блоков установленных игроком| - |

## ``` GET /blocks/ ```
Список изменений блоков.

### Параметры запроса

| Параметор | Необходимость | Пояснение |
| --------- | ------------- | --------- |
| offset    | Опционально.  | Начало выборки блоков. |
| world     | Опционально.  | Игровой мир. |
| type      | Опционально.  | 0 - только сломанные блоки. 1 - только поставленные блоки. |
| id        | Опционально.  | Поиск операций по укзанному id блока. |
| data      | Опционально.  | Поиск операций по укзанной метаданной блока. |

``` 
http://api.ensemplix.ru/v2/blocks/?world=Sandbox
```

### Пример ответа 
```json 
{"blocks":[{
   "id":83009484,
   "player":"Ruslan7227",
   "block":4,
   "data":0,
   "x":2909,
   "y":69,
   "z":1896,
   "world":"Sandbox",
   "created":1389531324,
   "type":1
   }]
```

### Пояснение параметров ответа
| Параметры | Пояснение |
| --------- | --------- |
| id        | Уникальный индификатор блока. |
| player    | Игровой ник. |
| block     | Id блока. |
| data      | Мета-данная блока. |
| x         | Координата по оси X. |
| y         | Координата по оси Y. |
| z         | Координата по оси Z. |
| created   | Время когда был изменен блок в unix timestamp формате. |
| type      | 0 - сломали блок, 1 - поставили блок. |

## ``` GET /blocks/location/ ``` 
Список изменений в указанных координатах. Показывает как установленные блоки, так и блоки которые были установлены.

### Параметры запроса

| Параметор | Необходимость | Пояснение |
| --------- | ------------- | --------- |
| x         | Обязательно.  | Координата по оси X. |
| z         | Обязательно.  | Координата по оси Z. |
| world     | Обязательно.  | Игровой мир. |
| y         | Опционально.  | Координата по оси Y. |
| offset    | Опционально.  | Начало выборки блоков. |
| type      | Опционально.  | 0 - только сломанные блоки. 1 - только поставленные блоки. |
| id        | Опционально.  | Поиск операций по укзанному id блока. |
| data      | Опционально.  | Поиск операций по укзанной метаданной блока. |


### Пример запроса
``` 
http://enapi.ru/2.0/blocks/info/x/521/y/66/z/199/world/Davids152/
```
### Пример ответа 
```json 
{"blocks":{
    "player":"serg_next12",
    "status": "1",
    "id":"1",
    "data":"0",
    "modifed":"1377670832"}
}
```

### Пояснение параметров ответа
| Параметры | Пояснение |
| --------- | --------- |
| player    | Игровой ник. |
| status    | 0 - сломали блок, 1 - поставили блок. |
| id        | Id блока. |
| data      | Мета-данная блока. |
| modifed   | Время когда был изменен блок в unix timestamp формате. |

### Возможные ошибки
| Ошибка | Пояснение |
| ------ | --------- |
| No records found. | Записей изменений по указанным координатам нет. |
| Please provide X coordinate. | Необходимо указать координату по оси X. |
| Please provide Y coordinate. | Необходимо указать координату по оси Y. |
| Please provide Z coordinate. | Необходимо указать координату по оси Z. |
| Please provide world. | Необходимо указать игровой мир. |

## ``` GET /blocks/player/ ``` 









