EnsemplixApi::Application.routes.draw do

  namespace :v2 do
    get 'server/launcher' => 'server#launcher'
    get 'server/game' => 'server#game'
    get 'server/bundle' => 'server#bundle'
    get 'server/news' => 'server#news'
    get 'server/bans' => 'server#bans'

    get 'clans' => 'clans#index'
    get 'clan/' => 'clans#info'
    get 'clan/:id' => 'clans#info'

    get 'blocks' => 'blocks#index'
    get 'blocks/location/' => 'blocks#location'
    get 'blocks/player/' => 'blocks#player'
    get 'blocks/player/:player' => 'blocks#player'

    get 'warp' => 'warps#info'
    get 'warp/:warp/' => 'warps#info'
    get 'warp/:warp/:world' => 'warps#info'
    get 'warps' => 'warps#index'
    get 'warps/location/' => 'warps#location'
    get 'warps/player/' => 'warps#player'
    get 'warps/player/:player' => 'warps#player'

    get 'region' => 'regions#info'
    get 'region/:region/' => 'regions#info'
    get 'region/:region/:world' => 'regions#info'
    get 'regions' => 'regions#index'
    get 'regions/location/' => 'regions#location'
    get 'regions/player/' => 'regions#player'
    get 'regions/player/:player' => 'regions#player'

    get 'shops' => 'shops#index'
    get 'shops/player/' => 'shops#player'
    get 'shops/player/:player' => 'shops#player'
    get 'shops/location/' => 'shops#location'

    get 'player/info/' => 'player#info'
    get 'player/info/:player' => 'player#info'
    get 'player/violations/' => 'player#violations'
    get 'player/violations/:player' => 'player#violations'
    get 'player/search/' => 'player#search'
    get 'player/search/:player' => 'player#search'

  end

end
