Игрок
==========
| Метод | Описание | OA2 |
| ----- | -------- |:---:|
| [GET /player/info/](player.md) | Информация о игроке. | - |
| [PUT /player/online/](player.md) | Устанавливает статус игрока в онлайн режим на 15 минут. | + |
| [GET /player/shop/](player.md) | История покупок и продаж игрока в игровом магазине. | - |
| [GET /player/violations/](player.md) | Информация о нарушениях игрока. | - |
| [GET /player/search/](player.md) | Поиск игрока. | - |
| [GET /player/chat/](player.md) | История сообщений игрока в чате. | + |
| [GET /player/commands/](player.md) | История вызовов игровых команд | + |

## ``` GET /player/info/ ``` 
Вся информация об игроке. Для получение более личной информации необходимо предоставить токен.

### Параметры запроса
| Параметры | Необходимость | Пояснение |
| --------- | ------------- | --------- |
| name      | Обязательно.  | Ник игрока. |
### Пример запроса
``` 
http://enapi.ru/2.0/player/info/ensiriuswOw/
```
### Пример ответа 
```json 
{"player":{
        "level":"7",
        "registration":"1369652283",
        "last_login":"1369652283",
        "forum_topics":"113",
        "forum_posts":"3742",
        "online":"1"
        "logo":"http://ensemplix.ru/images/logos/default.jpg",
        "clan":"Ensemplix",
        "coins":"100000",
        "experience":"1000",
        "played":"10800",
        "prefix":"&EАдминистратор",
        "chat_color":"a",
        "name_color":"c",
        "donate_till":"1369652283",
      }
}
```




