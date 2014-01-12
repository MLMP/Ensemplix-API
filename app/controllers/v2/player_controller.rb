class V2::PlayerController < ApplicationController

  # GET /player/info/:player
  # Информация о игроке.
  def info
    if !params.has_key? :player
      render json: {error: "Please provide player."}, :status => 422
      return;
    end

    @player = Player.select("`id`, `level`, `players`.`player`, `registration`, `online`, `players_balance`.`coins`,
     CONCAT('http://ensemplix.ru/images/logos/', IFNULL(logo_url,'default.jpg')) as `logo_url`,
     `players_played`.`played`, `players_experience`.`experience`, `players_prefix`.`prefix`,
     `players_colors`.`name` as `name_color`, `players_colors`.`chat` as `chat_color`, `clans_members`.`clan`,
     `last_online`.`time` as `last_online`")
    .joins("INNER JOIN `players_balance` ON (`players_balance`.`player` = `players`.`player`)")
    .joins("INNER JOIN `players_played` ON (`players_played`.`player` = `players`.`player`)")
    .joins("INNER JOIN `players_experience` ON (`players_experience`.`player` = `players`.`player`)")
    .joins("INNER JOIN `last_online` ON (`last_online`.`player` = `players`.`player`)")
    .joins("LEFT JOIN `players_prefix` ON (`players_prefix`.`player` = `players`.`player`)")
    .joins("LEFT JOIN `players_colors` ON (`players_colors`.`player` = `players`.`player`)")
    .joins("LEFT JOIN `clans_members` ON (`clans_members`.`player` = `players`.`player`)")
    .where("`players`.`player` = ?", params[:player]) if params.has_key? :player

    if @player.nil?
      render :json => {
          :error => "Player not found.",
          :offset => params[:player],
      }
      return;
    end

    render json: @player
  end

  # GET /player/violations/:player
  # Информация о нарушениях игрока.
  def violations
    if !params.has_key? :player
      render json: {error: "Please provide player."}, :status => 422
      return;
    end

    @muted = Mute.find_by_player(params[:player]);
    @banned = Ban.find_by_player(params[:player]);

    render :json => {
        :muted => @muted,
        :banned => @banned
    }
  end

  # GET /player/search/:player
  # Поиск игрока.
  def search
    if !params.has_key? :player
      render json: {error: "Please provide player."}, :status => 422
      return;
    end

    if params[:player].length < 4
      render :json => {
          :error => "Minimum player name length 4",
          :player => params[:player],
      }
      return;
    end

    @players = Player.where("`player` LIKE ?", "%" + params[:player] + "%").pluck("player")

    if @players.nil?
      render :json => {
          :error => "Players not found.",
          :player => params[:player],
      }
      return;
    end

    render json: @players
  end

end