Ensemplix API
==========

###Внимание! API в разработке и официально не реализовано. Указанная документация лишь набросок.

### Начало

Ensemplix старается быть дружелюбным к разработчикам всех направлений и старается придать интерес разработчикам для создания различных приложений, программ, сервисов и т.д. с помощью
данных, которые у нас есть. Мы избавляем разработчиков от парсинга страниц и предоставляем все данные в JSON формате. Для всех языков проограммирования существуют библиотеки, которые помогут быстро
и легко получить данные. В данном руководстве описаны все методы для работы, а также примеры ответов и запросов. 
Если у Вас есть какие либо идеи или предложения, Вы можете оставить тикет или написать на email support@ensemplix.ru.

#### Версия
2.0

#### OAuth

В данный момент запланирована реализация OAuth 2.0 для приложений. Это позволит существенно расширить количество различных
API для работы. OAuth - позволяет получить доступ к учетной записи пользователя приложению, после подтверждения со стороны игрока,
что он доверяет указанному приложению. После этого, приложение получает специальный токен, с помощью которого сможет получать
информацию о личных данных игрока. В документации методы, которым необходим токен, указан +. 

#### Ограничения

В данный момент количество вызовов не ограничено. В будущем планируется ограничесть количество вызовов API за определенный
промежуток времени.

## Предоставляемые методы для работы

Все вызовы осуществляются через домен www.enapi.ru/2.0/

### Миры
| Метод | Описание | OA2 |
| ----- | -------- |:---:|
| [GET /worlds/](docs/worlds.md#get-worlds) | Названия миров. | - |

### Игрок
| Метод | Описание | OA2 |
| ----- | -------- |:---:|
| [GET /player/info/](docs/player.md#get-playerinfo) | Информация о игроке. | - |
| [PUT /player/online/](docs/player.md#put-playeronline) | Устанавливает статус игрока в онлайн режим на 15 минут. | + |
| [GET /player/violations/](docs/player.md#get-playerviolations) | Информация о нарушениях игрока. | - |
| [POST /player/search/](docs/player.md#post-playersearch) | Поиск игрока. | - |
| [GET /player/chat/](docs/player.md#get-playerchat) | История сообщений игрока в чате. | + |
| [GET /player/commands/](docs/player.md#get-playercommands) | История вызовов игровых команд | + |

### Блоки
| Метод | Описание | OA2 |
| ----- | -------- |:---:|
| [GET /blocks/info/](docs/blocks.md#get-blocksinfo) | Изменения блоков в мире на указанных координатах. | - |
| [GET /blocks/player/](docs/blocks.md#get-blocksplayer) | Статистика изменений блоков у игрока. | - |

### Кланы
| Метод | Описание | OA2 |
| ----- | -------- |:---:|
| [GET /clans/](docs/clans.md#get-clans) | Список кланов на сервере. | - |
| [GET /clan/](docs/clans.md#get-clan) | Информация о клане. | - |

###Почта
| Метод | Описание | OA2 |
| ----- | -------- |:---:|
| [GET /mail/player/](docs/mail.md#get-mailplayer) | Получить почту игрока. | + |
| [PUT /mail/send/](docs/mail.md#put-mailsend) | Отправить письмо. | + |
| [DELETE /mail/delete/](docs/mail.md#put-mailsend) | Удаляет почту игрока. | + |

###Магазин
| Метод | Описание | OA2 |
| ----- | -------- |:---:|
| [GET /shop/info/](docs/shop.md#get-shopinfo) | История покупки и продажи в магазин. | - |

### Варпы
| Метод | Описание | OA2 |
| ----- | -------- |:---:|
| [GET /warp/](docs/warps.md#get-warp.md) | Информация о варпе. | - |
| [GET /warps/search/](docs/warps.md#get-warpssearch) | Поиск варпов по названию. | - |
| [GET /warps/location/](docs/warps.md#get-warpslocation) | Получение информации о ближайший варпах. | - |
| [GET /warps/player/](docs/warps.md#get-warpsplayer) | Варпы игрока. | - |

### Регионы
| Метод | Описание | OA2 |
| ----- | -------- |:---:|
| [GET /regions/info/](docs/regions.md#get-regionsinfo) | Информация о регионе. | - |
| [GET /regions/search/](docs/regions.md#get-regionssearch) | Поиск регионов по названию. | - |
| [GET /regions/location/](docs/regions.md#get-regionslocation) | Получение информации о ближайший регионах. | - |
| [GET /regions/player/](docs/regions.md#get-regionsplayer) | Информация о регионах игрока. | - |

### Сервер
| Метод | Описание | OA2 |
| ----- | -------- |:---:|
| [GET /server/game/](docs/server.md#get-servergame) | Информация о игровых серверах. | - |
| [GET /server/web/](docs/server.md#get-serverweb) | Информация о посетителях сайта. | - |
| [GET /server/events/](docs/server.md#get-serverevents) | События за последние время на сервере. | - |
| [GET /server/stats/](docs/server.md#get-serverstats) | Различная статистика сервера. | - |
| [GET /server/bans/](docs/server.md#get-serverbans) | Список забаненных игроков. | - |
| [GET /server/news/](docs/server.md#get-servernews) | Новости сервера. | - |
| [GET /server/launcher/](docs/server.md#get-serverlauncher) | Версия лаунчера. | - |
| [GET /server/client/](docs/server.md#getserverclient) | Версия сборки клиента. | - |

### Форум
| Метод | Описание | OA2 |
| ----- | -------- |:---:|
| [GET /forum/topics/](forum.md) | Последние темы на форуме. | - |
| [GET /forum/topic/](forum.md) | Информация о теме. | - |
| [GET /forum/posts/](forum.md) | Последние сообщения на форуме. | - |
| [GET /forum/create/thread/](forum.md) | Создать тему на форуме. | + |
| [GET /forum/create/post/](forum.md) | Создать сообщение на форуме. | + |
| [GET /forum/player/](forum.md) | История сообщений игрока. | - |














