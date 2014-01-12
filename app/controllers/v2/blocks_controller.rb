class V2::BlocksController < ApplicationController

  # GET /blocks/
  # Список изменений блоков.
  def index
    @blocks = Block
    @blocks = @blocks.where("world = ?", params[:world]) if params.has_key? :world
    @blocks = @blocks.where("type = ?", params[:type]) if params.has_key? :type
    @blocks = @blocks.where("block = ?", params[:id]) if params.has_key? :id
    @blocks = @blocks.where("data = ?", params[:data]) if params.has_key? :data
    @blocks = @blocks.order("id DESC")

    if params.has_key? :offset
      @blocks = @blocks.offset(params[:offset])
    end

    @blocks = @blocks.limit(100)

    if @blocks.empty?
      render :json => {
          :error => "No blocks found.",
          :offset => params[:offset],
          :world => params[:world],
          :type => params[:type],
          :id => params[:id],
          :data => params[:data]
      }
      return;
    end

    render :json => {
        :blocks => @blocks,
        :offset => params[:offset],
        :world => params[:world],
        :type => params[:type],
        :id => params[:id],
        :data => params[:data]
    }
  end

  # GET /blocks/location/
  # Список изменений блоков в указанных координатах.
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

    @blocks = Block
    @blocks = @blocks.where("x = ?", params[:x])
    @blocks = @blocks.where("y = ?", params[:y]) if params.has_key? :y
    @blocks = @blocks.where("z = ?", params[:z])
    @blocks = @blocks.where("block = ?", params[:id]) if params.has_key? :id
    @blocks = @blocks.where("data = ?", params[:data]) if params.has_key? :data
    @blocks = @blocks.where("world = ?", params[:world])
    @blocks = @blocks.where("type = ?", params[:type]) if params.has_key? :type
    @blocks = @blocks.order("id DESC")

    if params.has_key? :offset
      @blocks = @blocks.offset(params[:offset])
    end

    @count = @blocks.count()

    @blocks = @blocks.limit(100)

    if @blocks.empty?
      render :json => {
          :error => "No blocks found.",
          :offset => params[:offset],
          :x => params[:x],
          :y => params[:y],
          :z => params[:z],
          :world => params[:world],
          :type => params[:type],
          :id => params[:id],
          :data => params[:data]
      }, :status => 422
      return;
    end

    render :json => {
        :blocks => @blocks,
        :count => @count,
        :offset => params[:offset],
        :x => params[:x],
        :y => params[:y],
        :z => params[:z],
        :world => params[:world],
        :type => params[:type],
        :id => params[:id],
        :data => params[:data]
    }
  end

  # GET /blocks/player/:player/
  # Список блоков установленных игроком.
  def player
    if !params.has_key? :player
      render json: {error: "Please provide player."}, :status => 422
      return;
    end

    @blocks = Block.where("player = ?", params[:player])
    @blocks = @blocks.where("world = ?", params[:world]) if params.has_key? :world
    @blocks = @blocks.where("type = ?", params[:type]) if params.has_key? :type
    @blocks = @blocks.where("block = ?", params[:id]) if params.has_key? :id
    @blocks = @blocks.where("data = ?", params[:data]) if params.has_key? :data
    @blocks = @blocks.order("id DESC")

    if params.has_key? :offset
      @blocks = @blocks.offset(params[:offset])
    end

    @count = @blocks.count()

    @blocks = @blocks.limit(100)

    if @blocks.empty?
      render :json => {
          :error => "No blocks found.",
          :offset => params[:offset],
          :player => params[:player],
          :world => params[:world],
          :type => params[:type],
          :id => params[:id],
          :data => params[:data]
      }, :status => 422
      return;
    end

    render :json => {
        :blocks => @blocks,
        :count => @count,
        :offset => params[:offset],
        :player => params[:player],
        :world => params[:world],
        :type => params[:type],
        :id => params[:id],
        :data => params[:data]
    }

  end

end