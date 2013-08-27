Ensemplix API
==========

###Внимание! API в разработке и официально не реалиозванно. Указанная документация лишь набросок.

### Начало

Ensemplix старается быть дружелюбным к разработчикам всех направлений и старается придать интерес разработчикам для создания различных приложений, программ, сервисов и т.д с помощью
данных которые у нас есть. Мы избавляем разработчиков от парсинга страниц и предоставляем все данные в JSON формате. Для всех языков проограммиованья существует библиотеки которые помогут быстро
и легко получить данные. В данной рукововодстве описаны все методы для работы, а так же примеры ответов и запроосов. 
Если у Вас есть какие либо идеи или предложения, Вы можете оставить тикет или написать на email support@ensemplix.ru.

#### Версия
2.0

#### OAuth

В данный момент запланирована реализация OAuth 2.0 для приложений. Это позволит существенно расширить количество различных
API для работы. OAuth - позволяет получить доступ к учетной записи пользователя приложению, после подтверждения со стороны игрока,
что он доверяет указанному приложению.

#### Ограничения

В данный момент количество вызовов не ограничено. В будущем планируется ограничесть количество вызовов API за определенный
промежуток времени.

## Предоставляемые методы для работы

Все вызовы осуществляются через домен www.enapi.ru/2.0/

### Миры
| Метод | Описание |
| ----- | ----------------- |
| [GET /worlds/](worlds.md) | Названия миров. Название миров может отличаться от названия сервера. |
| [GET /worlds/blocks/](worlds.md) | Изменения блоков в мире на указанных координатах. |

### Игрок

| Метод | Описание |
| ----- | ----------------- |
| [GET /player/](player.md) | Информация о игроке. |
| [GET /player/shop/](player.md) | История покупок и продаж игрока в игровом магазине. |
| [GET /player/regions/](player.md) | Информация о регионах игрока. |
| [GET /player/blocks/](player.md) | Статистика изменений блоков. |
| [GET /player/violations/](player.md) | Информация о нарушениях игрока. |

### Кланы
| Метод | Описание |
| ----- | ----------------- |
| [GET /clans/](clans.md) | Список кланов на сервере. |

### Сервер
| Метод | Описание |
| ----- | ----------------- |
| [GET /server/online/](server.md) | Онлайн серверов. |
| [GET /server/events/](server.md) | События за последние время на сервере. |
| [GET /server/stats/](server.md) | Различная статистика сервера. |










