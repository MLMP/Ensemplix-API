class V2::RegionsController < ApplicationController

  # GET /regions/
  # Информация о регионах.
  def index
    @regions = Region.all

    if params.has_key? :offset
      @regions = @regions.offset(params[:offset])
    end

    @count = @regions.count()
    @regions = @regions.limit(100)

    @regions.each do |region|
      region_name = region['region']
      world = region['world']
      region['owners'] = Owner.where("region = ? AND world = ?", region_name, world).pluck("player")
      region['members'] = Member.where("region = ? AND world = ?", region_name, world).pluck("player")
      region['flags'] = Flag.where("region = ? AND world = ?", region_name, world).pluck("flag")
      region['children'] = Child.where("parent = ? AND world = ?", region_name, world).pluck("child")
      parent = Child.select("parent").where("child = ? AND world = ?", region_name, world).take()

      if !parent.nil?
        region['parent'] = parent['parent']
      else
        region['parent'] = nil
      end
    end

    render :json => {
        :regions => @regions,
        :count => @count,
        :offset => params[:offset],
    }

  end

  # GET /region/:region/:world/
  # Информация о регионе.
  def info
    if !params.has_key? :region
      render json: {error: "Please provide region."}, :status => 422
      return;
    end

    if !params.has_key? :world
      render json: {error: "Please provide world."}, :status => 422
      return;
    end

    @region = Region.where("region = ? AND world = ?", params[:region], params[:world]).take()
    @owners = Owner.where("region = ? AND world = ?", params[:region], params[:world]).pluck("player")
    @members = Member.where("region = ? AND world = ?", params[:region], params[:world]).pluck("player")
    @flags = Flag.where("region = ? AND world = ?", params[:region], params[:world]).pluck("flag")
    @children = Child.where("parent = ? AND world = ?", params[:region], params[:world]).pluck("child")
    @parent = Child.select("parent").where("child = ? AND world = ?", params[:region], params[:world]).take()

    if @region.nil?
      render :json => {
          :error => "Region not found.",
          :region => params[:region],
          :world => params[:world]
      }, :status => 422
      return;
    end

    render :json => {
        :region => @region,
        :owners => @owners,
        :members => @members,
        :flags => @flags,
        :children => @children,
        :parent => @parent
    }
  end

  # GET /regions/location/
  # Получение информации о ближайший регионах.
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

    @regions = Region.where("min_x <= :x + 250 AND max_x > :x - 250 AND min_z < :z + 250 AND max_z > :z - 250
         AND world = :world", x: params[:x], z: params[:z], world: params[:world])

    @count = @regions.count()
    @regions = @regions.limit(100)

    if params.has_key? :offset
      @regions = @regions.offset(params[:offset])
    end

    @regions.each do |region|
      region_name = region['region']
      world = region['world']
      region['owners'] = Owner.where("region = ? AND world = ?", region_name, world).pluck("player")
      region['members'] = Member.where("region = ? AND world = ?", region_name, world).pluck("player")
      region['flags'] = Flag.where("region = ? AND world = ?", region_name, world).pluck("flag")
      region['children'] = Child.where("parent = ? AND world = ?", region_name, world).pluck("child")
      parent = Child.select("parent").where("child = ? AND world = ?", region_name, world).take()

      if !parent.nil?
        region['parent'] = parent['parent']
      else
        region['parent'] = nil
      end
    end

    if @regions.empty?
      render :json => {
          :error => "No regions found.",
          :x => params[:x],
          :z => params[:z],
          :world => params[:world]
      }, :status => 422
      return;
    end

    render :json => {
        :regions => @regions,
        :x => params[:x],
        :z => params[:z],
        :count => @count,
        :offset => params[:offset],
    }

  end

  # GET /regions/player/:player/
  # Информация о регионах игрока.
  def player
    if !params.has_key? :player
      render json: {error: "Please provide region."}, :status => 422
      return;
    end

    if !params.has_key? :world
      render json: {error: "Please provide world."}, :status => 422
      return;
    end

    @region = Region.where("region = ? AND world = ?", params[:region], params[:world]).take()
    @owners = Owner.where("region = ? AND world = ?", params[:region], params[:world]).pluck("player")
    @members = Member.where("region = ? AND world = ?", params[:region], params[:world]).pluck("player")
    @flags = Flag.where("region = ? AND world = ?", params[:region], params[:world]).pluck("flag")
    @children = Child.where("parent = ? AND world = ?", params[:region], params[:world]).pluck("child")
    @parent = Child.select("parent").where("child = ? AND world = ?", params[:region], params[:world]).take()

    if @region.nil?
      render :json => {
          :error => "Region not found.",
          :region => params[:region],
          :world => params[:world]
      }, :status => 422
      return;
    end

    render :json => {
        :region => @region,
        :owners => @owners,
        :members => @members,
        :flags => @flags,
        :children => @children,
        :parent => @parent
    }
  end

end