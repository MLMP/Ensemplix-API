class V2::ServerController < ApplicationController

  # GET /server/launcher/
  # Версия лаунчера.
  def launcher
    @launcher = {version: Stat.find_by_stat('launcher_version').value}
    render json: @launcher
  end

  # GET /server/game/
  # Информация о игровых серверах. Обновление информации о статусе и игроках
  # происходит раз в минуту.
  def game
    @game = Server.joins("LEFT JOIN `servers_types` ON (`servers`.`server_type` = `servers_types`.`server_type`)")
    render json: @game
  end

  # GET /server/bundle/
  # Информация по главному плагину.
  def bundle
    @bundle_version = {bundle_version: Stat.find_by_stat('bundle_version').value}
    @bundle_url = {bundle_url: Stat.find_by_stat('bundle_url').value}
    render json: @bundle_version.merge(@bundle_url)
  end

  # GET /server/news/
  # Новости сервера.
  def news
    @news = News.last(5)
    render json: @news
  end

  # GET /server/bans/
  # Список забаненных игроков.
  def bans
    @bans = Ban.order("id DESC")

    if params.has_key? :offset
      @bans = @bans.offset(params[:offset])
    end

    @count = @bans.count()
    @bans = @bans.limit(100)

    render :json => {
        :bans => @bans,
        :count => @count,
        :offset => params[:offset]
    }

  end

end
