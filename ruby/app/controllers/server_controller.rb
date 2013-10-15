class ServerController < ApplicationController

  # GET /server/launcher/
  # Версия лаунчера.
  def launcher
    @launcher = Stat.select('value as version').where(stat: 'launcher_version').take
     render json: @launcher
  end


  # GET /server/client/
  # Версия сборки клиента.
  def client
    @client = Stat.select('value as version').where(stat: 'client_version').take
    render json: @client
  end

  # GET /server/news/
  # Версия сборки клиента.
  def news
    @news = Stat.last(5)
    render json: @news
  end

end
