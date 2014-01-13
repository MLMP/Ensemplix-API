Ensemplix API
==========

### Начало

Ensemplix старается быть дружелюбным к разработчикам всех направлений и по возможности придать интерес разработчикам для создания различных приложений, программ, сервисов и т.д. с помощью
данных, которые у нас есть. Мы избавляем разработчиков от парсинга страниц и предоставляем все данные в JSON формате. Для всех языков программирования существуют библиотеки, которые помогут быстро
и легко получить данные. В данном руководстве описаны все методы для работы, а также примеры ответов и запросов. 
Если у Вас есть какие-либо идеи или предложения, Вы можете оставить тикет или написать на email: support@ensemplix.ru.

#### Версия
2

#### OAuth

В данный момент запланирована реализация OAuth 2.0 для приложений. Это позволит существенно расширить количество различных
API для работы. OAuth позволяет получить приложению доступ к учетной записи пользователя после подтверждения со стороны игрока,
что он доверяет указанному приложению. После этого приложение получает специальный токен, с помощью которого сможет получать
информацию о личных данных игрока. В документации методы, которым необходим токен, указаны "+". 

#### Ограничения

В данный момент количество вызовов неограниченно. В будущем планируется ограничить количество вызовов API за определенный
промежуток времени.

## Предоставляемые методы для работы

Все вызовы осуществляются через домен http://api.ensemplix.ru/v2/
### Игрок
| Метод | Описание | OA2 |
| ----- | -------- |:---:|
| [GET /player/info/:player/](docs/player.md#get-playerinfoplayer) | Информация об игроке. | - |
| [GET /player/violations/:player/](docs/player.md#get-playerviolationsplayer) | Информация о нарушениях игрока. | - |
| [GET /player/search/:player/](docs/player.md#get-playersearchplayer) | Поиск игрока. | - |

### Блоки
| Метод | Описание | OA2 |
| ----- | -------- |:---:|
| [GET /blocks/](docs/blocks.md#get-blocks) | Список изменений блоков. | - |
| [GET /blocks/location/](docs/blocks.md#get-blockslocation) | Список изменений блоков в указанных координатах. | - |
| [GET /blocks/player/:player/](docs/blocks.md#get-blocksplayerplayer) | Список блоков, установленных игроком| - |

### Кланы
| Метод | Описание | OA2 |
| ----- | -------- |:---:|
| [GET /clans/](docs/clans.md#get-clans) | Список кланов на сервере. | - |
| [GET /clan/:id/](docs/clans.md#get-clanid) | Информация о клане. | - |

###Магазин
| Метод | Описание | OA2 |
| ----- | -------- |:---:|
| [GET /shops/](docs/shop.md#get-shops) | История магазинов. | - |
| [GET /shops/location/](docs/shop.md#get-shopslocation) | История магазинов в указанном месте. | - |
| [GET /shops/player/:player](docs/shop.md#get-shopsplayerplayer) | История магазина игрока. | - |

### Варпы
| Метод | Описание | OA2 |
| ----- | -------- |:---:|
| [GET /warp/:warp/:world/](docs/warps.md#get-warpwarpworld) | Информация о варпе. | - |
| [GET /warps/](docs/warps.md#get-warps) | Информация о варпах. |
| [GET /warps/location/](docs/warps.md#get-warpslocation) | Получение информации о ближайший варпах. | - |
| [GET /warps/player/](docs/warps.md#get-warpsplayer) | Варпы игрока. | - |

### Регионы
| Метод | Описание | OA2 |
| ----- | -------- |:---:|
| [GET /region/:region/:world/](docs/regions.md#get-regionregionworld) | Информация о регионе. | - |
| [GET /regions/](docs/regions.md#get-regions) | Информация о регионах. |
| [GET /regions/location/](docs/regions.md#get-regionslocation) | Получение информации о ближайший регионах. | - |
| [GET /regions/player/:player/](docs/regions.md#get-regionsplayerplayer) | Информация о регионах игрока. | - |

### Сервер
| Метод | Описание | OA2 |
| ----- | -------- |:---:|
| [GET /server/game/](docs/server.md#get-servergame) | Информация об игровых серверах. | - |
| [GET /server/bans/](docs/server.md#get-serverbans) | Список забаненных игроков. | - |
| [GET /server/news/](docs/server.md#get-servernews) | Новости сервера. | - |
| [GET /server/launcher/](docs/server.md#get-serverlauncher) | Версия лаунчера. | - |
| [GET /server/bundle/](docs/server.md#get-serverbundle) | Версия основного плагина. | - |

## Программы испольюущие Ensemplix-API

Карты варпов для всех серверов http://forum.ensemplix.ru/viewtopic.php?f=101&t=64892 от web93onv














