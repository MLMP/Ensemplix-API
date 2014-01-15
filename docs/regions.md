Регионы
==========
Описание различных методов для работы с регионами.

| Метод | Описание | OA2 |
| ----- | -------- |:---:|
| [GET /region/:region/:world/](regions.md#get-regionregionworld) | Информация о регионе. | - |
| [GET /regions/](regions.md#get-regions) | Информация о регионах. |
| [GET /regions/location/](regions.md#get-regionslocation) | Получение информации о ближайший регионах. | - |
| [GET /regions/player/:player/](regions.md#get-regionsplayerplayer) | Информация о регионах игрока. | - |


# ``` GET /region/:region/:world/ ``` 
Возвращает информацию о регионе.

### Параметры

| Параметры | Необходимость | Пояснение |
| --------- | ------------- | --------- |
| region    | Обязательно.  | Название региона. |
| world     | Обязательно.  | Игровой мир. |

### Пример запроса
``` 
http://api.ensemplix.ru/v2/region/spawn/Sandbox/
```

### Пример ответа 
```json 
{"region": {
    "region":"spawn",
      "min_x":-301,
      "min_y":0,
      "min_z":-301,
      "max_x":300,
      "max_y":255,
      "max_z":300,
      "world":"Sandbox",
      "created":1385965569
    },
    "owners":["Ibragim091986","IceZedicus","rensy","shev","Ziroy"],
    "members":["Drakyla67","elon","NCR","UrbankZ"],
    "flags":["ice-form","ice-melt","snow-fall","spawn-animals","spawn-mobs"],
    "children":["spawn_metro"],
    "parent":null
}
```
### Пояснение параметров ответа
| Параметры | Пояснение |
| --------- | --------- |
| region    | Название региона. |
| minX      | Координата у точки min по оси X. |
| minY      | Координата у точки min по оси Y. |
| minZ      | Координата у точки min по оси Z. |
| maxX      | Координата у точки max по оси X. |
| maxY      | Координата у точки max по оси Y. |
| maxZ      | Координата у точки max по оси Z. |
| created   | Время создания региона в unix timestamp. |
| owners    | Список игроков, которые владеют регионом. |
| members   | Список жителей региона. |
| flags     | Список [флагов](regions.md#%D0%A4%D0%BB%D0%B0%D0%B3%D0%B8) в регионе. |
| childs    | Локальные регионы. |
| parent    | Глобальный регион. |

### Возможные ошибки
| Ошибка | Пояснение |
| ------ | --------- |
| Region not found. | Регион с таким названием не найден. |
| Please provide region. | Необходимо указать регион. |
| Please provide world. | Необходимо указать игровой мир. |

# ``` GET /regions/``` 
Информация о регионах.

### Параметры запроса

| Параметры | Необходимость | Пояснение |
| --------- | ------------- | --------- |
| world     | Опционально.  | Игровой мир. |
| offset    | Опционально.  | Начало выборки регионов. |

### Пример запроса
``` 
http://api.ensemplix.ru/v2/regions/
```
### Пример ответа 
```json 
{"region": {
    "region":"spawn",
      "min_x":-301,
      "min_y":0,
      "min_z":-301,
      "max_x":300,
      "max_y":255,
      "max_z":300,
      "world":"Sandbox",
      "created":1385965569
    },
    "owners":["Ibragim091986","IceZedicus","rensy","shev","Ziroy"],
    "members":["Drakyla67","elon","NCR","UrbankZ"],
    "flags":["ice-form","ice-melt","snow-fall","spawn-animals","spawn-mobs"],
    "children":["spawn_metro"],
    "parent":null
}
```
### Пояснение параметров ответа
| Параметры | Пояснение |
| --------- | --------- |
| region    | Название региона. |
| minX      | Координата у точки min по оси X. |
| minY      | Координата у точки min по оси Y. |
| minZ      | Координата у точки min по оси Z. |
| maxX      | Координата у точки max по оси X. |
| maxY      | Координата у точки max по оси Y. |
| maxZ      | Координата у точки max по оси Z. |
| created   | Время создания региона в unix timestamp. |
| owners    | Список игроков, которые владеют регионом. |
| members   | Список жителей региона. |
| flags     | Список [флагов](regions.md#%D0%A4%D0%BB%D0%B0%D0%B3%D0%B8) в регионе. |
| childs    | Локальные регионы. |
| parent    | Глобальный регион. |

### Возможные ошибки
| Ошибка | Пояснение |
| ------ | --------- |
| No regions found. | В радиусе указанных координат нет регионов. |

# ``` GET /regions/location/ ``` 
Получение информации о ближайший регионах.

### Параметры запроса

| Параметры | Необходимость | Пояснение |
| --------- | ------------- | --------- |
| x         | Обязательно.  | Координата по оси X. |
| z         | Обязательно.  | Координата по оси Z. |
| world     | Обязательно.  | Игровой мир. |
| offset    | Опционально.  | Начало выборки регионов. |

### Пример запроса
``` 
http://api.ensemplix.ru/v2/regions/location/?x=250&z=250&world=Sandbox
```
### Пример ответа 
```json 
{"region": {
    "region":"spawn",
      "min_x":-301,
      "min_y":0,
      "min_z":-301,
      "max_x":300,
      "max_y":255,
      "max_z":300,
      "world":"Sandbox",
      "created":1385965569
    },
    "owners":["Ibragim091986","IceZedicus","rensy","shev","Ziroy"],
    "members":["Drakyla67","elon","NCR","UrbankZ"],
    "flags":["ice-form","ice-melt","snow-fall","spawn-animals","spawn-mobs"],
    "children":["spawn_metro"],
    "parent":null
}
```
### Пояснение параметров ответа
| Параметры | Пояснение |
| --------- | --------- |
| region    | Название региона. |
| minX      | Координата у точки min по оси X. |
| minY      | Координата у точки min по оси Y. |
| minZ      | Координата у точки min по оси Z. |
| maxX      | Координата у точки max по оси X. |
| maxY      | Координата у точки max по оси Y. |
| maxZ      | Координата у точки max по оси Z. |
| created   | Время создания региона в unix timestamp. |
| owners    | Список игроков, которые владеют регионом. |
| members   | Список жителей региона. |
| flags     | Список [флагов](regions.md#%D0%A4%D0%BB%D0%B0%D0%B3%D0%B8) в регионе. |
| childs    | Локальные регионы. |
| parent    | Глобальный регион. |

### Возможные ошибки
| Ошибка | Пояснение |
| ------ | --------- |
| No regions found. | В радиусе указанных координат нет регионов. |
| Please provide X coordinate. | Необходимо указать координату по оси X. |
| Please provide Z coordinate. | Необходимо указать координату по оси Z. |
| Please provide world. | Необходимо указать игровой мир. |

# ``` GET /regions/player/:player/ ``` 
Возвращает список регионов игрока.

### Параметры

| Параметры | Необходимость | Пояснение |
| --------- | ------------- | --------- |
| player    | Обязательно.  | Ник игрока. |
| offset    | Опционально.  | Начало выборки регионов. |
| world     | Обязательно.  | Игровой мир. |

### Пример запроса
``` 
http://api.ensemplix.ru/v2/regions/player/ensiriuswOw/
```

### Пример ответа 
```json 
{"region": {
    "region":"spawn",
      "min_x":-301,
      "min_y":0,
      "min_z":-301,
      "max_x":300,
      "max_y":255,
      "max_z":300,
      "world":"Sandbox",
      "created":1385965569
    },
    "owners":["Ibragim091986","IceZedicus","rensy","shev","Ziroy"],
    "members":["Drakyla67","elon","NCR","UrbankZ"],
    "flags":["ice-form","ice-melt","snow-fall","spawn-animals","spawn-mobs"],
    "children":["spawn_metro"],
    "parent":null
}
```
### Пояснение параметров ответа
| Параметры | Пояснение |
| --------- | --------- |
| region    | Название региона. |
| minX      | Координата у точки min по оси X. |
| minY      | Координата у точки min по оси Y. |
| minZ      | Координата у точки min по оси Z. |
| maxX      | Координата у точки max по оси X. |
| maxY      | Координата у точки max по оси Y. |
| maxZ      | Координата у точки max по оси Z. |
| created   | Время создания региона в unix timestamp. |
| owners    | Список игроков, которые владеют регионом. |
| members   | Список жителей региона. |
| flags     | Список [флагов](regions.md#%D0%A4%D0%BB%D0%B0%D0%B3%D0%B8) в регионе. |
| childs    | Локальные регионы. |
| parent    | Глобальный регион. |

### Возможные ошибки
| Ошибка | Пояснение |
| ------ | --------- |
| No regions found. | Не были найдены записи о регионах игрока. |
| Please provide player. | Необходимо указать игрока. |

## Флаги

| Флаг | Пояснение |
| ------ | --------- |
| use    | Разрешает использовать механизмы на регионе игрокам, которые не вписаны. |
| animals | Разрешает убивать живность игрокам, которые не вписаны в регион. |
| ic | Разрешает пользоваться вещами для ic, bc, forestory игрокам, которые не вписаны. |
| chest | Разрешает пользоваться сундуками игрокам, которые не вписаны. |
| vehicle | Разрешает использовать средства передвижения (вагонетки, лодки). |
| snow-fall | Отключает выпадание снега. |
| ice-form | Отключает формирование льда. |
| mushrooms | Отключает спавн грибов. |
| potions  | Включает урон от зелий. |
| ice-melt | Отключает таяние льда. |
| snow-melt | Отключает таяние снега. |
| pistons  | Включает поршни. |











