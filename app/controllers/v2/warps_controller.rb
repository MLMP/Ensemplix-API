class V2::WarpsController < ApplicationController

  # GET /warps/
  # Информация о варпах.
  def index

    @warps = Warp
    @warps = @warps.where("world = ?", params[:world]) if params.has_key? :world
    @count = @warps.count()

    if params.has_key? :offset
      @warps = @warps.offset(params[:offset])
    end

    @warps = @warps.limit(100)

    render :json => {
        :warps => @warps,
        :count => @count,
        :offset => params[:offset],
        :world => params[:world]
    }

  end

  # GET /warp/:warp/:world/
  # Информация о варпе.
  def info
    if !params.has_key? :warp
      render json: {error: "Please provide warp."}, :status => 422
      return;
    end

    if !params.has_key? :world
      render json: {error: "Please provide world."}, :status => 422
      return;
    end

    @warp = Warp.where("warp = ? AND world = ?", params[:warp], params[:world]).take()

    if @warp.nil?
      render :json => {
          :error => "Warp not found.",
          :warp => params[:warp],
          :world => params[:world],
      }, :status => 422
      return;
    end

    render json: @warp
  end

  # GET /warps/location/
  # Получение информации о ближайший варпах в указанных координатах.
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

    @warps = Warp.where("x < :x AND x > :x - 250 AND z < :z + 250 AND z > :z - 250 AND world = :world",
                        x: params[:x], z: params[:z], world: params[:world])

    if params.has_key? :offset
      @warps = @warps.offset(params[:offset])
    end

    @count = @warps.count()
    @warps = @warps.limit(100)

    if @warps.empty?
      render :json => {
          :error => "No warps found.",
          :x => params[:x],
          :z => params[:z],
          :world => params[:world]
      }, :status => 422
      return;
    end

    render :json => {
        :warps => @warps,
        :x => params[:x],
        :z => params[:z],
        :count => @count,
        :offset => params[:offset],
    }

  end

  # GET /warps/player/:player/
  # Варпы игрока.
  def player
    if !params.has_key? :player
      render json: {error: "Please provide player."}, :status => 422
      return;
    end

    @warps = Warp.where("owner = ?", params[:player])
    @warps = @warps.where("world = ?", params[:world]) if params.has_key? :world

    if params.has_key? :offset
      @warps = @warps.offset(params[:offset])
    end

    @count = @warps.count()
    @warps = @warps.limit(100)

    if @warps.empty?
      render :json => {
          :error => "No warps found.",
          :offset => params[:offset],
          :player => params[:player],
          :world => params[:world],
      }, :status => 422
      return;
    end

    render :json => {
        :warps => @warps,
        :count => @count,
        :offset => params[:offset],
        :player => params[:player],
        :world => params[:world],
    }

  end

end