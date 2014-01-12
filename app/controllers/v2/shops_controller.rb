class V2::ShopsController < ApplicationController

  # GET /shops/
  # История магазинов.
  def index
    @shop = Shop.order("id DESC")
    @shop = @shop.where("world = ?", params[:world]) if params.has_key? :world
    @shop = @shop.where("operation = ?", params[:operation]) if params.has_key? :operation
    @shop = @shop.joins("INNER JOIN `items` ON (`items`.`item` = `logs_shop`.`item`)")
    @shop = @shop.where("`items`.`id` = ?", params[:id]) if params.has_key? :id
    @shop = @shop.where("`items`.`data` = ?", params[:data]) if params.has_key? :data
    @shop = @shop.select("`logs_shop`.*, `items`.`id` as `item_id`, `items`.`data`,
       CONCAT('http://ensemplix.ru/images/items/', IFNULL(`items`.`icon`,'default.png')) as `icon_image`")

    @count = @shop.count()
    @shop = @shop.limit(100)

    if params.has_key? :offset
      @shop = @shop.offset(params[:offset])
    end

    if @shop.nil?
      render :json => {
          :error => "No operations found.",
          :offset => params[:offset],
          :world => params[:world],
          :operation => params[:operation],
          :id => params[:id],
          :data => params[:data]
      }
      return;
    end

    render :json => {
        :history => @shop,
        :count => @count,
        :offset => params[:offset],
        :world => params[:world],
        :operation => params[:operation],
        :id => params[:id],
        :data => params[:data]
    }
  end

  # GET /shops/location/
  # История магазинов в указанном месте.
  def location
    if !params.has_key? :x
      render json: {error: "Please provide X coordinate."}, :status => 422
      return;
    end

    if !params.has_key? :z
      render json: {error: "Please provide Z coordinate."}, :status => 422
      return;
    end

    if !params.has_key? :world
      render json: {error: "Please provide world."}, :status => 422
      return;
    end

    @shop = Shop.order("id DESC")
    @shop = @shop.where("x < :x AND x > :x - 250 AND z < :z + 250 AND z > :z - 250 AND world = :world",
                        x: params[:x], z: params[:z], world: params[:world])
    @shop = @shop.where("operation = ?", params[:operation]) if params.has_key? :operation
    @shop = @shop.where("y = ?", params[:y]) if params.has_key? :y
    @shop = @shop.joins("INNER JOIN `items` ON (`items`.`item` = `logs_shop`.`item`)")
    @shop = @shop.where("`items`.`id` = ?", params[:id]) if params.has_key? :id
    @shop = @shop.where("`items`.`data` = ?", params[:data]) if params.has_key? :data
    @shop = @shop.select("`logs_shop`.*, `items`.`id` as `item_id`, `items`.`data`,
       CONCAT('http://ensemplix.ru/images/items/', IFNULL(`items`.`icon`,'default.png')) as `icon_image`")

    @count = @shop.count()
    @shop = @shop.limit(100)

    if params.has_key? :offset
      @shop = @shop.offset(params[:offset])
    end

    if @shop.nil?
      render :json => {
          :error => "No operations found.",
          :offset => params[:offset],
          :world => params[:world],
          :operation => params[:operation],
          :id => params[:id],
          :data => params[:data]
      }
      return;
    end

    render :json => {
        :history => @shop,
        :count => @count,
        :offset => params[:offset],
        :world => params[:world],
        :operation => params[:operation],
        :id => params[:id],
        :data => params[:data]
    }
  end

  # GET /shops/player/:player/
  # Историю магазина игрока.
  def player
    if !params.has_key? :player
      render json: {error: "Please provide player."}, :status => 422
      return;
    end

    @shop = Shop.order("id DESC")

    @shop = @shop.where("world = ?", params[:world]) if params.has_key? :world
    @shop = @shop.where("operation = ?", params[:operation]) if params.has_key? :operation


    @shop = @shop.joins("INNER JOIN `items` ON (`items`.`item` = `logs_shop`.`item`)")
    @shop = @shop.where("`items`.`id` = ?", params[:id]) if params.has_key? :id
    @shop = @shop.where("`items`.`data` = ?", params[:data]) if params.has_key? :data

    @count = @shop.count()
    @shop = @shop.select("`logs_shop`.*, `items`.`id` as `item_id`, `items`.`data`,
      CONCAT('http://ensemplix.ru/images/items/', IFNULL(`items`.`icon`,'default.png')) as `icon_image`")

    @shop = @shop.limit(100)

    if params.has_key? :offset
      @shop = @shop.offset(params[:offset])
    end

    if @shop.nil?
      render :json => {
          :error => "No operations found.",
          :offset => params[:offset],
          :player => params[:player],
          :world => params[:world],
          :operation => params[:operation],
          :id => params[:id],
          :data => params[:data]
      }
      return;
    end

    render :json => {
        :history => @shop,
        :count => @count,
        :offset => params[:offset],
        :player => params[:player],
        :world => params[:world],
        :operation => params[:operation],
        :id => params[:id],
        :data => params[:data]
    }
  end

end
